require 'nomad/dsl'

module Nomad
  module DSL
    class Constraint < Entity
      dsl_attr 'Attribute', String, required: true, key: 'LTarget'
      dsl_attr 'Operator',  String, default: '=', key: 'Operand'
      dsl_attr 'Value',     String, required: true, key: 'RTarget'

      def initialize(*args, &block)
        super(*parse_args(args), &block)
      end

      private

      def parse_args(args)
        if args.size > 1 && args.first.is_a?(String)
          value = {
            'Attribute' => args.first,
            'Value'     => args.last
          }

          value['Operator'] = args[1] if args.size > 2

          args = [value]
        end

        args
      end
    end
  end
end
