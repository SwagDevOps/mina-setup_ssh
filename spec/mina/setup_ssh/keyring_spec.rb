# frozen_string_literal: true

require 'pathname'

# constants
describe Mina::SetupSsh::Keyring, :keyring do
  it { expect(described_class).to be_const_defined(:Key) }
end

# class methods
describe Mina::SetupSsh::Keyring, :keyring do
  it { expect(described_class).to respond_to(:new).with(0).arguments }
  it { expect(described_class).to respond_to(:new).with(1).arguments }
end

# instance methods
describe Mina::SetupSsh::Keyring, :keyring do
  it { expect(subject).to be_a(Hash) }
end

describe Mina::SetupSsh::Keyring, :keyring do
  context '.new.empty?' do
    let(:keys) { {} }

    it { expect(described_class.new(keys).empty?).to be(true) }
  end

  context '.new.empty?' do
    let(:keys) { [] }

    it { expect(described_class.new(keys).empty?).to be(true) }
  end
end

describe Mina::SetupSsh::Keyring, :keyring, :wip do
  sham!(:ssh_keys).array_faker.call.map(&:to_s).tap do |keys|
    let(:subject) { described_class.new(keys) }

    context '#empty?' do
      it { expect(subject.empty?).to be(false) }
    end

    context '#size' do
      it { expect(subject.size).to be(keys.size) }
    end

    keys.each do |key|
      context '#fetch()' do
        let(:k) { File.basename(key) }

        it { expect(subject.fetch(k)).to be_a(Mina::SetupSsh::Keyring::Key) }
      end
    end
  end
end
