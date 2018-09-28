# frozen_string_literal: true

require_relative '../setup_ssh'

# Describe a sync process.
class Mina::SetupSsh::Syncer
  include Mina::SetupSsh::Configurable
  include Mina::SetupSsh::Configurable::Verbose

  autoload :Command, "#{__dir__}/syncer/command"

  # Get a SSH keyring (private keys).
  #
  # @return [Mina::SetupSsh::Keyring]
  def keyring
    config.get(:keys).tap do |keys|
      return Mina::SetupSsh::Keyring.new(keys).freeze
    end
  end

  def commands
    keyring.values.map { |key| Command.new(key, config) }
  end

  def call
    # execute process
  end
end
