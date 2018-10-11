# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

require_relative '../setup_ssh'
require 'dry/inflector'

# Configuration
class Mina::SetupSsh::Config < Hash
  autoload :Pathname, 'pathname'
  autoload :YAML, 'yaml'

  # @param [Hash{Symbol => Object}] override
  def initialize(override = {})
    self.class.__send__(:app_config).tap do |app_config|
      self.class.defaults.merge(app_config).merge(override).each do |k, v|
        self[k] = v
      end
    end
  end

  # Get value by key (using identifier).
  #
  # @param [Symbol] key
  # @param [Object] default
  #
  # @return [Object|nil]
  def get(key, default = nil)
    "#{self.identifier}_#{key}".to_sym.tap do |k|
      return self.key?(k) ? self.fetch(k) : default
    end
  end

  # Get config (as ``Hash``) filtered by ``identifier``.
  #
  # @return [Hash{Symbol => Object}]
  def filtered
    Hash[self].keep_if { |k, v| /^#{self.identifier}_/ =~ k }
  end

  protected

  # @see .identifier
  def identifier
    self.class.identifier
  end

  class << self
    # @return [String]
    def identifier
      Dry::Inflector.new.tap do |inflector|
        self.name.split('::').fetch(1).tap do |name|
          return inflector.underscore(name)
        end
      end
    end

    # @return [Hash]
    def defaults
      YAML.safe_load(Pathname.new("#{__dir__}/config/defaults.yml").read)
          .map { |k, v| ["#{identifier}_#{k}".to_sym, v] }
          .to_h
          .merge(verbose: false)
    end

    protected

    # Acess global configuration (when it exists) variables
    #
    # @return [Hash{Symbol => Object}]
    def app_config
      Object.const_get('::Mina::Configuration').instance.variables
    rescue NameError
      {}
    end
  end
end
