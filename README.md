## What?

Config files used by me, including, but not limited to:

* bash
* conky (legacy)
* git
* newsbeuter
* screen (legacy)
* tmux
* vim

It's a mix of snippets found around the net and my own discoveries. Feel free
to use it any way You like, but please remember that my personal look and feel
might be different then Yours.

## How?

Deployment provisioned with ansible

```shell
ansible-playbook -i hosts playbook.yaml --ask-become-pass
```

### Bootstrapping from scratch

* Ensure `age` is available
* Ensure `ansible` is available

  For example by using `uv`:

  ```shell
  curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/home/${USER}/.local/bin" sh

  uv venv

  uv pip install ansible
  ```

  or using `uv tool`:

  ```shell
  uv tool install --with-executables-from ansible-core ansible
  ```

* Install bootstrapping requirements:

  ```shell
  ansible-playbook bootstrap.yaml --ask-become-pass
  ```
