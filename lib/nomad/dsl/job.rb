require 'nomad/dsl'

module Nomad
  module DSL
    class Job < Entity
      dsl_attr 'ID',          String,
               required: true

      dsl_attr 'Name',        String,
               required: true

      dsl_attr 'Type',        String,
               default: 'service', values: %w(service system batch)

      dsl_attr 'Region',      String
      dsl_attr 'Priority',    Integer,
               with_in: (0..100)

      dsl_attr 'AllAtOnce',   :boolean

      dsl_attr 'Periodic',    Periodic

      dsl_attr 'Update',      UpdateStrategy

      dsl_attr 'Datacenters', String,
               required: true, array: true

      dsl_attr 'Constraint', Constraint,
               key: 'Constraints', array: true

      dsl_attr 'Group',       TaskGroup,
               key: 'TaskGroups', required: true, array: true

      dsl_attr 'Meta',        Hash


      def initialize(attributes = {}, &block)
        attributes = { 'ID' => attributes } if attributes.is_a?(String)

        super(attributes, &block)
      end

    end
  end
end
