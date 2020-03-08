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
      Computer=O
   else
      Computer=X
      Player=O
   fi
   echo "Symbol for Player is "$Player
}

#TOSS
function isToss(){
   if [ $((RANDOM%2)) -eq 0 ]
   then
      flag=1
      printf "Player turn\n"
   else
      flag=0
      printf "Computer turn\n"
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
      if [ $flag -eq 1 ]
      then
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
            #CHECKING VALIDATION FOR OVERLAPPING
            if [ "${board[$rowIndex,$columnIndex]}" == "$Player" ] || [ "${board[$rowIndex,$columnIndex]}" == "$Computer" ]
            then
               echo "Invalid move, Cell already filled"
               printf "\n"
               ((i--))
            else
               board[$rowIndex,$columnIndex]=$Player
               flag=0
               if [ $(checkResult $Player) -eq 1 ]
               then
                  echo "You Win"
                  return 0
               fi
            fi
         fi
      else
         echo "Computer Turn"
         computerTurn
         flag=1
         if [ $(checkResult $Computer) -eq 1 ]
         then
            echo "Computer Won"
            return 0
         fi
      fi
   done
   echo "Match Tie"
}

#CHECK'S WINNER
function checkResult(){
   symbol=$1
   if [ ${board[0,0]} == $symbol ] && [ ${board[0,1]} == $symbol ] && [ ${board[0,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[1,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[1,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[2,0]} == $symbol ] && [ ${board[2,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,0]} == $symbol ] && [ ${board[1,0]} == $symbol ] && [ ${board[2,0]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,1]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,1]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,2]} == $symbol ] && [ ${board[1,2]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,2]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,0]} == $symbol ]
   then
      echo 1
   else
      echo 0
   fi
}

function  computerTurn(){
   #ROWS
   local row=0
   local col=0
   for ((row=0; row<ROW; row++))
   do
      if [ ${board[$row,$col]} == $Player ] && [ ${board[$(($row)),$(($col+1))]} == $Player ]
      then
          if [ ${board[$row,$(($col+2))]} != $Computer ]
          then
             board[$row,$(($col+2))]=$Computer
             break
          fi
      elif [ ${board[$row,$(($col+1))]} == $Player ] && [ ${board[$row,$(($col+2))]} == $Player ]
      then
          if [ ${board[$row,$col]} != $Computer ]
          then
             board[$row,$col]=$Computer
             break
          fi
      elif [ ${board[$row,$col]} == $Player ] && [ ${board[$row,$(($col+2))]} == $Player ]
      then
          if [ ${board[$row,$(($col+1))]} != $Computer ]
          then
             board[$row,$(($col+1))]=$Computer
             break
          fi
      fi
   done

   #COLUMN
   local row=0
   local col=0
   for ((col=0; col<COLUMN; col++))
   do
      if [ ${board[$row,$col]} == $Player ] &&  [ ${board[$(($row+1)),$col]} == $Player ]
      then
         if [ ${board[$(($row+2)),$col]} != $Computer ]
         then
            board[$(($row+2)),$col]=$Computer
            break
         fi
      elif [ ${board[$(($row+1)),$col]} == $Player ] && [ ${board[$(($row+2)),$col]} == $Player ]
      then
         if [ ${board[$row,$col]} != $Computer ]
         then
            board[$row,$col]=$Computer
            break
          fi
      elif [ ${board[$row,$col]} == $Player ] && [ ${board[$(($row+2)),$col]} == $Player ]
      then
         if [ ${board[$(($row+1)),$col]} != $Computer ]
         then
            board[$(($row+1)),$col]=$Computer
            break
         fi
      fi
   done

   #DIAGONAL
   local row=0
   local col=0
   if [ ${board[$row,$col]} == $Player ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $Player ]
   then
      if [ ${board[$(($row+2)),$(($col+2))]} != $Computer ]
      then
         board[$(($row+2)),$(($col+2))]=$Computer
         return
      fi
   elif [ ${board[$(($row+1)),$(($col+1))]} == $Player ] && [ ${board[$(($row+2)),$(($col+2))]} == $Player ]
   then
      if [ ${board[$row,$col]} != $Computer ]
      then
         board[$row,$col]=$Computer
         return
      fi
   elif [ ${board[$row,$col]} == $Player ] && [ ${board[$(($row+2)),$(($col+2))]} == $Player ]
   then
      if [ ${board[$(($row+1)),$(($col+1))]} != $Computer ]
      then
         board[$(($row+1)),$(($col+1))]=$Computer
         return
      fi
   elif [ ${board[$(($row+2)),$col]} == $Player ] &&  [ ${board[$(($row+1)),$(($col+1))]} == $Player ]
   then
      if [ ${board[$row,$(($col+2))]} != $Computer ]
      then
         board[$row,$(($col+2))]=$Computer
         return
      fi
   elif [ ${board[$(($row+1)),$(($col+1))]} == $Player ] && [ ${board[$row,$(($col+2))]} == $Player ]
   then
      if [ ${board[$(($row+2)),$col]} != $Computer ]
      then
         board[$(($row+2)),$col]=$Computer
         return
      fi
   elif [ ${board[$(($row+2)),$col]} == $Player ] && [ ${board[$row,$(($col+2))]} == $Player ]
   then
      if [ ${board[$(($row+1)),$(($col+1))]} != $Computer ]
      then
         board[$(($row+1)),$(($col+1))]=$Computer
         return
      fi
   else
      while [ true ]
      do
         local row=$(( RANDOM % $ROW ))
         local col=$(( RANDOM % $COLUMN ))
         if [ ${board[$row,$col]} == $Player ] || [ ${board[$row,$col]} == $Computer ]
         then
            continue
         else
            board[$row,$col]=$Computer
            break
         fi
      done
   fi
}


resetBoard
assignPlayer
isToss
initializeBoard
getInput
getBoard
