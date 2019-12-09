# DATA
source ./functions/utilities/manage_data.sh


# CODE


# Validation
validate_home_menu_response () {
    get_home_menu_response () {
        read home_menu_response

        home_menu_response_lowercase=`echo "$home_menu_response" | tr '[:upper:]' '[:lower:]'`
        validate_home_menu_response

    }

    if [ -z "$home_menu_response_lowercase" ]; then
        echo -e ":) - Whoops, you didn't enter a number. Please enter the number of the option you want to select."

        get_home_menu_response

    elif [ "$home_menu_response_lowercase" != "1" ] && [ "$home_menu_response_lowercase" != "2" ] && [ "$home_menu_response_lowercase" != "3" ]; then
        printf "\n"

        echo -e ":) - Sorry, you entered a response that I didn't understand. Please only use \"1\", \"2\", or \"3\" to select an option."

        get_home_menu_response
    fi
}

validate_store_tour () {
    get_store_tour () {
        read store_tour

        store_tour_lowercase=`echo "$store_tour" | tr '[:upper:]' '[:lower:]'`
        validate_store_tour
    }

    if [ -z "$store_tour_lowercase" ]; then
        echo -e ":) - Whoops, you didn't enter anything. Please enter either \"yes\" or \"no\" to answer."

        get_store_tour

    elif [ "$store_tour_lowercase" != "y" ] && [ "$store_tour_lowercase" != "yes" ] && [ "$store_tour_lowercase" != "n" ] && [ "$store_tour_lowercase" != "no" ]; then
        printf "\n"

        echo -e ":) - Sorry, you entered a response that I didn't understand. Please only use \"y\" or \"yes\" and \"n\" or \"no\"."

        get_store_tour
    fi
}

validate_store_menu_response () {
    get_store_menu_response () {
        read store_menu_response

        validate_store_menu_response
        store_menu_response_lowercase=`echo "$store_menu_response" | tr '[:upper:]' '[:lower:]'`
    }

    if [ -z "$store_menu_response_lowercase" ]; then
        echo -e ":) - Whoops, you didn't enter anything. Please enter either \"yes\" or \"no\" to answer."

        get_store_menu_response

    elif [ "$store_menu_response_lowercase" != "y" ] && [ "$store_menu_response_lowercase" != "yes" ] && [ "$store_menu_response_lowercase" != "n" ] && [ "$store_menu_response_lowercase" != "no" ]; then
        printf "\n"

        echo -e ":) - Sorry, you entered a response that I didn't understand. Please only use \"y\" or \"yes\" and \"n\" or \"no\"."

        get_store_menu_response
    fi
}

validate_purchase_option () {
    get_purchase_option () {
        read purchase_option

        purchase_option_lowercase=`echo "$purchase_option" | tr '[:upper:]' '[:lower:]'`
        validate_purchase_option
    }

    if [ -z "$purchase_option_lowercase" ]; then
        echo -e ":) - Whoops, you didn't enter anything. Please enter either \"purchase\" or \"exit\" to answer."

        get_purchase_option

    elif [ "$purchase_option_lowercase" != "purchase" ] && [ "$purchase_option_lowercase" != "buy" ] && [ "$purchase_option_lowercase" != "back" ] && [ "$purchase_option_lowercase" != "exit" ]; then
        printf "\n"

        echo -e ":) - Sorry, you entered a response that I didn't understand. Please only use \"purchase\" or \"buy\" and \"exit\" or \"back\"."

        get_purchase_option
    fi
}

validate_items_list () {
    item_names=()
    item_quantities=()

    get_items_list () {
        read -a items_list

        items_list_lowercase=`echo "${items_list[@]}" | tr '[:upper:]' '[:lower:]'`
        validate_items_list
    }

    if [ "${items_list_lowercase[0]}" == "exit" ]; then
        store_menu_story
    fi

    for item in ${items_list_lowercase[@]}; do
        if [[ ! $item =~ ^[0-9]+$ ]]; then
            item_names+=( "$item" )

            if [[ ! " ${store_items[@]} " =~ " ${item} " ]]; then
                printf "\n"

                echo "The item \"$item\" is invalid or doesn't exist. If you're not sure what items you want to buy, consider searching for an item before purchasing."

                get_items_list
            fi

        else
            item_quantities+=( "$item" )
        fi
    done

    if [ -z "${items_list_lowercase[@]}" ]; then
        echo "Whoops, you didn't enter any items to purchase. Please enter item names and amounts to purchase items (i.e. \"item1 1 item6 2\")."

        get_items_list

    elif [[ "${#item_names[@]}" != "${#item_quantities[@]}" ]]; then
        printf "\n"

        echo "You didn't enter valid purchase information. Please enter an amount for every item you enter (i.e. \"item1 1 item6 2\")."

        get_items_list
    fi
}

validate_search_term () {
    get_search_term () {
        read search_term

        search_term_lowercase=`echo "$search_term" | tr '[:upper:]' '[:lower:]'`
        validate_search_term
    }

    if [ "$search_term_lowercase" == "exit" ]; then
        store_menu_story

    elif [ "$search_term_lowercase" == "purchase" ] || [ "$search_term_lowercase" == "buy" ]; then
        clear
        printf "\n"

        display_store "purchase items"

    elif [ -z "$search_term_lowercase" ]; then
        echo "Whoops, you didn't enter any search terms. Please enter a search term to find an item."

        get_search_term
    
    elif [[ ! "${store_items[@]}" =~ "${search_term_lowercase}" ]]; then
        printf "\n"

        echo "There were no items matching your search terms. Please try searching again."

        get_search_term
    fi
}

validate_purchase () {
    get_items_list () {
        read -a items_list

        items_list_lowercase=`echo "${items_list[@]}" | tr '[:upper:]' '[:lower:]'`
        validate_items_list
    }

    math=`expr $user_doscoins - ${store_item_prices[$item]} \* ${item_quantities[$item]}`

    if [ "${username,,}" == "admin" ] || [ "${username,,}" == "storetour" ]; then
        return

    elif [ -z "$user_doscoins" ]; then
        printf "\n"

        echo "Your user data wasn't saved correctly. Please create a new account and try again."

        sleep 2.4

        account_signup

    elif [[ $((math)) -lt 0 ]]; then
        printf "\n"

        echo "Sorry, you don't have enough dosCOINS to purchase the item \"$item\"... You'll have to earn more dosCOINS to purchase this item."

        get_items_list        
    fi
}


# Store functions
print_store_item () {
    column_1_spaces=`expr 10 - ${#i}`
    column_2_spaces=`expr 14 - ${#store_item_categories[$i]}`
    column_3_spaces=`expr 11 - ${#store_item_prices[$i]}`

    column_1_spaces=`printf ' %.0s' $(seq 1 $column_1_spaces)`
    column_2_spaces=`printf ' %.0s' $(seq 1 $column_2_spaces)`
    column_3_spaces=`printf ' %.0s' $(seq 1 $column_3_spaces)`

    echo "         $i$column_1_spaces${store_item_categories[$i]}$column_2_spaces${store_item_prices[$i]}$column_3_spaces${store_item_descriptions[$i]}"
}

display_store () {
    declare -A store_item_categories
    declare -A store_item_prices
    declare -A store_item_descriptions

    get_store_items

    if [ "$1" == "purchase items" ]; then
        purchased_items=""
        item_prices=0

        echo "Enter the name(s) and amount(s) of the items you want to purchase: (i.e. \"item1 1 item6 2\")"
        read -a items_list

        items_list_lowercase=`echo "${items_list[@]}" | tr '[:upper:]' '[:lower:]'`
        validate_items_list

        if [ "${username,,}" == "admin" ] || [ "${username,,}" == "storetour" ]; then
            if [ "${username,,}" == "admin" ]; then
                printf "\n"

                echo "Test purchase(s) made successfully."

                sleep 1
            fi

        else
            load_user_store_data "${username,,}"

            loop=1
            printed_loop=0
            for item in ${item_names[@]}; do
                validate_purchase

                user_doscoins="$math"

                price=`expr ${store_item_prices[$item]} \* ${item_quantities[$printed_loop]}`
                if [[ "${#item_names[@]}" -eq 2 ]] && [[ `expr $loop` -eq 1 ]]; then
                    purchased_items+="${item_quantities[$printed_loop]} of \"$item\" for $price dosCOINS and "

                elif [[ `expr ${#item_names[@]} - $loop` -eq 1 ]]; then
                    purchased_items+="${item_quantities[$printed_loop]} of \"$item\" for $price dosCOINS, and "

                elif [[ `expr $loop` -ge 1 ]] && [[ "${#item_names[@]}" -gt 1 ]] && [[ `expr ${#item_names[@]} - $loop` -ge 1 ]]; then
                    purchased_items+="${item_quantities[$printed_loop]} of \"$item\" for $price dosCOINS, "

                else
                    purchased_items+="${item_quantities[$printed_loop]} of \"$item\" for $price dosCOINS"
                fi

                ((loop++))
                ((printed_loop++))
            done

            set_user_purchase_data "${username,,}" "${items_list[@]}"

            printf "\n"

            echo "Item(s) successfully purchased! You purchased $purchased_items and your remaining dosCOINS balance is $user_doscoins."

            sleep 3.6
        fi

    elif [ "$1" == "item search" ]; then
        read search_term

        search_term_lowercase=`echo "$search_term" | tr '[:upper:]' '[:lower:]'`
        validate_search_term

        printf "\n"

        echo "Here are the item(s) you searched for:"

        printf "\n"

        echo "####     NAME:     CATEGORY:     PRICE:     DESCRIPTION:      ####"

        printf "\n"
    
        for i in ${store_items[@]}; do
            if [[ "$i" =~ "${search_term_lowercase}" ]]; then
                print_store_item "items"
            fi
        done

        printf "\n"

        echo "Please enter a search term or type \"purchase\" to purchase items:"
        display_store "item search"

    elif [ "$1" == "view all" ]; then
        for i in ${store_items[@]}; do
            print_store_item
        done
    fi
}