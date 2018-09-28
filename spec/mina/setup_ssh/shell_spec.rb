# frozen_string_literal: true

# instance methods
describe Mina::SetupSsh::Shell, :shell do
  it { expect(subject).to be_a(Mina::SetupSsh::Configurable) }
  it { expect(subject).to be_a(Mina::SetupSsh::Configurable::Verbose) }

  it { expect(subject).to respond_to(:sh).with_unlimited_arguments }
end
