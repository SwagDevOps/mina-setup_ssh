# frozen_string_literal: true

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
