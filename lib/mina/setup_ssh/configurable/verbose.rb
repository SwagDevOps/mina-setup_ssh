# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

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
