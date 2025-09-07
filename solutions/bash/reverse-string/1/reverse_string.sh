#!/usr/bin/env bash

str=$1
reversed=""
for (( i=${#str}-1; i>=0; i-- )); do
  reversed="$reversed${str:$i:1}"
done
echo "$reversed"