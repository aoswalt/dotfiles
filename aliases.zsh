#alias ga="git add"
alias gaa="git add ."
alias gap="git add -p"
#alias gb="git branch"
#alias gc="git commit"
alias gcm="git commit -m"
alias gcam="git commit -a -m"
#alias gk="git checkout"
#alias gkb="git checkout -b"
alias gcob="git checkout -b"
alias gcom="git checkout master"
alias gl="git pull"
alias gp="git push"
alias gpo="git push origin"
alias gpom="git push origin master"
alias gs="git status"
#alias hs="http-server -i"
alias python="python3.5"
alias ssh_home="ssh adam@69.180.253.138 -p 20055"

# some more ls aliases that were being overwritten
alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias tree="tree -C"


# start web server
function webstart() {
  port=8080
  portcheck=$(netstat -n | grep $port | grep -ic listen)

  while [ ${portcheck} != 0 ]; do
    port=$(($port + 1))
    portcheck=$(netstat -n | grep $port | grep -ic listen)
  done

  screenname=webserver$port
  echo $screenname

  screen -dmS $screenname http-server -p $port
}
alias hs=webstart


# stop (kill) web server
function webstop() {
  if [ $1 ]; then
    port=$1
  else
    port=8080
  fi

  screenname=webserver$port
  screen -S $screenname -p 0 -X stuff $'\003'
}
alias hsk=webstop


# run task in background
function detach() {
  if test -t 1; then
    exec 1> /dev/null
  fi

  if test -t 2; then
    exec 2> /dev/null
  fi

  "$@" &
}


# start tmux optionally with script file
function mux() {
  if [ $1 ]; then
    file=$1
  fi

  # if the argument can't be found, try finding matches
  if [ $file ] && [ ! -f "$file" ]; then
    if [ -f "$file.tmux" ]; then
      file="$file.tmux"
    elif [ -f "$HOME/.tmux/$file" ]; then
      file="$HOME/.tmux/$file"
    elif [ -f "$HOME/.tmux/$file.tmux" ]; then
      file="$HOME/.tmux/$file.tmux"
    else
      echo "Could not find tmux script: $file"
      exit 1
    fi
  fi

  if [ $file ]; then
    file="-f $file attach"
  fi

  eval "tmux $file"
}
