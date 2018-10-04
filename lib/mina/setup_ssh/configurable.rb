# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../setup_ssh'

# Configurable concern.
#
# A configurable is initialized using a config (as a ``Hash``)
# and has an accessor for (reader).
module Mina::SetupSsh::Configurable
  autoload :Verbose, "#{__dir__}/configurable/verbose"

  def initialize(config = nil)
    self.config = Mina::SetupSsh::Config.new(*[config].compact).freeze
  end

  # @return [Hash]
  attr_reader :config

  protected

  # Config.
  #
  # @type [Config]
  attr_writer :config
end
