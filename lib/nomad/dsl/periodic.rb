require 'nomad/dsl'

module Nomad
  module DSL
    class Periodic < Entity
      dsl_attr 'Enabled',         :boolean
      dsl_attr 'ProhibitOverlap', :boolean, default: false

      dsl_attr 'SpecType',        String, required: true
      dsl_attr 'Spec',            String, required: true
    end
  end
end
