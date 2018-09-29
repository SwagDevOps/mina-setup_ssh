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
    Configurable: :configurable,
    Keyring: :keyring,
    Shell: :shell,
    Syncer: :syncer,
  }.each { |k, v| autoload k, "#{__dir__}/setup_ssh/#{v}" }

  include Configurable
  include Configurable::Verbose

  def syncer
    Syncer.new(config)
  end
end
