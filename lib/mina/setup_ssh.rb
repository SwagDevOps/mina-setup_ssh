# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/..")

module Mina
  class Mina::SetupSsh < Hash
  end
end

require_relative 'setup_ssh/bundled'

# Setup SSH main class
class Mina::SetupSsh
  autoload :Pathname, 'pathname'

  # @return [Hash]
  attr_reader :options

  {
    VERSION: :version,
    Config: :config,
  }.each { |k, v| autoload k, "#{__dir__}/setup_ssh/#{v}" }

  # A new instance of SetupSsh.
  #
  # ``ssh_keys`` can be a ``Hash`` where
  # keys are remote filenames, values are local filepaths.
  # When a simple copy is expected, an ``Array`` can be used.
  #
  # @param [Array<String>|Hash{Symbol|String => String}] ssh_keys
  # @param [Hash{Symbol => Object}] options
  def initialize(ssh_keys = {}, options = {})
    self.options = options.to_hash

    self.class.__send__(:transform, ssh_keys).each do |k, v|
      self[k] = v
    end
  end

  # Denote verbose.
  #
  # @return [Boolean]
  def verbose?
    self.options.fetch(:verbose, false)
  end

  protected

  # Options.
  #
  # @type [Hash{Symbol => Object}]
  attr_writer :options

  class << self
    protected

    # Transform keys to obtain an ``Hash``.
    #
    # Keys are remote filenames, values are local filepaths.
    #
    # @param [Array<String>|Hash{Symbol|String => String}] ssh_keys
    # @return [Hash{String => Pathname}]
    def transform(ssh_keys)
      if ssh_keys.is_a?(Array)
        ssh_keys = ssh_keys.map { |v| [Pathname.new(v).basename.to_s, v] }.to_h
      end

      ssh_keys.map do |k, v|
        begin
          [k.to_s, Pathname.new(v).expand_path.realpath]
        rescue Errno::ENOENT
          [k.to_s, Pathname.new(v).expand_path]
        end
      end.to_h
    end
  end
end
