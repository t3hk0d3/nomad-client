require 'spec_helper'

require 'nomad/dsl/job'

RSpec.describe Nomad::DSL::Job do

  subject do
    described_class.new do
      id 'example'
      name 'test'

      all_at_once true

      datacenters 'dc1', 'dc2'

      constraint {
        attribute 'test'
        operator '>='
        value '123'
      }

      group "test" do
        count 10
      end

      meta 'foo', 'bar'
      meta('baz' => 'pipe')

    end
  end

  describe '#build' do
    let(:result) { subject.build }


    it 'build job hash' do
      p result

      expect(result).to include(
        'ID'    => 'example',
        'Name'  => 'test'
      )
    end

  end

end