require 'nomad/dsl'

module Nomad
  module DSL
    class Artifact < Entity
      dsl_attr 'GetterSource',    String, required: true
      dsl_attr 'GetterOptions',   Hash
      dsl_attr 'RelativeDest',    String, required: true
    end
  end
end
