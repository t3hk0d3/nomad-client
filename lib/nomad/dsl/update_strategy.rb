require 'nomad/dsl'

module Nomad
  module DSL
    class UpdateStrategy < Entity
      dsl_attr 'Stagger',       :interval
      dsl_attr 'MaxParallel',   Integer
    end
  end
end
