module Nomad
  def nomad(*args, &block)
    Nomad::DSL::Job.new(*args, &block)
  end

  module_function :nomad
end
