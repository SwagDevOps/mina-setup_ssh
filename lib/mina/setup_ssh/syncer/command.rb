# frozen_string_literal: true

require_relative '../syncer'

# Describe a syncer command.
#
# Some config keys are mandatory:
#
# * ``port``
# * ``user``
# * ``domain``
class Mina::SetupSsh::Syncer::Command < Array
  include Mina::SetupSsh::Configurable
  include Mina::SetupSsh::Configurable::Verbose

  autoload :Shellwords, 'shellwords'

  # @return [Mina::SetupSsh::Keyring:;Key]
  attr_reader :key

  # @param [Mina::SetupSsh::Keyring::Key] key
  # @param [Hash|nil] config
  def initialize(key, config)
    super(config)

    populate(key)
  end

  def call
    # execute command (using shell)
  end

  # Get variables.
  #
  # @return [Hash{Symbol => Object}]
  def variables
    {
      key_path: key.path,
      key_name: key.name,
      port: config.fetch(:port, 22),
      user: config.fetch(:user),
      domain: config.fetch(:domain),
    }
  end

  # Get command pattern.
  #
  # Pattern is retrieved from config.
  #
  # @return [Array<String>]
  def pattern
    config.get(:sync_command).tap do |command|
      return command.map if command.is_a?(Array)

      return Shellwords.split(command)
    end
  end

  protected

  # @type [Mina::SetupSsh::Keyring::Key]
  attr_writer :key

  # @param [Mina::SetupSsh::Keyring::Key] key
  #
  # @return [Mina::SetupSsh::Keyring::Key]
  def populate(key)
    self.key = key

    key.tap do
      pattern.each do |v|
        self.push(v % variables)
      end
    end
  end
end
