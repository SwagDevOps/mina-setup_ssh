# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/..")

module Mina
  class Mina::SetupSsh
  end
end

require_relative 'setup_ssh/bundled'

# Setup SSH main class
class Mina::SetupSsh
  autoload :Pathname, 'pathname'

  # @return [Hash]
  attr_reader :config

  {
    VERSION: :version,
    Config: :config,
    Keyring: :keyring
  }.each { |k, v| autoload k, "#{__dir__}/setup_ssh/#{v}" }

  def initialize(config = nil)
    self.config = (config || Config.new).clone.freeze
  end

  # Denote verbose.
  #
  # @return [Boolean]
  def verbose?
    self.config.fetch(:verbose, false)
  end

  protected

  # Config.
  #
  # @type [Config]
  attr_writer :config
end
