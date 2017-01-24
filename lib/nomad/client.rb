require 'faraday'

module Nomad
  class Client
    attr_reader :options

    def initialize(options = {})

    end

    ###
    ## Jobs
    ###

    def jobs(options = {})

    end

    def job(job, options = {})

    end

    def create_job(job, options = {})

    end

    def evaluate_job(job, options = {})

    end

    def plan_job(job, options = {})

    end

    def summary_job(job, options = {})

    end

    def destroy_job(job, options = {})

    end

    ###
    ## Nodes
    ###

    def nodes(options = {})

    end

    def evaluate_node(node, options = {})

    end

    def drain_node(node, options = {})

    end

    ###
    ## Evaluations
    ###

    def evaluations(options = {})

    end

    def evaluation(evaluation, options = {})

    end

    def evaluation_allocations(evaluation, options = {})

    end

    ###
    ## Agent
    ###

    def agent_status(options = {})

    end

    def agent_join(address, options = {})

    end

    def agent_members(options = {})

    end

    def agent_force_leave(node, options = {})

    end

    def agent_servers(options = {})

    end

    def update_agent_servers(addresses, options = {})

    end


    ###
    ## Client FS
    ###

    def client_fs_read(allocation_id, path, options = {})

    end


    def client_fs_stream(allocation_id, path, options = {})

    end

    def client_fs_logs(allocation_id, task_id, options = {})

    end

    def client_fs_list(allocation_id, path, options = {})

    end

    def client_fs_stat(allocation_id, path, options = {})

    end

    ###
    ## Regions
    ###

    def regions(options = {})

    end

    ###
    ## Cluster Status
    ###

    def cluster_leader(options = {})

    end

    def cluster_peers(options = {})

    end

    ###
    ## System
    ###

    def system_gc(options = {})

    end

    def system_reconcile_summaries(options = {})

    end
  end
end
