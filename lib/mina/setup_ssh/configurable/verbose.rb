# frozen_string_literal: true

require_relative '../configurable'

# Verbose concern.
module Mina::SetupSsh::Configurable::Verbose
  # Denote verbose.
  #
  # @return [Boolean]
  def verbose?
    self.config.fetch(:verbose, false)
  end
end
