#!/bin/bash -x
echo "Welcome"

#constants
PLAYER1=""
PLAYER2=""

#variables
no=1

#printing the fresh board
declare -A board
function freshBoard()
{ 
	for (( i=0;i<3;i++ ))
	do
		for(( j=0;j<3;j++ ))
		do
			board[$i,$j]=$(( no++ ))
			printf "[""${board[$i,$j]}""]"
		done
		printf "\n"
	done
}

#letter assignment
randomNo=$((RANDOM%2))
if [[ $randomNo -eq 1 ]]
then
	PLAYER1="X"
else
	PLAYER2="O"
fi




