# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../setup_ssh'

# Describe a command line.
#
# Given variables are stored to be used later on  format placeholders.
# A command can be initialized from ``String`` or ``Array``, is an
# ``Array`` representation for a shell command-line.
class Mina::SetupSsh::Command < Array
  # Get variables.
  #
  # @return [Hash{Symbol => Object}]
  attr_reader :variables

  # @param [Array<String>|String] command
  # @param [Hash{Symbol => Object}] variables
  def initialize(command = [], variables = {})
    (command.is_a?(Array) ? command : self.class.split(command))
      .tap { |words| super(words) }

    @variables = variables.freeze

    self.map! { |word| (word % variables) }
  end

  # @return [Array<String>]
  def to_a
    Array.new(self)
  end

  # @return [String]
  def to_s
    self.class.join(self)
  end

  class << self
    autoload :Shellwords, 'shellwords'

    # Split given command into shell words.
    #
    # @param [String] command
    # @return [Array<string>]
    def split(command)
      Shellwords.split(command)
    end

    # Join given shell words into command-line.
    #
    # @param [Array<string>] command
    # @return [String]
    def join(command)
      Shellwords.join(command).gsub(/\\~/, '~')
    end
  end
end
