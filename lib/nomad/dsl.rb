module Nomad
  module DSL
    require_relative 'dsl/entity'

    require_relative 'dsl/periodic'
    require_relative 'dsl/update_strategy'
    require_relative 'dsl/constraint'

    require_relative 'dsl/artifact'
    require_relative 'dsl/log_config'

    require_relative 'dsl/network_port'
    require_relative 'dsl/network'
    require_relative 'dsl/resources'

    require_relative 'dsl/check'
    require_relative 'dsl/service'

    require_relative 'dsl/task'
    require_relative 'dsl/restart_policy'

    require_relative 'dsl/task_group'

    require_relative 'dsl/job'

  end
end
