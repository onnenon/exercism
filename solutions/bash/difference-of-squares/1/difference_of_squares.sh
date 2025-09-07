#!/usr/bin/env bash


square_of_sum() {
	local n=$1
	local sum=0
	for ((i=1; i<=n; i++)); do
		sum=$((sum + i))
	done
	echo $((sum * sum))
}

sum_of_squares() {
	local n=$1
	local sum=0
	for ((i=1; i<=n; i++)); do
		sum=$((sum + i * i))
	done
	echo $sum
}

difference() {
	local n=$1
	local sq_sum=$(square_of_sum "$n")
	local sum_sq=$(sum_of_squares "$n")
	echo $((sq_sum - sum_sq))
}

main() {
	case "$1" in
		square_of_sum)
			square_of_sum "$2"
			;;
		sum_of_squares)
			sum_of_squares "$2"
			;;
		difference)
			difference "$2"
			;;
		*)
			echo "Unknown command: $1" >&2
			exit 1
			;;
	esac
}

main "$@"
