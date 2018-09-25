# frozen_string_literal: true

require 'pathname'

# class methods
describe Mina::SetupSsh::Config, :config do
  it { expect(described_class).to respond_to(:new).with(0).arguments }
  it { expect(described_class).to respond_to(:new).with(1).arguments }

  it { expect(described_class).to respond_to(:defaults).with(0).arguments }
  it { expect(described_class).to respond_to(:identifier).with(0).arguments }
end

describe Mina::SetupSsh::Config, :config do
  let(:defaults) { described_class.defaults }

  context '.defaults' do
    it { expect(defaults).to be_a(Hash) }
  end

  # all keys are ``Symbol``
  context '.defaults.keys.map(&:class).uniq' do
    it { expect(defaults.keys.map(&:class).uniq).to eq([Symbol]) }
  end
end

describe Mina::SetupSsh::Config, :config do
  context '.new.empty?' do
    let(:override) { {} }

    it { expect(described_class.new(override).empty?).to be(false) }
  end
end

# instance methods
describe Mina::SetupSsh::Config, :config do
  it { expect(subject).to be_a(Hash) }

  it { expect(subject).to respond_to(:get).with(1).arguments }
  it { expect(subject).to respond_to(:get).with(2).arguments }
end
