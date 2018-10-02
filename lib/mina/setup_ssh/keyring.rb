# frozen_string_literal: true

require_relative '../setup_ssh'

# Describe a keyring (a set of SSH keys).
#
# Keys are indexed by filename.
class Mina::SetupSsh::Keyring < Hash
  autoload :Pathname, 'pathname'
  autoload :Key, "#{__dir__}/keyring/key"

  # A new instance.
  #
  # ``keys`` can be a ``Hash`` where
  # keys are remote filenames, values are local filepaths.
  # When a simple copy is expected, an ``Array`` can be used.
  #
  # @param [Array<String>|Hash{Symbol|String => String}] keys
  def initialize(keys = {})
    self.class.__send__(:transform, keys).each do |k, v|
      self[k] = v
    end
  end

  class << self
    protected

    # Transform keys to obtain an ``Hash``.
    #
    # Keys are remote filenames, values are local filepaths.
    #
    # @param [Array<String>|Hash{Symbol|String => String}] keys
    # @return [Hash{String => Pathname}]
    def transform(keys)
      if keys.is_a?(Array)
        return keys.map do |v|
          key = Key.new(v)

          [key.name, key]
        end.to_h
      end

      keys.to_hash.map { |k, v| [k.to_s, Key.new(v, k.to_s)] }
    end
  end
end
