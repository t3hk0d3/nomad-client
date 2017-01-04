require 'nomad/dsl'

module Nomad
  module DSL
    class Network < Entity

      dsl_attr 'MBits',         Integer

      dsl_attr 'StaticPort',    NetworkPort, array: true, key: 'StaticPorts'
      dsl_attr 'DynamicPort',   NetworkPort, array: true, key: 'DynamicPorts'
    end
  end
end
