# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../setup_ssh'

# Describe commands executed remotely.
#
# Almost a set of remote commands.
class Mina::SetupSsh::Remote < Array
  include Mina::SetupSsh::Configurable

  Command = Mina::SetupSsh::Command

  def initialize(*)
    super

    self.config.get(:add_command).tap do |command|
      self.keyring.each do |name, local_file|
        self.push(Command.new(command, key_name: name))
      end
    end
  end

  # Send commands to be executed remotely.
  #
  # Sample of use:
  #
  # ```
  # setup.ramote.call(self)
  # ```
  #
  # @param [Object] context
  # @return [self]
  def call(context)
    self.each do |command|
      context.public_send(:command, command.to_s)
    end

    self
  end

  protected

  # Get a SSH keyring (private keys).
  #
  # @return [Mina::SetupSsh::Keyring]
  def keyring
    config.get(:keys).tap do |keys|
      return Mina::SetupSsh::Keyring.new(keys).freeze
    end
  end
end