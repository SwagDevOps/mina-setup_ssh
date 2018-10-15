# Mina Setup SSH

``mina-setup_ssh`` provides SSH provisioning for [``mina``][mina-deploy].

## Requirements

``rsync`` is required (by default) to copy SSH keys during ``setup`` task.

## Configuration

The following configuration variables are available:

| ``setup_ssh_keys``          | ``Hash|Array``   |
| ``setup_ssh_sync_command `` | ``Array|String`` |
| ``setup_ssh_load_command``  | ``Array|String`` |

Depends on the following settings:

* ``user``
* ``domain``

[mina-deploy]: https://github.com/mina-deploy
