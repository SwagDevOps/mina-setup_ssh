# frozen_string_literal: true

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
    # # @return [Hash{Symbol => Object}]
    def app_config
      Object.const_get('::Mina::Configuration').instance.variables
    rescue NameError
      {}
    end
  end
end