# Mina Setup SSH

``mina-setup_ssh`` provides SSH provisioning for [``mina``][mina-deploy].

## Requirements

``rsync`` is required (by default) to copy SSH keys during ``setup`` task.

## Configuration

The following configuration variables are available:

| Key                         | Type                    |
| --------------------------- | ----------------------- |
| ``setup_ssh_keys``          | ``Array`` or ``Hash``   |
| ``setup_ssh_sync_command `` | ``Array`` or ``String`` |
| ``setup_ssh_load_command``  | ``Array`` or ``String`` |

Depends on the following settings:

* ``user``
* ``domain``

## Executable dependencies

| Executable  |                                                 |
| ----------- | ----------------------------------------------- |
| ``rsync``   | required (as default) both on client and server |
| ``ssh-add`` | required on server                              |
| ``ssh``     | required on client (OpenSSH)                    |

## Sample ``Minafile``

```ruby
# frozen_string_literal: true

require 'mina/rails'
require 'mina/git'
require 'mina/setup_ssh/tasks'

set :application_name, 'foobar'
set :domain, '172.17.0.2'
set :user, 'root'
set :deploy_to, '/var/www/foobar.com'
set :repository, 'ssh://git@example.com:/var/git/foobar.git'
set :branch, 'master'
set :forward_agent, true

set :setup_ssh_keys, {
  git: '~/.ssh/git_rsa'
}

task :remote_environment do
  invoke :'setup:ssh:load'
end

task :setup do
  invoke :'setup:ssh:sync'
end

task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end
end
```

[mina-deploy]: https://github.com/mina-deploy
