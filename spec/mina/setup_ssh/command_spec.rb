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
end
