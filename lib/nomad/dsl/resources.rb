require 'nomad/dsl'

module Nomad
  module DSL
    class Resources < Entity
      dsl_attr 'CPU',     Integer
      dsl_attr 'Disk',    Integer, key: 'DiskMB'
      dsl_attr 'IOPS',    Integer
      dsl_attr 'Memory',  Integer, key: 'MemoryMB'

      dsl_attr 'Network', Network, key: 'Networks', array: true
    end
  end
end
