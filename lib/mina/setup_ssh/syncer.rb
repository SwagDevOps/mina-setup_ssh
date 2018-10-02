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

  # Get commands.
  #
  # @return [Array]
  def commands
    keyring.values.map { |key| Command.new(key, config).freeze }
  end

  # Execute commands.
  #
  # @raise [RuntimeError]
  def call
    unless commands.empty?
      puts "-----> Setting up SSH keys (#{commands.size})"
      commands.each(&:call)
    end

    self
  end
end
