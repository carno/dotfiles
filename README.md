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

