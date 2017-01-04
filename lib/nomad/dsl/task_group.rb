require 'nomad/dsl'

module Nomad
  module DSL
    class TaskGroup < Entity
      dsl_attr 'Name',          String,
               required: true
      dsl_attr 'Count',         Integer

      dsl_attr 'Constraint',    Constraint,
               key: 'Constraints', array: true

      dsl_attr 'Meta',          Hash

      dsl_attr 'RestartPolicy', RestartPolicy

      dsl_attr 'Task',          Task,
               key: 'Tasks', array: true #, required: true


      def initialize(attributes = {}, &block)
        attributes = { 'Name' => attributes } if attributes.is_a?(String)

        super(attributes, &block)
      end

    end
  end
end
