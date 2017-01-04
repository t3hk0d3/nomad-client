require 'nomad/dsl'

module Nomad
  module DSL
    class RestartPolicy < Entity
      dsl_attr 'Attempts',        Integer
      dsl_attr 'Interval',        :interval

      dsl_attr 'Delay',           :interval
      dsl_attr 'Mode',            String, required: true, values: %w(delay fail)
    end
  end
end
