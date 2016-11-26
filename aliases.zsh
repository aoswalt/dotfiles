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


function detach() {
  #nohup wcmd "$@" &> /dev/null &
  if test -t 1; then
    exec 1> /dev/null
  fi

  if test -t 2; then
    exec 2> /dev/null
  fi

  "$@" &
}


function mux() {
  com="tmux"
  if [ $1 ]; then
    com="$com -f $1"
  fi

  eval "$com attach"
}

alias tree="tree -C"
