#!/usr/bin/env bash


is_armstrong() {
	local num="$1"
	local digits
	local sum=0
	local pow
	local i

	# Get number of digits
	digits=${#num}

	# Loop through each digit
	for ((i=0; i<digits; i++)); do
		d=${num:i:1}
		pow=1
		for ((j=0; j<digits; j++)); do
			pow=$((pow * d))
		done
		sum=$((sum + pow))
	done

	if [[ "$sum" -eq "$num" ]]; then
		echo "true"
	else
		echo "false"
	fi
}

main() {
	is_armstrong "$1"
}

main "$@"
