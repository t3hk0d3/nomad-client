require 'nomad/dsl'

module Nomad
  module DSL
    class Service < Entity
      dsl_attr 'Name',        String, required: true
      dsl_attr 'Tags',        String, array: true
      dsl_attr 'PortLabel',   String

      dsl_attr 'Check',       Check, array: true

      def initialize(attributes = {}, &block)
        attributes = { 'Name' => attributes } if attributes.is_a?(String)

        super(attributes, &block)
      end
    end
  end
end
