# frozen_string_literal: true

# Object.const_defined?('Mina::Application')
Mina::SetupSsh.new.tap do |setup|
  desc 'Copy SSH keys to server'
  task :'setup:ssh' do
    setup.syncer.call
  end
end
