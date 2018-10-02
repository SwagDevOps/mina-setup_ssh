# frozen_string_literal: true

Mina::SetupSsh.new.tap do |setup|
  setup.config.filtered.each { |k, v| set(k, v) }
end

desc 'Copy SSH keys to server'
task :'setup:ssh' do
  Mina::SetupSsh.new.syncer.call
end
