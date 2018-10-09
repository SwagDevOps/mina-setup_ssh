# frozen_string_literal: true

require 'pathname'

# class methods
describe Mina::SetupSsh::Command, :command do
  it { expect(described_class).to respond_to(:new).with(0).arguments }
  it { expect(described_class).to respond_to(:new).with(1).arguments }
  it { expect(described_class).to respond_to(:new).with(2).arguments }
end

# instance methods
describe Mina::SetupSsh::Command, :command do
  it { expect(subject).to be_a(Array) }

  it { expect(subject).to respond_to(:variables).with(0).arguments }
  it { expect(subject).to respond_to(:to_a).with(0).arguments }

  context '#variables' do
    it { expect(subject.variables).to be_a(Hash) }
  end
end

# Using ``String`` initialization
describe Mina::SetupSsh::Command, :command do
  let(:subject) { described_class.new(command, variables) }
  let(:command) { 'ssh-add ~/.ssh/%<key>s' }
  let(:variables) { { key: 'id_rsa' } }

  it { expect(subject).to eq(['ssh-add', '~/.ssh/id_rsa']) }

  context '#variables' do
    it { expect(subject.variables).to be_a(Hash) }
    it { expect(subject.variables).to eq(variables) }
  end

  context '#to_a' do
    it { expect(subject.to_a).to eq(['ssh-add', '~/.ssh/id_rsa']) }
  end
end
