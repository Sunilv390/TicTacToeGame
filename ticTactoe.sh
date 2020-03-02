#!/bin/bash

#CONSTANTS
row=3
column=3

declare -A board
#RESETTING THE BOARD
function resetBoard(){
	local i=0
	local j=0
	for (( i=0; i<$row; i++ ))
	do
		for (( j=0; j<$column; j++ ))
		do
			board[$i,$j]=0
		done
	done
}
