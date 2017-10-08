#!/bin/bash
export DISPLAY=":0"
xhost +

### Change the following setting ###
login_password="password"
username="user"
message="message"
find_app_pos="/path/to/find_app_pos.py"
####################################

function copy_and_paste() {
    echo $1 | xclip -selection clipboard
    xte "keydown Control_L"
    xte "keydown Shift_L"
    xte "keydown v"
    xte "keyup Control_L" "keyup Shift_L" "keyup v"
    sleep 2
}

function shutdown_application() {
    xte "keydown Alt_R" "keydown F4"
    xte "keyup Alt_R" "keyup F4"
}

function type_key() {
    xte "key $1"
    sleep 2
}

function mouse_click() {
    xte "mouseclick 1"
    sleep 2
}

function mouse_move() {
    xte "mousemove $1 $2"
    sleep 2
}

function type_string() {
    xte "str $1"
    sleep 2
}

# Launch
type_key "Super_L"
type_string "line"
type_key "Return"
sleep 10
# Get position of the application
result=`$find_app_pos 2>&1`
declare -a line_pos=(`echo $result | awk -F '[^0-9]+' '{for(i=1;i<=NF;i++){if($i!="") print $i}}'`)
# Login
copy_and_paste $login_password
type_key "Return"
sleep 10
# Select user
mouse_move $(expr ${line_pos[0]} + 70) $(expr ${line_pos[1]} + 70)
mouse_click
copy_and_paste $username
mouse_move $(expr ${line_pos[0]} + 70) $(expr ${line_pos[1]} + 130)
mouse_click
# Send message
copy_and_paste $message
type_key "Return"
# Shutdown
shutdown_application
