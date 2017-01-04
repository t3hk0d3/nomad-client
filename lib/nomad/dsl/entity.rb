require 'nomad/dsl'

module Nomad
  module DSL
    class Entity
      def initialize(value = {}, &block)
        @value = deep_stringify(value, true)

        instance_eval(&block) if block
      end

      def build
        Hash[
          self.class.dsl_attrs.map do |name, options|
            unless @value.key?(name)
              raise "Required attribute '#{name}' not set" if options[:required]
              next
            end

            key   = options.fetch(:key, name)
            value = @value[name] || options[:default]

            [key, build_value(value, options)]
          end.compact
        ]
      end

      private

      def dsl_attr_set(name, *args, &block)
        options = self.class.dsl_attrs[name]
        value = normalize_value(name, options, *args, &block)

        if options[:array]
          @value[name] ||= []
          @value[name] << value
        elsif options[:type] == Hash
          @value[name] ||= {}
          @value[name].merge!(value)
        else
          @value[name] = value
        end
      end

      def normalize_value(name, options, *args, &block)
        type = options[:type]

        if type.is_a?(Class) && type < Nomad::DSL::Entity
          type.new(*args, &block)
        elsif type == Hash
          normalize_hash(name, options, type, args)
        elsif type.is_a?(Class) && type < Numeric
          normalize_numeric(name, options, type, args)
        elsif type == :boolean
          normalize_boolean(name, options, type, args)
        elsif type == :interval
          normalize_interval(name, options, type, args)
        else
          normalize_common(name, options, type, args)
        end
      end

      def normalize_numeric(name, options, type, args)
        value = args.first

        raise "Attribute '#{name}' should be #{type}" unless value.is_a?(type)

        with_in = options[:with_in]
        unless with_in.nil? || with_in.include?(value)
          raise "Attribute '#{name}' value '#{value}' doesn't match #{with_in}"
        end

        value
      end

      def normalize_common(name, options, type, args)
        value = args.first
        unless type.nil? || value.is_a?(type)
          raise "Attribute '#{name}' should be #{type}"
        end

        allowed_values = options[:values]
        unless allowed_values.nil? || allowed_values.include?(value)
          raise "Attribute '#{name}' value '#{value}' doesn't match #{allowed_values}"
        end

        value
      end

      def normalize_hash(name, _options, _type, args)
        if args.size == 1 && args.first.is_a?(Hash)
          deep_stringify(args.first)
        elsif args.size % 2 == 0
          Hash[args.each_slice(2).to_a]
        else
          raise "Invalid arguments for attribute '#{name}'"
        end
      end

      def normalize_boolean(name, _options, _type, args)
        value = args.first
        unless value.is_a?(TrueClass) || value.is_a?(FalseClass)
          raise "Attribute '#{name}' should be boolean (true/false)"
        end
        value
      end

      def normalize_interval(_name, _options, _type, args)
        # convert to nanoseconds
        args.first.to_i * 1_000_000_000
      end

      def build_value(value, options = {})
        if value.is_a?(Nomad::DSL::Entity)
          value.build
        elsif options[:array]
          value.map { |v| build_value(v) }
        else
          value
        end
      end

      def deep_stringify(hash, camelize_key = false)
        hash.each_with_object({}) do |(key, value), obj|
          key = key.to_s

          if camelize_key
            key = key.capitalize.gsub(/_[a-z]/) { |b| p b[1].upcase }
          end

          value = deep_stringify(value, camelize_key) if value.is_a?(Hash)

          obj[key] = value
        end
      end

      class << self
        def dsl_attrs
          @dsl_attrs ||= {}
        end

        def dsl_attr(name, type, options = {})
          options = options.merge(type: type)

          dsl_attrs[name] = options

          method_name = name.gsub(/([^A-Z])([A-Z])/, '\1_\2').downcase.to_sym

          define_method(method_name) do |*args, &block|
            dsl_attr_set(name, *args, &block)
          end
        end
      end
    end
  end
end
