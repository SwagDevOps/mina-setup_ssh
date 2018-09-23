# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/..")

module Mina
  class Mina::SetupSsh
  end
end

require_relative 'setup_ssh/bundled'

# Setup SSH main class
class Mina::SetupSsh
  {
    VERSION: :version,
  }.each { |k, v| autoload k, "#{__dir__}/setup_ssh/#{v}" }
end
