# frozen_string_literal: true

require_relative '../syncer'

# Describe a syncer command.
#
# Some config keys are mandatory:
#
# * ``user``
# * ``domain``
class Mina::SetupSsh::Syncer::Command < Array
  include Mina::SetupSsh::Configurable
  include Mina::SetupSsh::Configurable::Verbose

  autoload :Shellwords, 'shellwords'

  # @return [Mina::SetupSsh::Keyring:;Key]
  attr_reader :key

  # Default shell.
  #
  # Shell providing ``#sh`` method.
  #
  # @see https://github.com/ruby/rake/blob/68ef9140c11d083d8bb7ee5da5b0543e3a7df73d/lib/rake/file_utils.rb#L44
  Shell = Mina::SetupSsh::Shell

  # @param [Mina::SetupSsh::Keyring::Key] key
  # @param [Hash|nil] config
  def initialize(key, config)
    super(config)

    @shell = nil
    populate(key)
  end

  # Execute command.
  #
  # @see Mina::SetupSsh::Shell#sh
  # @raise [RuntimeError]
  def call
    shell.sh(*self, verbose: verbose?)
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

  # @type [Mina::SetupSsh::Keyring::Key]
  attr_writer :shell

  # Shell used to execute command.
  #
  # @return [Mina::SetupSsh::Shell|Object]
  def shell
    self.shell = Shell.new(config) if @shell.nil?

    @shell
  end

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
