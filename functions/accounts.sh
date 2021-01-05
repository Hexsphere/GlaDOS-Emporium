# DATA
source ./functions/utilities/read_password.sh
source ./functions/utilities/manage_data.sh

{ read -a registered_users; read -a registered_passwords; } <./data/registered_users


# CODE


# Validation
validate_user_account_status () {
    get_user_account_status () {
        read account_status

        account_status_lowercase=`echo "$account_status" | tr '[:upper:]' '[:lower:]'`
        validate_user_account_status
    }

    if [ -z "$account_status_lowercase" ]; then
        echo -e ":) - Whoops, you didn't enter anything. Please enter either \"yes\" or \"no\" to answer."

        get_user_account_status

    elif [ "$account_status_lowercase" != "y" ] && [ "$account_status_lowercase" != "yes" ] && [ "$account_status_lowercase" != "n" ] && [ "$account_status_lowercase" != "no" ]; then
        printf "\n"

        echo -e ":) - Sorry, you entered a response that I didn't understand. Please only use \"y\" or \"yes\" and \"n\" or \"no\"."

        get_user_account_status
    fi
}

validate_username () {
    get_username () {
        read username

        validate_username "$1"
    }

    if [ "$1" == "signup" ] && [ "$username" == "admin" ]; then
        printf "\n"

        echo -e ":) - Sorry, the username \"$username\" is reserved for the system. Please choose another username or enter \"exit\" to exit this menu."

        get_username "signup"

    elif [ -z "$username" ]; then
        echo -e ":) - Whoops, you didn't enter a username. Please enter a username or enter \"exit\" to exit this menu."

        get_username

    elif [ "$1" == "signup" ] && [[ "${#username}" -lt 8 ]]; then
        printf "\n"

        echo ":) - Please enter a username that's longer than 8 characters."

        get_username

    elif [ "$1" == "login" ] && [[ ! "${registered_users[@],,}" =~ "${username,,}" ]]; then
        printf "\n"

        echo -e ":) - Sorry, the username you entered doesn't exist in our records. Please try again or enter \"exit\" to exit this menu."

        get_username "login"

    elif [ "$1" == "signup" ] && [[ " ${registered_users[@],,} " =~ " ${username,,} " ]]; then
        printf "\n"

        echo -e ":) - Sorry, the username you entered is already taken. Please try again or enter \"exit\" to exit this menu."

        get_username "signup"
    fi
}

validate_username_confirm () {
    get_username_confirm () {
        read username_confirm

        validate_username_confirm
        username_confirm_lowercase=`echo "$username_confirm" | tr '[:upper:]' '[:lower:]'`
    }

    if [ -z "$username_confirm_lowercase" ]; then
        echo -e ":) - Whoops, you didn't enter anything. Please enter either \"yes\" or \"no\" to answer."

        get_username_confirm

    elif [ "$username_confirm_lowercase" != "y" ] && [ "$username_confirm_lowercase" != "yes" ] && [ "$username_confirm_lowercase" != "n" ] && [ "$username_confirm_lowercase" != "no" ]; then
        printf "\n"

        echo -e ":) - Sorry, you entered a response that I didn't understand. Please only use \"y\" or \"yes\" and \"n\" or \"no\"."

        get_username_confirm
    fi
}

validate_password () {
    get_password () {
        read_password

        password_encrypted=`echo $password | base64`
        validate_password "$1"
    }

    if [ "$1" == "signup" ] && [ "$password" == "pass123" ]; then
        printf "\n"

        echo -e ":) - Sorry, the password you entered is reserved for the system. Please enter another password or enter \"exit\" to exit this menu."

        get_password "signup"

    elif [ -z "$password" ]; then
        echo -e ":) - Whoops, you didn't enter a password. Please enter a password or enter \"exit\" to exit this menu."

        get_password

    elif [ "$1" == "login" ] && [[ ! " ${registered_passwords[@]} " =~ " ${password_encrypted} " ]]; then
        printf "\n"

        echo -e ":) - Sorry, the password you entered doesn't exist in our records. Please try again or enter \"exit\" to exit this menu."

        get_password "login"

    elif [ "$1" == "signup" ] && [[ ${#password} -lt 8 ]]; then
        printf "\n"

        echo ":) - Please enter a password that's longer than 8 characters."

        get_password
    fi
}

validate_user_account_data () {
    get_user_data () {
        read $1 $2 $3

        validate_user_account_data
    }

    users_dob=`echo "${dob:(-4)}"`
    current_year=$(date "+%Y")

    if [ -z "$firstname" ] && [ -z "$lastname" ] && [ -z "$dob" ]; then
        echo ":) - Whoops, you didn't enter anything. Please enter your firstname and lastname and your date of birth (i.e. DD.MM.YYYY):"

        get_user_data "firstname" "lastname" "dob"

    elif [ -z "$firstname" ]; then
        echo ":) - Whoops, you didn't enter a first name, please enter your first name:"

        get_user_data "firstname"

    elif [ -z "$lastname" ]; then
        echo ":) - Whoops, you didn't enter a last name, please enter your last name:"

        get_user_data "lastname"

    elif [ -z "$dob" ]; then
        echo ":) - Whoops, you didn't enter a date of birth, please enter your date of birth (i.e. DD.MM.YYYY):"

        get_user_data "dob"

    elif [[ ${#dob} -lt 9 ]]; then
        printf "\n"

        echo ":) - You didn't enter a valid date of birth. Please enter a valid date of birth (i.e. DD.MM.YYYY):"

        get_user_data "dob"
    elif [[ $((current_year - users_dob)) -lt 12 ]]; then
        printf "\n"

        echo ":) - Sorry, the date of birth you entered makes you too young to create a GLaDOS Emporium account. Please enter a date of birth (i.e. DD.MM.YYYY):"

        get_user_data "dob"
    fi
}

validate_user_name_preference () {
    get_user_name_preference () {
        read user_name_preference

        user_name_preference_lowercase=`echo "$user_name_preference" | tr '[:upper:]' '[:lower:]'`
        validate_user_name_preference
    }

    if [ -z "$user_name_preference_lowercase" ]; then
        echo -e ":) - Whoops, you didn't specify what I should call you. Please enter either \"first name\", \"last name\", or \"username\" to answer."

        get_user_name_preference

    elif [ "$user_name_preference_lowercase" != "firstname" ] && [ "$user_name_preference_lowercase" != "first name" ] && [ "$user_name_preference_lowercase" != "firstname" ] && [ "$user_name_preference_lowercase" != "first name" ] && [ "$user_name_preference_lowercase" != "username" ]; then
        printf "\n"

        echo -e ":) - Sorry, you entered a response that I didn't understand. Please only enter \"first name\", \"last name\", or \"username\"."

        get_user_name_preference
    fi
}

validate_new_username () {
    get_new_username () {
        read new_username

        new_username_lowercase=`echo "$new_username" | tr '[:upper:]' '[:lower:]'`
        validate_new_username
    }

    if [ "$new_username" == "exit" ]; then
        account_settings_menu_story

    elif [ "$new_username" == "admin" ]; then
        printf "\n"

        echo -e ":) - Sorry, the username \"$new_username\" is reserved for the system. Please choose another username or enter \"exit\" to exit this menu."

        get_new_username

    elif [ -z "$new_username" ]; then
        echo -e "Whoops, you didn't enter anything. Please enter a new username or enter \"exit\" to exit this menu."

        get_new_username

    elif [[ ${#new_username} -lt 8 ]]; then
        printf "\n"

        echo ":) - Please enter a username that's longer than 8 characters."

        get_new_username

    elif [ "${new_username,,}" == "${username,,}" ]; then
        printf "\n"

        echo "You can't enter your current username as your new username."

        get_new_username

    elif [[ " ${registered_users[@],,} " =~ " ${new_username,,} " ]]; then
        printf "\n"

        echo "Sorry, the username you entered is already taken."

        get_new_username
    fi
}

validate_new_password () {
    get_new_password () {
        read_password

        new_password_encrypted=`echo "$password" | base64`
        validate_new_password
    }

    if [ "$password" == "exit" ]; then
        account_settings_menu_story

    elif [ "$new_password_encrypted" == "admin" ]; then
        printf "\n"

        echo -e ":) - Sorry, the password \"$password\" is reserved for the system. Please choose another password or enter \"exit\" to exit this menu."

        get_new_password

    elif [ -z "$password" ]; then
        echo -e "Whoops, you didn't enter anything. Please enter a new password or enter \"exit\" to exit this menu."

        get_new_password

    elif [[ ${#password} -lt 8 ]]; then
        printf "\n"

        echo ":) - Please enter a password that's longer than 8 characters."

        get_new_password

    elif [ "${new_password_encrypted}" == "${current_user_password}" ]; then
        printf "\n"

        echo "You can't enter your current password as your new password."

        get_new_password

    elif [[ " ${registered_passwords[@],,} " =~ " ${new_password,,} " ]]; then
        printf "\n"

        echo "Sorry, the password you entered is already taken."

        get_new_password
    fi
}

validate_new_full_name () {
    get_new_full_name () {
        read new_first_name new_last_name

        new_first_name_lowercase=`echo "$new_first_name" | tr '[:upper:]' '[:lower:]'`
        new_last_name_lowercase=`echo "$new_last_name" | tr '[:upper:]' '[:lower:]'`
        validate_new_full_name
    }

    if [ "$new_first_name_lowercase" == "exit" ]; then
        account_settings_menu_story

    elif [ -z "$new_first_name_lowercase" ] && [ -z "$new_last_name_lowercase" ]; then
        echo -e "Whoops, you didn't enter anything. Please enter a new first and last name or enter \"exit\" to exit this menu."

        get_new_full_name

    elif [ -z "$new_first_name_lowercase" ] || [ -z "$new_last_name_lowercase" ]; then
        printf "\n"

        echo -e "Whoops, you didn't enter both a new first and last name. Please enter a new first and last name or enter \"exit\" to exit this menu."

        get_new_full_name

    elif [ "$new_first_name_lowercase $new_last_name_lowercase" == "${firstname,,} ${lastname,,}" ]; then
        printf "\n"

        echo "You can't enter your current first and last names as your new ones. Please enter a new first and last name or enter \"exit\" to exit this menu."

        get_new_full_name
    fi
}

validate_new_dob () {
    get_new_dob () {
        read new_dob

        new_dob_lowercase=`echo "$new_dob" | tr '[:upper:]' '[:lower:]'`
        validate_new_dob
    }

    users_dob=`echo "${new_dob_lowercase:(-4)}"`
    current_year=$(date "+%Y")

    if [ "$new_dob_lowercase" == "exit" ]; then
        account_settings_menu_story

    elif [ -z "$new_dob_lowercase" ]; then
        echo -e "Whoops, you didn't enter anything. Please enter a new date of birth (i.e. DD.MM.YYYY) or enter \"exit\" to exit this menu."

        get_new_dob

    elif [ "${new_dob_lowercase}" == "${user_dob,,}" ]; then
        printf "\n"

        echo "You can't enter your current date of birth as your new one. Please enter a new date of birth (i.e. DD.MM.YYYY) or enter \"exit\" to exit this menu."

        get_new_dob

    elif [[ $((current_year - users_dob)) -lt 12 ]]; then
        printf "\n"

        echo ":) - Sorry, the date of birth you entered makes you too young to use a GLaDOS Emporium account. Please enter a new date of birth (i.e. DD.MM.YYYY) or enter \"exit\" to exit this menu."

        get_new_dob
    fi
}


# Login & Signup
account_login () {
    sleep 1.6
    clear
    printf "\n"

    # GET USERNAME

    echo ":) - Please enter your username:"
    read username

    validate_username "login"

    printf "\n"

    # GET PASSWORD

    echo ":) - Please enter your password, $username:"
    read_password

    password_encrypted=`echo $password | base64`
    validate_password "login"

    current_user_password="$password_encrypted"

    load_user_preferences "${username,,}"

    printf "\n"

    echo "Login successful! Welcome back to the GLaDOS Emporium, $user_nickname."
}

account_signup () {
    sleep 2
    clear
    printf "\n"

    echo ":) - To create a GLaDOS Emporium account, you need to enter your first and last name, your date of birth along with your username and password."

    sleep 2.8
    printf "\n"

    # GET FIRST NAME LAST NAME AND DATE OF BIRTH

    echo ":) - Start by entering your first and lastname and your date of birth in that order: (Your date of birth must be in the DD.MM.YYYY format.)"
    read firstname lastname dob

    validate_user_account_data

    printf "\n"

    # GET USERNAME

    echo ":) - Next $firstname, enter a username for your account:"
    read username

    validate_username "signup"

    printf "\n"

    # CONFIRM USERNAME

    echo ":) - Are you sure you want this to be your username? (Y/n) (Note: You can change it later in account settings if you want.)"
    read username_confirm

    username_confirm_lowercase=`echo "$username_confirm" | tr '[:upper:]' '[:lower:]'`
    validate_username_confirm

    if [ "$username_confirm_lowercase" == "y" ] || [ "$username_confirm_lowercase" == "yes" ]; then
        printf "\n"

        echo ":) - Okay then. Still know you can change your username later in your account settings."

        sleep 1.6

    elif [ "$username_confirm_lowercase" == "n" ] || [ "$username_confirm_lowercase" == "no" ]; then
        printf "\n"

        echo ":) - Alright $firstname, enter a username."
        read username

        validate_username "signup"
    fi

    registered_users+=( $username )

    printf "\n"

    # GET PASSWORD

    echo ":) - Last $firstname, enter a password: (Make sure it's more than 8 characters long.)"
    read_password

    password_encrypted=`echo $password | base64`
    validate_password "signup"

    registered_passwords+=( "$password_encrypted" )

    printf "\n"

    # GET USER NICKNAME

    echo "One more thing $firstname, do you want me to call you by your first name, last name, or username?"
    read user_name_preference

    user_name_preference_lowercase=`echo "$user_name_preference" | tr '[:upper:]' '[:lower:]'`
    validate_user_name_preference

    if [ "$user_name_preference_lowercase" == "firstname" ] || [ "$user_name_preference_lowercase" == "first name" ]; then
        user_nickname=$firstname

    elif [ "$user_name_preference_lowercase" == "lastname" ] || [ "$user_name_preference_lowercase" == "last name" ]; then
        user_nickname=$lastname

    elif [ "$user_name_preference_lowercase" == "username" ]; then
        user_nickname=$username
    fi

    register_user "${username,,}"

    printf "\n"

    echo ":) - Signup successful! Welcome to the GLaDOS Emporium, $user_nickname."
}


# Account Settings
display_account_settings () {
    printf "\n"

    if [ "$1" == "change username" ]; then
        echo "Please enter a new username, $user_nickname:"
        read new_username

        new_username_lowercase=`echo "$new_username" | tr '[:upper:]' '[:lower:]'`
        validate_new_username

        loop=0
        for user in ${registered_users[@]}; do
            if [[ "$user" == "$username" ]]; then
               registered_users[$loop]="$new_username"
            fi
            ((loop++))
        done

        update_registered_user "update username"

        printf "\n"

        echo "Your username was successfully changed."

        sleep 1.6

    elif [ "$1" == "change password" ]; then
        echo "Please enter a new password, $user_nickname:"
        read_password

        new_password_encrypted=`echo "$password" | base64`
        validate_new_password

        loop=0
        for pass in ${registered_passwords[@]}; do
            if [[ "$pass" == "$current_user_password" ]]; then
               registered_passwords[$loop]="$new_password_encrypted"
            fi
            ((loop++))
        done

        update_registered_user

        printf "\n"

        echo "Your password was successfully changed."

        sleep 1.6

    elif [ "$1" == "update name" ]; then
        echo "Please enter a new first and lastname separately, $user_nickname:"
        read new_first_name new_last_name

        new_first_name_lowercase=`echo "$new_first_name" | tr '[:upper:]' '[:lower:]'`
        new_last_name_lowercase=`echo "$new_last_name" | tr '[:upper:]' '[:lower:]'`
        validate_new_full_name

        save_user_preference "${username,,}" "$firstname $lastname" "$new_first_name $new_last_name"

        printf "\n"

        echo "Your first and last name were successfully changed."

        sleep 1.6

    elif [ "$1" == "update dob" ]; then
    echo "Please enter a new date of birth, $user_nickname: (NOTE: Make sure it's in DD.MM.YYYY format)"
        read new_dob

        new_dob_lowercase=`echo "$new_dob" | tr '[:upper:]' '[:lower:]'`
        validate_new_dob

        save_user_preference "${username,,}" "${user_dob}" "${new_dob_lowercase}"

        printf "\n"

        echo "Your date of birth was successfully changed."

        sleep 1.6

    elif [ "$1" == "account information" ]; then
        column_1_spaces=`expr 15 - ${#username}`
        column_2_spaces=`expr 18 - ${#full_name}`

        column_1_spaces=`printf ' %.0s' $(seq 1 $column_1_spaces)`
        column_2_spaces=`printf ' %.0s' $(seq 1 $column_2_spaces)`

        echo "         $username$column_1_spaces$full_name$column_2_spaces$user_dob"
    fi
}