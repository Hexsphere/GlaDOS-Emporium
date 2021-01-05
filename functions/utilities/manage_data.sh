# USER DATA MANAGEMENT
register_user () {
    # WRITE VARIABLES
    echo -e "${registered_users[@]}\n${registered_passwords[@]}" >./data/registered_users
    echo -e "10000\n\n" >./data/user_data/$1_user_data
    echo -e "$firstname $lastname\n$user_nickname\n$dob\ntrue" >./data/user_preferences/$1_user_preferences
}

update_registered_user () {
    # WRITE UPDATED USERNAMES AND/OR PASSWORDS
    echo -e "${registered_users[@]}\n${registered_passwords[@]}" >./data/registered_users

     # IF UPDATED USERNAME UPDATE USER DATA AND PREFERENCES
    if [ "$1" == "update username" ]; then
        user_preferences_file="./data/user_preferences/"${username,,}"_user_preferences"
        user_data_file="./data/user_data/"${username,,}"_user_data"

        if [ -f "$user_preferences_file" ] && [ -f "$user_data_file" ]; then
            mv "$user_preferences_file" "./data/user_preferences/"${new_username,,}"_user_preferences"
            mv "$user_data_file" "./data/user_data/"${new_username,,}"_user_data"

        else
            printf "\n"

            echo ":) - Sorry, your user data wasn't saved correctly. Please create a new account and try again."

            sleep 2.4

            account_signup
        fi

        # UPDATE CURRENT USERNAME WITH UPDATED USERNAME
        username="$new_username"
    fi
}

save_user_preference () {
    file="./data/user_preferences/$1_user_preferences"

    if [[ -f "$file" ]]; then
        sed -i "s/$2/$3/g" $file

    else
        printf "\n"

        echo ":) - Sorry, your user data wasn't saved correctly. Please create a new account and try again."

        sleep 2.4

        account_signup
    fi
}

load_user_preferences () {
    file="./data/user_preferences/$1_user_preferences"

    if [[ -f "$file" ]]; then
        # READ USER PREFERENCES
        { read full_name; read user_nickname; read user_dob; read new_user_status; } <"$file"

    else
        printf "\n"

        echo ":) - Sorry, your user data wasn't saved correctly. Please create a new account and try again."

        sleep 2.4

        account_signup
    fi
}

load_user_store_data () {
    file="./data/user_data/$1_user_data"

    if [[ -f "$file" ]]; then
        # READ USER DATA
        { read user_doscoins; read -a user_purchased_items; read -a user_purchased_items_quantity; } <"$file"

        # CREATE DATA HIERARCHY
        loop=0
        for purchaseItem in ${user_purchased_items[@]}; do
            user_purchase_data[$purchaseItem]+=${user_purchased_items_quantity[loop]}

            # declare -p user_purchase_data
            ((loop++))
        done

        # echo ${user_purchase_data[${user_purchased_items[1]}]}
    else
        printf "\n"

        echo ":) - Sorry, your user data wasn't saved correctly. Please create a new account and try again."

        sleep 2.4

        account_signup
    fi
}

# STORE DATA MANAGEMENT
get_store_items () {
    file="./data/store_items"

    if [[ -f "$file" ]]; then
        # READ STORE DATA
        { read -a store_items; read -a temp_store_item_categories; read -a temp_store_item_prices; read -a temp_store_item_descriptions; } <"$file"

        # CREATE DATA HIERARCHY

        loop=0
        for storeItem in ${store_items[@]}; do
            store_item_categories["$storeItem"]+="${temp_store_item_categories[loop]}"
            store_item_prices["$storeItem"]+="${temp_store_item_prices[loop]}"
            store_item_descriptions["$storeItem"]+=`echo "${temp_store_item_descriptions[loop]//_/$' '}"`

            ((loop++))
        done

    else
        printf "\n"

        echo ":) - The store data doesn't exist. Please contact the GLaDOS Emporium admins for help."

        sleep 2.4
    fi
}

set_user_purchase_data () {
    file="./data/user_data/$1_user_data"

    if [[ -f "$file" ]]; then
        # SET LOCAL ARRAYS
        local item_quantities=()
        local items=()

        # CREATE USER DATA ARRAYS
        for item in ${items_list[@]}; do
            if [[ $item =~ ^[0-9]+$ ]]; then
                item_quantities+=( $item )

            else
                items+=( $item )
            fi
        done

        # WRITE DATA TO FILE
        { echo "$user_doscoins"; echo "${items[@]}"; echo "${item_quantities[@]}"; } >"$file"
    else
        printf "\n"

        echo ":) - Sorry, your user data wasn't saved correctly. Please create a new account and try again."

        sleep 2.4

        account_signup
    fi
}