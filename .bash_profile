
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/Applications/eclipse/android/platform-tools:/usr/texbin:~/.lisp/systems:

alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'


export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export PATH=$PATH:/usr/local/var/rbenv/versions/2.1.1/lib/ruby/gems/2.1.0/gems/rcodetools-0.8.5.0/bin

#export CLICOLOR=1

#eval $(gdircolors ~/Documents/dircolors-solarized)


export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.7"`
PATH=${JAVA_HOME}/bin:${PATH}

export PATH=$HOME/.plenv/bin:$PATH
eval "$(plenv init -)"

export PATH=/usr/local/php5/bin:$PATH

export PATH=$HOME/.plenv/versions/5.19.11/bin/:$PATH

export PATH=/usr/local/bin:/usr/local/share/python:$PATH
