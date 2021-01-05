# DATA
source ./functions/utilities/validate_response.sh
source ./functions/utilities/message_loops.sh
source ./functions/utilities/manage_data.sh

source ./functions/accounts.sh
source ./functions/store.sh


# CODE

# Validations
# validate_store_menu_response () {
#     get_store_menu_response () {
#         read store_menu_response

#         store_menu_response=`echo "$store_menu_response" | tr '[:upper:]' '[:lower:]'`
#         validate_store_menu_response
#     }

#     if [ -z "$store_menu_response" ]; then
#         echo -e ":) - Whoops, you didn't enter a number. Please enter the number of the option you want to select."

#         get_store_menu_response

#     elif [ "$store_menu_response" != "1" ] && [ "$store_menu_response" != "2" ] && [ "$store_menu_response" != "3" ]; then
#         printf "\n"

#         echo -e ":) - Sorry, you entered a response that I didn't understand. Please only use \"1\", \"2\", or \"3\" to select an option."

#         get_store_menu_response
#     fi
# }

# validate_account_settings_menu_response () {
#     get_account_settings_menu_response () {
#         read account_settings_menu_response

#         account_settings_menu_response=`echo "$account_settings_menu_response" | tr '[:upper:]' '[:lower:]'`
#         validate_account_settings_menu_response
#     }

#     if [ -z "$account_settings_menu_response" ]; then
#         echo -e ":) - Whoops, you didn't enter a number. Please enter the number of the option you want to select."

#         get_account_settings_menu_response

#     elif [ "$account_settings_menu_response" != "1" ] && [ "$account_settings_menu_response" != "2" ] && [ "$account_settings_menu_response" != "3" ] && [ "$account_settings_menu_response" != "4" ] && [ "$account_settings_menu_response" != "5" ]; then
#         printf "\n"

#         echo -e ":) - Sorry, you entered a response that I didn't understand. Please only use \"1\", \"2\" \"3\", or \"4\" to select an option."

#         get_account_settings_menu_response
#     fi
# }


# Stories

# Menu Stories
home_menu_story () {
    clear
    printf "\n"

    echo "####                      HOME DASHBOARD                      ####"
    echo -e "View the menus that are in the GLaDOS Emporium. Scroll down to the\nof the page to use the menu"

    printf "\n"

    echo "THE STORE:"
    echo "View and purchase the products in our store."

    printf "\n"

    echo "ACCOUNT SETTINGS:"
    echo "View and purchase the products in our store."

    printf "\n"

    echo "ACCOUNT SETTINGS:"
    echo "View and purchase the products in our store."

    printf "\n"

    echo "##################################################################"

    printf "\n"

    echo "####                           MENU                           ####"
    echo "Enter the number of the option you want to select it."

    printf "\n"

    echo "####                 1. Go to the store                       ####"
    echo "####                 2. Go to account settings                ####"
    echo "####                 3. Log out and exit                      ####"
    read home_menu_response

    home_menu_response=`echo "$home_menu_response" | tr '[:upper:]' '[:lower:]'`
    validate_response "$home_menu_response" "1" "2" "3"

    clear

    if [ "$home_menu_response" == "1" ]; then
        store_story

    elif [ "$home_menu_response" == "2" ]; then
        account_settings_menu_story

    elif [ "$home_menu_response" == "3" ]; then
        log_out_story
    fi
}

store_menu_story () {
    clear
    printf "\n"

    echo "####                     STORE DASHBOARD                      ####"
    echo -e "View and purchase items in the GLaDOS Emporium store. Scroll down\nto the bottom of the page to use the menu."

    printf "\n"

    echo "##################################################################"

    printf "\n"

    echo "####                        ALL ITEMS                         ####"

    printf "\n"

    echo "####     NAME:     CATEGORY:     PRICE:     DESCRIPTION:      ####"

    printf "\n"

    display_store "view all"

    printf "\n"

    echo "##################################################################"

    printf "\n"

    echo "####                  YOUR dosCOINS BALANCE:                  ####"

    printf "\n"

    load_user_store_data "${username,,}"

    space_after=`expr 31 - ${#user_doscoins}`
    space_after=`printf ' %.0s' $(seq 1 $space_after)`

    echo "####                  $user_doscoins dosCOINS$space_after####"

    printf "\n"

    echo "##################################################################"

    printf "\n"

    echo "####                        MENU                              ####"
    echo "Enter the number of the option you want to select it."

    printf "\n"

    echo "####         1. Purchase items                                ####"
    echo "####         2. Search for items                              ####"
    echo "####         3. Exit to the home dashboard                    ####"
    read store_menu_response

    store_menu_response=`echo "$store_menu_response" | tr '[:upper:]' '[:lower:]'`
    validate_response "$store_menu_response" "1" "2" "3"

    if [ "$store_menu_response" == "1" ]; then
        clear
        printf "\n"

        display_store "purchase items"

    elif [ "$store_menu_response" == "2" ]; then
        clear
        printf "\n"

        echo "Please enter a search term:"
        display_store "item search"

    elif [ "$store_menu_response" == "3" ]; then
        home_menu_story
    fi

    store_menu_story
}

account_settings_menu_story () {
    clear
    printf "\n"

    echo "####                     ACCOUNT SETTINGS                     ####"
    echo -e "Change your username or password or delete your account. Scroll\ndown to the bottom of the page to use the menu."

    printf "\n"

    echo "##################################################################"

    printf "\n"

    echo "####                  ACCOUNT INFORMATION                     ####"

    printf "\n"

    echo "####     USERNAME:      FULL NAME:        DATE OF BIRTH:      ####"

    printf "\n"

    display_account_settings "account information"

    printf "\n"

    echo "##################################################################"

    printf "\n"

    echo "####                        MENU                              ####"
    echo "Enter the number of the option you want to select it."

    printf "\n"

    echo "####         1. Change your username                          ####"
    echo "####         2. Change your password                          ####"
    echo "####         3. Update your first and last name               ####"
    echo "####         4. Update your date of birth                     ####"
    echo "####         5. Exit to the home dashboard                    ####"
    read account_settings_menu_response

    account_settings_menu_response=`echo "$account_settings_menu_response" | tr '[:upper:]' '[:lower:]'`
    validate_response "$account_settings_menu_response" "1" "2" "3" "4" "5"

    if [ "$account_settings_menu_response" == "1" ]; then
        display_account_settings "change username"

    elif [ "$account_settings_menu_response" == "2" ]; then
        display_account_settings "change password"

    elif [ "$account_settings_menu_response" == "3" ]; then
        display_account_settings "update name"

    elif [ "$account_settings_menu_response" == "4" ]; then
        display_account_settings "update dob"

    elif [ "$account_settings_menu_response" == "5" ]; then
        home_menu_story
    fi

    account_settings_menu_story
}


# Guided Stories
welcome_story () {
    clear

    cat ./logo

    sleep 0.4
    printf "\n"

    echo "WELCOME USER, PLEASE SELECT AN ACTION"

    sleep 1.4
    printf "\n"

    echo -e "Do you want to learn about the GLaDOS Emporium or go to the store? (Learn/skip)"
    read skip_tour

    skip_tour=`echo "$1" | tr '[:upper:]' '[:lower:]'`
    validate_response "$skip_tour" 'learn' 'skip'

    if [[ "$skip_tour" == "l" ]] || [[ "$skip_tour" == "learn" ]]; then
        store_tour_story
    elif [[ "$skip_tour" == "s" ]] || [[ "$skip_tour" == "skip" ]]; then
        store_story
    fi

    # sleep 4
    # printf "\n"

    # echo ":) - Now that you've arrived at the GLaDOS Emporium, you need to either create an account or sign in to your existing account."

    # sleep 3

    # echo ":) - Do you have a GLaDOS Emporium account? (y/N)"
    # read account_status

    # account_status=`echo "$account_status" | tr '[:upper:]' '[:lower:]'`
    # validate_user_account_status

    # if [ "$account_status" == "y" ] || [ "$account_status" == "yes" ]; then
    #     printf "\n"

    #     echo ":) - Great! Please log in."

    #     account_login

    # elif [ "$account_status" == "n" ] || [ "$account_status" == "no" ]; then
    #     printf "\n"

    #     echo ":) - Okay, let's create your account."

    #     account_signup
    # fi

    # sleep 2.6
}

store_story () {
    printf "\n"

    load_user_preferences "${username,,}"

    if [ "$new_user_status" == "true" ]; then
        # Start store tour

        echo ":) - Do you want a tour of the store $user_nickname?"
        read store_tour

        store_tour=`echo "$store_tour" | tr '[:upper:]' '[:lower:]'`
        validate_store_tour

        if [ "$store_tour" == 'y' ] || [ "$store_tour" == 'yes' ]; then
            store_tour_story

            save_user_preference "${username,,}" "true" "false"

            store_menu_story

        elif [ "$store_tour" == 'n' ] || [ "$store_tour" == 'no' ]; then
            save_user_preference "${username,,}" "true" "false"

            printf "\n"

            echo "Okay, but if you have any questions, make sure to ask me."

            sleep 2.2
            printf "\n"

            store_menu_story
        fi

    elif [ "$new_user_status" == "false" ]; then
        # Take user to store

        store_menu_story

    else
        # Reset user status and start over

        echo "Sorry, your user data wasn't saved correctly..."

        sleep 1.4

        new_user_status=true

        store_story
    fi
}

log_out_story () {
    printf "\n"

    echo ":) - Thank you for visiting the GLaDOS Emporium $user_nickname. We're looking forward to your next visit!"

    sleep 2.4
    printf "\n"

    message_loop_single 1 ":) - Logging out" ":) - Logging out." ":) - Logging out.." ":) - Logging out..."

    clear
    exit 1
}

store_tour_story () {
    clear
    printf "\n"

    echo "The GLaDOS Emporium store interface is easy to use, simply look through the list of items and type in the name of "

    sleep 1.4
    printf "\n"

    echo "####     NAME:     CATEGORY:     PRICE:     DESCRIPTION:      ####"

    display_store "view all"

    sleep 3.6
    printf "\n \n"

    echo ":) - This is a simple list of all the items in the store that shows you the item's name, category, price, and description."

    sleep 4.6
    printf "\n \n"

    echo "####                        MENU                              ####"
    echo "Enter the number of the option you want to select it."

    printf "\n"

    echo "####         1. Purchase items                                ####"
    echo "####         2. Search for items                              ####"
    echo "####         3. Exit to the home dashboard                    ####"

    sleep 3.6
    printf "\n \n"

    echo ":) - Here you can purchase items or search for either a category or an item directly."

    sleep 2.8
    clear
    printf "\n"

    echo ":) - Let's go through purchasing and searching items so you're familiar with how to do these things."

    sleep 1.6
    printf "\n"

    echo ":) - First let's go through purchasing an item."

    sleep 1.4
    printf "\n"

    echo ":) - For each item you purchase (i.e. \"item1\") you need to enter how many of that item you want. (i.e. \"item1 2\")"

    sleep 1.8
    printf "\n"

    # DEMO PURCHASING CODE
    declare -A store_item_prices
    declare -A store_item_descriptions

    get_store_items

    purchased_items=""
    item_prices=0

    echo "Enter the name(s) and amount(s) of the items you want to purchase: (i.e. \"item1 1 item6 2\")"
    read -a items_list

    printf "\n"

    echo ":) - As long as you entered the right items to purchase and you have enough dosCOINS to purchase them, you'll have purchased the items."

    sleep 2.6

    items_list=`echo "${items_list[@]}" | tr '[:upper:]' '[:lower:]'`
    validate_items_list

    load_user_store_data "storetour"

    loop=1
    printed_loop=0
    for item in ${item_names[@]}; do
        purchase_item

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

    printf "\n"

    echo "Item(s) successfully purchased!"

    sleep .8
    printf "\n"

    echo ":) - Once you successfully purchased the items you want, you're showed what items and the amount you bought plus your dosCOINS balance after the purchase."

    sleep 2.6
    printf "\n"

    echo "You purchased $purchased_items."

    sleep 1.2
    printf "\n"

    echo "Your dosCOINS balance is: $user_doscoins"

    sleep 1.2
    printf "\n"

    echo ":) - Now that you've walked through purchasing items, let's move on to searching for items."

    sleep 2.4
    printf "\n"

    # DEMO SEARCH CODE
    echo "Please enter a search term:"
    read search_term

    search_term=`echo "$search_term" | tr '[:upper:]' '[:lower:]'`
    validate_search_term

    echo ":) - You'll get a list similar to the store page, that shows you the names, prices, and descriptions of the items you searched for."

    sleep 3.6
    printf "\n"

    echo "Here are the item(s) you searched for:"

    printf "\n"

    echo "####   ITEM NAME:     ITEM PRICE:        ITEM DESCRIPTION:    ####"

    for i in ${store_items[@]}; do
        if [[ "$i" =~ "${search_term}" ]]; then
            print_store_item
        fi
    done

    sleep 3.6
    printf "\n"

    echo ":) - Now that we've finished the tour, let's move on to the store page so you can start purchasing items."

    sleep 2.6
}