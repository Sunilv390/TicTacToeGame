#!/bin/bash

#CONSTANTS
ROW=3
COLUMN=3
LENGTH=$(($ROW*$COLUMN))

#VARIABLE
cell=0

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

#INITIALIZING BOARD
function initializeBoard(){
	for (( i=0; i<ROW; i++ ))
	do
		for (( j=0; j<COLUMN; j++ ))
		do
			board[$i,$j]=$cell
			((cell++))
		done
	done
}

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

#GETTING INPUT
function getInput(){
   for (( i=0; i<$LENGTH; i++ ))
   do
      getBoard
      read -p "Enter a position " position
      if [ $position -gt $LENGTH ]
      then
         echo "Invalid Moves"
         ((i--))
      else
         rowIndex=$(( $position / $ROW ))
         if [ $(( $position % $ROW )) -eq 0 ]
         then
            rowIndex=$(( $rowIndex-1 ))
         fi
         columnIndex=$(( $position % $COLUMN ))
         if [ $columnIndex -eq 0 ]
         then
            columnIndex=$(($columnIndex+2))
         else
            columnIndex=$(($columnIndex-1))
         fi
         board[$rowIndex,$columnIndex]=$Player
         if [ $(checkResult) -eq 1 ]
         then
            echo "You Win"
            return 0
         fi
      fi
   done
}

#CHECK'S WINNER
function checkResult(){
   if [ ${board[0,0]} == $Player ] && [ ${board[0,1]} == $Player ] && [ ${board[0,2]} == $Player ]
   then
      echo 1
   elif [ ${board[1,0]} == $Player ] && [ ${board[1,1]} == $Player ] && [ ${board[1,2]} == $Player ]
   then
      echo 1
   elif [ ${board[2,0]} == $Player ] && [ ${board[2,1]} == $Player ] && [ ${board[2,2]} == $Player ]
   then
      echo 1
   elif [ ${board[0,0]} == $Player ] && [ ${board[1,0]} == $Player ] && [ ${board[2,0]} == $Player ]
   then
      echo 1
   elif [ ${board[0,1]} == $Player ] && [ ${board[1,1]} == $Player ] && [ ${board[2,1]} == $Player ]
   then
      echo 1
   elif [ ${board[0,2]} == $Player ] && [ ${board[1,2]} == $Player ] && [ ${board[2,2]} == $Player ]
   then
      echo 1
   elif [ ${board[0,0]} == $Player ] && [ ${board[1,1]} == $Player ] && [ ${board[2,2]} == $Player ]
   then
      echo 1
   elif [ ${board[0,2]} == $Player ] && [ ${board[1,1]} == $Player ] && [ ${board[2,0]} == $Player ]
   then
      echo 1
   else
      echo 0
   fi
}

resetBoard
assignPlayer
isToss
initializeBoard
getInput
getBoard
