# frozen_string_literal: true

# constants
describe Mina::SetupSsh, :setup_ssh do
  it { expect(described_class).to be_const_defined(:VERSION) }
end

# class methods
describe Mina::SetupSsh, :setup_ssh do
  it { expect(described_class).to respond_to(:new).with(0).arguments }
  it { expect(described_class).to respond_to(:new).with(1).arguments }
  it { expect(described_class).to respond_to(:new).with(2).arguments }
end

# instance methods
describe Mina::SetupSsh, :setup_ssh do
  it { expect(subject).to be_a(Hash) }

  it { expect(subject).to respond_to(:verbose?).with(0).arguments }
  it { expect(subject).to respond_to(:verbose?).with(0).arguments }
end

describe Mina::SetupSsh, :setup_ssh do
  let(:config) { {} }
  let(:subject) { described_class.new({}, config) }

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

describe Mina::SetupSsh, :setup_ssh do
  context '.new.empty?' do
    let(:ssh_keys) { {} }

    it { expect(described_class.new(ssh_keys).empty?).to be(true) }
  end

  context '.new.empty?' do
    let(:ssh_keys) { [] }

    it { expect(described_class.new(ssh_keys).empty?).to be(true) }
  end
end
