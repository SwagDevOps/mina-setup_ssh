# frozen_string_literal: true

require 'pathname'

# class methods
describe Mina::SetupSsh::Keyring::Key, :'keyring/key' do
  it { expect(described_class).to respond_to(:new).with(1).arguments }
  it { expect(described_class).to respond_to(:new).with(2).arguments }
end

# instance methods
describe Mina::SetupSsh::Keyring::Key, :'keyring/key' do
  let(:subject) { described_class.new(__FILE__) }

  it { expect(subject).to respond_to(:path).with(0).arguments }
  it { expect(subject).to respond_to(:name).with(0).arguments }
  it { expect(subject).to respond_to(:to_s).with(0).arguments }
  it { expect(subject).to respond_to(:to_path).with(0).arguments }
end
