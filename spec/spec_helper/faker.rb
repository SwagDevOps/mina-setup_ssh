# frozen_string_literal: true

require 'faker'
require 'pathname'

# Custom ``Faker`` class
#
# @see https://github.com/stympy/faker/blob/master/lib/faker/internet.rb
# @see https://github.com/stympy/faker/blob/master/lib/faker/file.rb
class Faker::Custom < Faker::Base
  class << self
    # @param [String] base_dir
    # @return [Pathname]
    def dir(base_dir = '~/fake/')
      Pathname.new(base_dir).join(SecureRandom.hex[0..8])
    end

    # @param [String] file_name
    # @param [String] base_dir
    # @return [Pathname]
    def file_path(file_name, base_dir = '~/fake/')
      dir(base_dir).join(file_name)
    end

    # @param [String] dir
    # @return [Pathname]
    def domain_file(dir = self.dir)
      Faker::Internet.domain_name.tap do |file_name|
        return file_path(file_name, dir)
      end
    end

    # @param [Integer] count
    # @param [String] dir
    # @return [Pathname]
    def domain_files(count, dir = self.dir)
      Array.new(count).map { domain_file(dir) }
    end
  end
end
