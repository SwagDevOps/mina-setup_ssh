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

  # @param [Mina::SetupSsh::Keyring::Key] key
  # @param [Hash|nil] config
  def initialize(_key, config)
    super(config)

    populate
  end

  def call
    # execute command (using shell)
  end

  # Get variables.
  #
  # @return [Hash{Symbol => Object}]
  def variables
    {
      local_key: key,
      remote_key: key,
      port: config.fetch(:port),
      user: config.fetch(:user),
      domain: config.fetch(:domain),
    }
  end

  protected

  def populate
    self.tap do
      config.get(:sync_command).each do |v|
        self.push(v % variables)
      end
    end
  end
end
