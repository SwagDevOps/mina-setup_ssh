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

  it { expect(subject).to be_a(Mina::SetupSsh::Command) }
  it { expect(subject).to be_a(Mina::SetupSsh::Configurable) }
  it { expect(subject).to be_a(Mina::SetupSsh::Configurable::Verbose) }

  it { expect(subject).to be_frozen }

  it { expect(subject).to respond_to(:key).with(0).arguments }
  it { expect(subject).to respond_to(:variables).with(0).arguments }
  it { expect(subject).to respond_to(:pattern).with(0).arguments }
  it { expect(subject).to respond_to(:to_s).with(0).arguments }
  it { expect(subject).to respond_to(:to_a).with(0).arguments }
end

# variables
describe Mina::SetupSsh::Syncer::Command, :'syncer/command' do
  let(:subject) do
    key = OpenStruct.new(path: __FILE__, name: 'localhost')

    described_class.new(key, user: 'john_doe', domain: 'foo.bar')
  end

  context '#variables' do
    it { expect(subject.variables).to be_a(Hash) }
    it { expect(subject.variables).to be_frozen }
  end

  context '#variables.empty?' do
    it { expect(subject.variables.empty?).to be(false) }
  end

  context '#variables.keys.sort' do
    it do
      [:domain, :key_name, :key_path, :port, :user].tap do |expected|
        expect(subject.variables.keys.sort).to eq(expected)
      end
    end
  end
end

describe Mina::SetupSsh::Syncer::Command, :'syncer/command' do
  let(:config) { { domain: 'example.com', user: 'john_doe' } }
  let(:key) { OpenStruct.new(path: '~/.ssh/foo_rsa', name: 'foo.bar') }
  let(:subject) { described_class.new(key, config) }

  context '#to_a' do
    it do
      ['rsync',
       '-q',
       '-e',
       'ssh -p 22 -o UserKnownHostsFile=/dev/null ' \
       '-o StrictHostKeyChecking=no -o LogLevel=error',
       '~/.ssh/foo_rsa',
       'john_doe@example.com:~/.ssh/foo.bar']
        .tap { |expected| expect(subject.to_a).to eq(expected) }
    end
  end

  context '#to_s' do
    it do
      'rsync -q -e ssh\\ -p\\ 22\\ -o\\ ' \
      'UserKnownHostsFile\\=/dev/null\\ -o\\ ' \
      'StrictHostKeyChecking\\=no\\ -o\\ LogLevel\\=error ' \
      '~/.ssh/foo_rsa john_doe@example.com:~/.ssh/foo.bar'
        .tap { |expected| expect(subject.to_s).to eq(expected) }
    end
  end
end

# Command ``String`` initialization
describe Mina::SetupSsh::Syncer::Command, :'syncer/command' do
  let(:key) { OpenStruct.new(path: '~/.ssh/foo_rsa', name: 'foo.bar') }
  let(:subject) { described_class.new(key, config) }
  let(:config) do
    {
      domain: 'example.com',
      user: 'john_doe',
      setup_ssh_sync_command:
        'rsync -q %<key_path>s %<user>s@%<domain>s:~/.ssh/%<key_name>s'
    }
  end

  context '#to_a' do
    it do
      ['rsync', '-q', '~/.ssh/foo_rsa',
       'john_doe@example.com:~/.ssh/foo.bar']
        .tap { |expected| expect(subject.to_a).to eq(expected) }
    end
  end

  context '#to_s' do
    it do
      'rsync -q ~/.ssh/foo_rsa ' \
      'john_doe@example.com:~/.ssh/foo.bar'
        .tap { |expected| expect(subject.to_s).to eq(expected) }
    end
  end
end
