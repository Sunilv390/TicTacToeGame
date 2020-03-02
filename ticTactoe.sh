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
resetBoard
#ASSIGNING PLAYER'S SYMBOL
function assignPlayer(){
	if [ $((RANDOM%2)) -eq 0 ]
	then
		Player=X
	else
		Player=O
	fi
		echo "Symbol is "$Player
}
assignPlayer
