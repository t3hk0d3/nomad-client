require 'nomad/dsl'

module Nomad
  module DSL
    class NetworkPort < Entity
      dsl_attr 'Label', String
      dsl_attr 'Value', Integer

      def initialize(*args, &block)
        super(*prepare_args(args), &block)
      end

      private

      def prepare_args(args)
        return args unless args.size > 0

        arg1 = args.first

        if arg1.is_a?(Hash) && arg1.size == 1
          hash = arg1.first
          [{ label: hash.first.to_s, value: hash.last.to_i }]
        elsif arg1.is_a?(String)
          [{ label: arg1 }]
        elsif args.size == 2
          [{ label: arg1.to_s, value: args.last.to_i }]
        else
          args
        end
      end
    end
  end
end
