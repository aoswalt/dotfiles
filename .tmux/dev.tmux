source ~/.tmux.conf
new-session -d -s dev -n workspace
send-keys 'vim .' 'C-m'
selectp -t 1                # Select pane 1
splitw -h -p 15             # Split pane 1 horizontally by 15%
selectp -t 2                # Select pane 2
splitw -v -p 50             # Split pane 2 vertically by 50%
selectp -t 1                # Select pane 1
#new-window -d -n terminal
attach-session -t dev
