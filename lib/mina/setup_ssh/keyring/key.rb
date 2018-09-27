# frozen_string_literal: true

require_relative '../keyring'

# Describe a (private) SSH key.
class Mina::SetupSsh::Keyring::Key
  # @return [Pathname] path
  attr_reader :path

  # @return [String] name
  attr_reader :name

  autoload :Pathname, 'pathname'
  autoload :Forwardable, 'forwardable'

  extend Forwardable

  def_delegators :path, :to_s, :to_path

  # @param [String] path
  # @param [String] name
  def initialize(path, name = nil)
    self.path = path
    self.name = name
  end

  protected

  # Set name.
  #
  # @param [String|nil] name
  def name=(name)
    @name = (name&.to_s || self.path.basename).to_s
  end

  # Set path.
  #
  # @param [Pathname] path
  def path=(path)
    @path = Pathname.new(path).expand_path.realpath
  rescue ::Errno::ENOENT
    @path = Pathname.new(path).expand_path
  end
end
