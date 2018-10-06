# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

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
    Command: :command,
    Configurable: :configurable,
    Keyring: :keyring,
    Remote: :remote,
    Shell: :shell,
    Syncer: :syncer,
  }.each { |k, v| autoload k, "#{__dir__}/setup_ssh/#{v}" }

  include Configurable
  include Configurable::Verbose

  def syncer
    Syncer.new(config)
  end
end
