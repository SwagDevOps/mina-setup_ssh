# frozen_string_literal: true

# Copyright (C) 2017-2018 Dimitri Arrigoni <dimitri@arrigoni.me>
# License GPLv3+: GNU GPL version 3 or later
# <http://www.gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

Mina::SetupSsh.new.tap do |setup|
  setup.config.filtered.each { |k, v| set(k, v) }
end

desc 'Copy SSH keys to server'
task :'setup:ssh' do
  Mina::SetupSsh.new.syncer.call
end
