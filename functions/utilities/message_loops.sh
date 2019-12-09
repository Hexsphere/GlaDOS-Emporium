message_loop_single () {
    msg_count=0
    messages=( "$2" "$3" "$4" "$5" )

    for ((msg_loop = $1 * 4; msg_loop >= 1; msg_loop--)); do
        echo -en "\r\e[K${messages[msg_count]}"
        sleep 1
        ((msg_count++))
    done

    printf "\n"
}

message_loop_multi () {
    loop1_length=$1
    messages=( "$2" "$3" "$4" )
    message_num=0

    create_message () {
        echo -en "\r\e[K${messages[$1]}"

        for ((loop1 = loop1_length; loop1 >= 1; loop1--)); do
            echo -en "\r\e[K${messages[$1]}"
            sleep 1
            echo -en "\r\e[K${messages[$1]}."
            sleep 1
            echo -en "\r\e[K${messages[$1]}.."
            sleep 1
            echo -en "\r\e[K${messages[$1]}..."
            sleep 1
        done
    }

    for ((loop2 = ${#messages[@]}; loop2 >= 1; loop2--)); do
        create_message "$message_num"

        ((message_num++))
    done

    printf "\n"
}