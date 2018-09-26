# frozen_string_literal: true

require_relative '../setup_ssh'

# Provides (_local_) shell capabilities.
#
# @see [Rake::FileUtilsExt]
# @see https://github.com/ruby/rake/blob/68ef9140c11d083d8bb7ee5da5b0543e3a7df73d/lib/rake/file_utils.rb#L44
class Mina::SetupSsh::Shell
  include Mina::SetupSsh::Configurable

  # Denote verbose.
  #
  # @return [Boolean]
  def verbose?
    self.config.fetch(:verbose, false)
  end

  # Run given (``cmd``) system command.
  #
  # If multiple arguments are given the command is run directly
  # without the shell,
  # similar semantics to ``Kernel::exec`` and ``Kernel::system``.
  #
  # @see [Rake::FileUtilsExt]
  # @see https://github.com/ruby/rake/blob/68ef9140c11d083d8bb7ee5da5b0543e3a7df73d/lib/rake/file_utils.rb#L44
  def sh(*cmd, &block)
    options = { verbose: self.verbose? }
              .merge(cmd.last.is_a?(Hash) ? cmd.delete_at(-1) : {})

    provider.sh(*cmd.push(options), &block)
  end

  protected

  # @return [Rake::FileUtilsExt]
  def provider
    require 'rake'
    require 'rake/file_utils'

    ::Rake::FileUtilsExt
  end
end
