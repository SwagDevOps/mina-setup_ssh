# frozen_string_literal: true

require 'ostruct'

# constants
describe Mina::SetupSsh::Syncer::Command, :'syncer/command' do
  it { expect(described_class).to be_const_defined(:Shell) }
end

# class methods
describe Mina::SetupSsh::Syncer::Command, :'syncer/command' do
  it { expect(described_class).to respond_to(:new).with(2).arguments }
end

# instance methods
describe Mina::SetupSsh::Syncer::Command, :'syncer/command' do
  let(:subject) do
    key = OpenStruct.new(path: __FILE__, name: 'localhost')

    described_class.new(key, user: 'john_doe', domain: 'foo.bar')
  end

  it { expect(subject).to be_a(Mina::SetupSsh::Configurable) }
  it { expect(subject).to be_a(Mina::SetupSsh::Configurable::Verbose) }

  it { expect(subject).to respond_to(:key).with(0).arguments }
  it { expect(subject).to respond_to(:variables).with(0).arguments }
  it { expect(subject).to respond_to(:pattern).with(0).arguments }
end
