export PATH=~/bin:~/opt/bin:$PATH
export PATH=/Applications/Keybase.app/Contents/SharedSupport/bin/:$PATH
export PS1='[ \u@\h:\w ]\n\$ '

alias l="ls -lGh --color"
alias la="ls -laGh --color"
alias fd=fdfind
alias edit=nvim

export EDITOR=nvim

# The following function and completion configurations are added by
# virtualenv switcher (located at /home/vkuznetsov/envs/py3/bin).
function vs {
    `/home/vkuznetsov/envs/py3/bin/vs-bash-hook $1`
}
alias vs-off=deactivate
complete -C /home/vkuznetsov/envs/py3/bin/vs-bash-complete vs
complete -C /home/vkuznetsov/envs/py3/bin/vs-bash-complete vs-del

# This function activates one of the virtualenvs created by tox and installs
# current package there in development mode. Handy for working on python
# packages with Tox-based testing setup.
function toxenv {
    env=$1
    for try in py37 py36 py35 py27; do
        if [ "$env" == "" -a -d .tox/$try ]; then
            env=$try
        fi
    done
    if [ ! -d ".tox/$env" ]; then
        echo "No virtualenv found at .tox/$env"
        return 1
    fi
    source ".tox/$env/bin/activate"
    if [ -f setup.py ]; then
        name=$(python setup.py --name)
        pip uninstall -yq $name
        python setup.py -q develop
        echo "Activated $env and installed $name in development mode"
    else
        export PYTHONPATH=`pwd`
        echo "Activated $env and set PYTHONPATH to $PYTHONPATH"
    fi
}

# MacOS X locale fix.
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# Activate ssh-agent unless already present.
if [ "$SSH_AGENT_PID" == "" ]; then
    `ssh-agent -s`
fi

# Pyenv (see https://github.com/pyenv/pyenv)
export PATH=~/.pyenv/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
