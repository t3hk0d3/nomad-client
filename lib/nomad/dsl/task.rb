require 'nomad/dsl'

module Nomad
  module DSL
    class Task < Entity
      dsl_attr 'Name',        String,
               required: true

      dsl_attr 'Artifact',    Artifact,
               key: 'Artifacts', array: true

      dsl_attr 'Config',      Hash

      dsl_attr 'Constraint',  Constraint,
               key: 'Constraints', array: true

      dsl_attr 'Driver',      String,
               required: true, values: %w(docker eval qemu java)

      dsl_attr 'Env',         Hash

      dsl_attr 'KillTimeout', :interval

      dsl_attr 'LogConfig',   LogConfig

      dsl_attr 'Meta',        Hash

      dsl_attr 'Resources',   Resources

      dsl_attr 'Service',     Service,
               key: 'Services', array: true

      dsl_attr 'User',        String

      def initialize(attributes = {}, &block)
        attributes = { 'Name' => attributes } if attributes.is_a?(String)

        super(attributes, &block)
      end
    end
  end
end
