#!/bin/bash

#CONSTANTS
ROW=3
COLUMN=3
LENGTH=$(($ROW*$COLUMN))

#VARIABLE
cell=1

declare -A board

#RESETTING THE BOARD
function resetBoard(){
	local i=0
	local j=0
	for (( i=0; i<$ROW; i++ ))
	do
		for (( j=0; j<$COLUMN; j++ ))
		do
			board[$i,$j]=0
		done
	done
}

#INITIALIZE BOARD
function initializeBoard()
{
   for (( x=0; x<ROW; x++ ))
   do
      for (( y=0; y<COLUMN; y++ ))
      do
         board[$x,$y]=$cell
         ((cell++))
      done
   done
}

#ASSIGNING PLAYER'S SYMBOL
function assignPlayer(){
	if [ $((RANDOM%2)) -eq 0 ]
	then
		Player=X
		Computer=O
	else
		Computer=X
		Player=O
	fi
		echo "Player Symbol is "$Player
}

#TOSS
function isToss(){
	if [ $((RANDOM%2)) -eq 0 ]
	then
		printf "Player's turn\n"
	else
		printf "Computer's turns\n"
	fi
}

#DISPLAY BOARD
function getBoard(){
	echo " | "${board[0,0]}" | "${board[0,1]}" | "${board[0,2]}" | "
	echo "---------------"
	echo " | "${board[1,0]}" | "${board[1,1]}" | "${board[1,2]}" | "
	echo "---------------"
	echo " | "${board[2,0]}" | "${board[2,1]}" | "${board[2,2]}" | "
}

#GIVES INPUT TO THE BOARD
function boardInput(){
	for (( i=0; i<$LENGTH; i++))
	do
		getBoard
	read  -p "Choose one cell for input : " position
		if [ $position -gt $LENGTH ]
		then
			echo "Invalid move, Select valid cell"
			((i--))
		else
			rowIndex=$(( $position / $ROW ))
		if [ $(( $position % $ROW )) -eq 0 ]
		then
			rowIndex=$(( $rowIndex - 1 ))
		fi
		columnIndex=$(( $position %  $COLUMN ))
		if [ $columnIndex -eq 0 ]
		then
			columnIndex=$(( $columnIndex + 2 ))
		else
			columnIndex=$(( $columnIndex - 1 ))
		fi
		#VALIDATION NOT TO OVERLAP SYMBOL
		if [ "${board[$rowIndex,$columnIndex]}" == "$Player" ] || [ "${board[$rowIndex,$columnIndex]}" == "$Computer" ]
		then
			echo "Invalid move"
			((i--))
		fi
		board[$rowIndex,$columnIndex]=$Player
		if [ $(isCheckResult) -eq 1  ]
		then
			echo "You Won"
			return 0
 		fi
	fi
done
	echo "Match Tie"
}

function isCheckResult(){
	if [ $((${board[0,0]})) -eq $(($playerSymbol)) ] && [ $((${board[0,1]})) -eq $(($playerSymbol)) ] && [ $((${board[0,2]})) -eq $(($playerSymbol)) ]
	then
		echo 1
	elif [ $((${board[1,0]})) -eq $(($playerSymbol)) ] && [ $((${board[1,1]})) -eq $(($playerSymbol)) ] && [ $((${board[1,2]})) -eq $(($playerSymbol)) ]
	then
		echo 1
	elif [ $((${board[2,0]})) -eq $(($playerSymbol)) ] && [ $((${board[2,1]})) -eq $(($playerSymbol)) ] && [ $((${board[2,2]})) -eq $(($playerSymbol)) ]
	then
		echo 1
	elif [ $((${board[0,0]})) -eq $(($playerSymbol)) ] && [ $((${board[1,0]})) -eq $(($playerSymbol)) ] && [ $((${board[2,0]})) -eq $(($playerSymbol)) ]
	then
		echo 1
	elif [ $((${board[0,1]})) -eq $(($playerSymbol)) ] && [ $((${board[1,1]})) -eq $(($playerSymbol)) ] && [ $((${board[2,1]})) -eq $(($playerSymbol)) ]
	then
		echo 1
	elif [ $((${board[0,2]})) -eq $(($playerSymbol)) ] && [ $((${board[1,2]})) -eq $(($playerSymbol)) ] && [ $((${board[2,2]})) -eq $(($playerSymbol)) ]
	then
		echo 1
	elif [ $((${board[0,0]})) -eq $(($playerSymbol)) ] && [ $((${board[1,1]})) -eq $(($playerSymbol)) ] && [ $((${board[2,2]})) -eq $(($playerSymbol)) ]
	then
		echo 1
	elif [ $((${board[2,0]})) -eq $(($playerSymbol)) ] && [ $((${board[1,1]})) -eq $(($playerSymbol)) ] && [ $((${board[0,2]})) -eq $(($playerSymbol)) ]
	then
		echo 1
	else
		echo 0
   fi
}

resetBoard
initializeBoard
assignPlayer
isToss
boardInput
getBoard
