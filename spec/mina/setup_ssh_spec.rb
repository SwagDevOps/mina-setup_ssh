# frozen_string_literal: true

require 'pathname'

# constants
describe Mina::SetupSsh, :setup_ssh do
  it { expect(described_class).to be_const_defined(:VERSION) }
  it { expect(described_class).to be_const_defined(:Config) }
  it { expect(described_class).to be_const_defined(:Keyring) }
end

# class methods
describe Mina::SetupSsh, :setup_ssh do
  it { expect(described_class).to respond_to(:bundled?).with(0).arguments }

  it { expect(described_class).to respond_to(:new).with(0).arguments }
  it { expect(described_class).to respond_to(:new).with(1).arguments }

  context '.bundled?' do
    it { expect(described_class.bundled?).to be(true) }
  end
end

# instance methods
describe Mina::SetupSsh, :setup_ssh do
  it { expect(subject).to respond_to(:verbose?).with(0).arguments }
  it { expect(subject).to respond_to(:verbose?).with(0).arguments }
end

describe Mina::SetupSsh, :setup_ssh do
  let(:config) { {} }
  let(:subject) { described_class.new(config) }

  context '#verbose?' do
    it { expect(subject.verbose?).to be(false) }
  end

  context '#verbose?' do
    let(:config) { { verbose: false } }

    it { expect(subject.verbose?).to be(false) }
  end

  context '#verbose?' do
    let(:config) { { verbose: true } }

    it { expect(subject.verbose?).to be(true) }
  end
end
