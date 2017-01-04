# Nomad::Client

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/nomad/client`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nomad-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nomad-client

## Usage

### DSL Example

```ruby
require 'nomad/dsl'

Nomad.job 'example' do
  name 'Example'
  region 'global'
  type 'batch'
  priority 50
  all_at_once false

  datacenters "dc1", "dc2"

  constraint '${attr.kernel.name}', '=', 'linux'

  update do
    stagger: 10 # seconds
    max_parallel: 1
  end

  periodic do
    enabled: true
    spec: "* * * * *"
    spec_type: 'cron'
    prohibit_overlap true
  end

  meta "foo", "bar"
  meta "baz", "pipe"

  group "cache" do
    count 1

    task "redis" do
      driver 'docker'
      user 'foo-user'

      config 'image', 'redis:lastest'
      config(port_map: { db: 6479 })

      env "foo", "bar"
      env(baz: 'pipe')

      service "cache-redis" do
        tags "global", "cache"
        port_label 'db'
        check "redis-cache-check" do
            name "alive"
            type "tcp"
            interval 10 # seconds
            timeout 20
        end
      end

      resources do
        cpu 500
        memory 256
        disk 300
        iops 0

        network do
          mbits 10

          static_port "rpc", 25566
          dynamic_port "db"
        end
      end

      meta "foo", "bar",
           "baz", "pipe"

      kill_timeout 50 # seconds

      log_config do
        max_files 10
        max_files_size 10 # MB
      end

      artifact do
        getter_source "http://foo.com/artifact.tar.gz"
        getter_options(checksum: 'md5:c4aa853ad2215426eb7d70a21922e794')

        relative_dest 'local/'
      end
    end
  end
end
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

