################################################################################################################
# echo functions
################################################################################################################
function repeat_char() {
    local char=$1
    local count=$2
    local i=0
    while [ $i -lt $count ]; do
        echo -n "$char"
        ((i = i + 1))
    done
}

function title_in_center() {
    local text=$1
    local terminalCols=$(tput cols)
    echo "$(repeat_char '#' $terminalCols)"
    echo "$(repeat_char ' ' $(((terminalCols - ${#text}) / 2 - 1))) $text"
    echo "$(repeat_char '#' $terminalCols)"
}

function echo_in_center() {
    local terminalCols=$(tput cols)

    if [ $# -eq 2 ]; then
        local text=$2
        if [ $1 == "-ne" ]; then
            echo -ne "$(repeat_char ' ' $(((terminalCols - ${#text}) / 2 - 1))) $text"
        elif [ $1 == "-e" ]; then
            echo -e "$(repeat_char ' ' $(((terminalCols - ${#text}) / 2 - 1))) $text"
        else
            echo "$(repeat_char ' ' $(((terminalCols - ${#text}) / 2 - 1))) $text"
        fi
    elif [ $# -eq 1 ]; then
        local text=$1
        echo "$(repeat_char ' ' $(((terminalCols - ${#text}) / 2 - 1))) $text"
    else
        echo "error in arguments"
        exit 1
    fi
}

function echo_progressBar() {

    local progress=$1
    local fullProgress=$2
    local terminalCols=$(($(tput cols)-10))

    percentage=$(( (progress * 100) / (fullProgress) ))
    # terminalCols => 100%
    # progressBar => $percentage
    ratio=$(( (percentage*terminalCols)/100 ))
	progressBar=$( repeat_char = $ratio )
    left=$((terminalCols - ratio))
	leftBar=$( repeat_char ' ' $left )
	echo_in_center -ne "[$progressBar>$leftBar]($percentage%)\r"
}
