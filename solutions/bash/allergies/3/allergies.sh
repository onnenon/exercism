#!/usr/bin/env bash

ALLERGENS=(eggs peanuts shellfish strawberries tomatoes chocolate pollen cats)
VALUES=(1 2 4 8 16 32 64 128)

score=$1
command=$2
item=$3

is_allergic() {
	local score=$1
	local item=$2
	for i in "${!ALLERGENS[@]}"; do
		if [[ "${ALLERGENS[i]}" == "$item" ]]; then
			(( score & VALUES[i] )) && echo "true" || echo "false"
			return
		fi
	done
	echo "false"
}

list_allergies() {
	local score=$1
	local result=()
	for i in "${!ALLERGENS[@]}"; do
		if (( score & VALUES[i] )); then
			result+=("${ALLERGENS[i]}")
		fi
	done
	if (( ${#result[@]} > 0 )); then
		echo "${result[*]}"
	fi
}

case "$command" in
	allergic_to)
		is_allergic "$score" "$item"
		;;
	list)
		list_allergies "$score"
		;;
	*)
		echo "Unknown command"
		exit 1
		;;
esac
