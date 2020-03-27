#!/bin/bash -x
echo "Welcome"

#variables
no=1

#printing the fresh board
declare -A board
function freshBoard()
{
	for(( i=0;i<3;i++ ))
	do
		for (( j=0;j<3;j++ ))
		do
         board[$i,$j]=$(( no++ ))
			printf "[""${board[$i,$j]}""]"
      done
      printf "\n"
   done
}
freshBoard



