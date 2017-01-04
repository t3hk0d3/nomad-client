require 'nomad/dsl'

module Nomad
  module DSL
    class Check < Entity
      dsl_attr 'Name',      String
      dsl_attr 'Type',      String, values: %w(script http tcp), required: true
      dsl_attr 'Interval',  :interval
      dsl_attr 'Timeout',   :interval
      dsl_attr 'Path',      String
      dsl_attr 'Protocol',  String
      dsl_attr 'Command',   String
      dsl_attr 'Args',      String, array: true

      def initialize(attributes = {}, &block)
        attributes = { 'Name' => attributes } if attributes.is_a?(String)

        super(attributes, &block)
      end

    end
  end
end
