## HELPER FUNCTIONS

set_valid_responses () {
  valid_responses=()
  valid_responses+=("$@")
}

print_responses () {
  count=0
  for i in "${valid_responses[@]}"; do
    ((count++))

    if [[ count -eq 1 ]]; then
      echo -n "${i^}"
      echo -n "/"
    elif (( $count < ${#valid_responses[@]} )); then
      echo -n "$i"
      echo -n "/"
    else
      echo -n "$i"
    fi
  done
}

## MAIN FUNCTION

## FUNCTION SYNTAX
# validate_response response_variable ( 'required answer 1' 'required answer 2' )

validate_response () {
  response=`echo "$1" | tr '[:upper:]' '[:lower:]'`
  set_valid_responses "${@:2}" "${valid_responses[@]}"

  get_response () {
    read response

    response=`echo "$response" | tr '[:upper:]' '[:lower:]'`
    validate_response "$response"
  }

  if [[ -z "$response" ]]; then
    printf "\n"

    echo "Please enter a response ($(print_responses))"

    get_response
  elif [[ ! "${valid_responses[@]}" =~ "$response" ]]; then
    printf "\n"

    echo "Your response was incorrect, please try again $(tput bold)($(print_responses))$(tput sgr0)"

    get_response
  fi

  # for i in $@; do
  #   if [[ "$i" != "$1" ]] && [[ "$response" != "$i" || "$i" == "${i:0:1}" ]]; then
  #     printf "\n"

  #     echo $i
  #   fi
  # done

  # elif [[ "$response" != "$2" ]] && [[ "$response" != "${2:0:1}" ]] && [[ "$response" != "$3" ]] && [[ "$response" != "${3:0:1}" ]]; then
  #     printf "\n"

  #     echo -e ":) - Sorry, you entered a response that I didn't understand. Please only use \"y\" or \"yes\" and \"n\" or \"no\"."

  #     get_response
  # fi
}