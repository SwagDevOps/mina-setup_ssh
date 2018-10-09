# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../setup_ssh'

# Describe a command line.
#
# Given variables are ...
class Mina::SetupSsh::Command < Array
  autoload :Shellwords, 'shellwords'

  # Get variables.
  #
  # @return [Hash{Symbol => Object}]
  attr_reader :variables

  # @param [Array<String>|String] command
  # @param [Hash{Symbol => Object}] variables
  def initialize(command = [], variables = {})
    (command.is_a?(Array) ? command : Shellwords.split(command))
      .tap { |words| super(words) }

    @variables = variables

    self.map! { |word| (word % variables).gsub(/^\\~/, '~') }
  end

  # @return [Array<String>]
  def to_a
    Array.new(self)
  end

  # @return [String]
  def to_s
    Shellwords.join(self).gsub(/\s+\\~/, ' ~')
  end
end
