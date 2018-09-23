# frozen_string_literal: true

# rubocop:disable Style/Documentation

require_relative '../setup_ssh'

class Mina::SetupSsh
  class << self
    # Denote ``Bundler`` use (vendoring).
    #
    # @return [Boolean]
    def bundled?
      Dir.chdir("#{__dir__}/../..") do
        [['gems.rb', 'gems.locked'], ['Gemfile', 'Gemfile.lock']]
          .map { |m| 2 == Dir.glob(m).size }
          .include?(true)
      end
    end
  end
end

# rubocop:enable Style/Documentation

if Mina::SetupSsh.bundled?
  %w[rubygems bundler/setup].each { |req| require req }

  if Gem::Specification.find_all_by_name('kamaze-project').any?
    require 'kamaze/project/core_ext/pp'
  end
end
