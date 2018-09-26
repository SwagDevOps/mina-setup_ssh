# frozen_string_literal: true

# constants
describe Mina::SetupSsh::Configurable, :configurable do
  it { expect(described_class).to be_const_defined(:Verbose) }
end

describe Class, :configurable do
  let(:subject) do
    Class.new { include Mina::SetupSsh::Configurable }.new
  end

  it { expect(subject).to respond_to(:config).with(0).arguments }
end
