# frozen_string_literal: true

require_relative '../setup_ssh'

# Describe a keyring (a set of SSH keys).
#
# Keys are indexed by filename.
class Mina::SetupSsh::Keyring < Hash
  autoload :Pathname, 'pathname'

  # A new instance.
  #
  # ``keys`` can be a ``Hash`` where
  # keys are remote filenames, values are local filepaths.
  # When a simple copy is expected, an ``Array`` can be used.
  #
  # @param [Array<String>|Hash{Symbol|String => String}] ssh_keys
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
        keys = keys.map { |v| [Pathname.new(v).basename.to_s, v] }.to_h
      end

      keys.map do |k, v|
        begin
          [k.to_s, Pathname.new(v).expand_path.realpath]
        rescue Errno::ENOENT
          [k.to_s, Pathname.new(v).expand_path]
        end
      end.to_h
    end
  end
end
