require 'nomad/dsl'

module Nomad
  module DSL
    class LogConfig < Entity
      dsl_attr 'MaxFiles',    Integer
      dsl_attr 'MaxFileSize', Integer, key: 'MaxFileSizeMB'
    end
  end
end
