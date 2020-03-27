#!/bin/bash -x
echo "Welcome"

#constants
PLAYER1="X"
PLAYER2="O"

#variables
no=1
end=1
toss=0
choice=""
tie=0

#printing the fresh board
declare -A board 
for (( i=0;i<3;i++ ))
do
	for(( j=0;j<3;j++ ))
	do
		board[$i,$j]=$(( no++ ))
	done
done

#printing board
function printBoard()
{
	for (( i=0;i<3;i++ ))
	do
		for (( j=0;j<3;j++ ))
		do
			printf "[""${board[$i,$j]}""]"
		done
		printf "\n"
	done
}

#Begin With toss
toss=$((RANDOM%3+1))
if [[ $toss -eq 1 ]]
then
	printf "$PLAYER1 will play first\n"
else
	printf "$PLAYER2 will play first\n"
fi

#Add Position
function addPosition()
{
	if [ $(($toss%2)) -eq 0 ]
	then
		board[$1,$2]="X"
	else
		board[$1,$2]="O"
	fi
	winOrTie
}

#Win or Tie
function winOrTie()
{
	if [[ ${board[0,0]} == ${board[0,1]} && ${board[0,1]} == ${board[0,2]} || ${board[1,0]} == ${board[1,1]} && ${board[1,1]} == ${board[1,2]} || ${board[2,0]} == ${board[2,1]} && ${board[2,1]} == ${board[2,2]} ]]
	then
		whoIsWin 
	elif [[ ${board[0,0]} == ${board[1,1]} && ${board[1,1]} == ${board[2,2]} || ${board[0,2]} == ${board[1,1]} && ${board[1,1]} == ${board[2,0]} ]]
	then
		whoIsWin
	elif [[ ${board[0,0]} == ${board[1,0]} && ${board[1,0]} == ${board[2,0]} || ${board[0,1]} == ${board[1,1]} && ${board[1,1]} == ${board[2,1]} || ${board[0,2]} == ${board[1,2]} && ${board[1,2]} == ${board[2,2]} ]]
	then
		whoIsWin
	fi
	#Tie match
	((tie++))
	if [ $tie -eq 9 ]
	then
		printBoard
		printf "Match is tie\n"
		end=0
	fi
}

function whoIsWin()
{
	printBoard
	if [[ $(($toss%2)) -eq 0 ]]
	then
		printf "$PLAYER1 you are win..\n"
		end=0
	else
		printf "$PLAYER2 you are win..\n"
		end=0
	fi
}

#Loop for Win or tie
while [ $end -ne 0 ]
do
	printBoard
	if [ $(($toss%2)) -eq 1 ]
	then
			read -p "$PLAYER1 enter a position:" choice
	else
			read -p "$PLAYER2 enter a position:" choice
	fi
	((toss++))
	case $choice in
			1)
				addPosition 0 0
				;;
			2)
				addPosition 0 1
				;;
			3)
				addPosition 0 2
				;;
			4)
				addPosition 1 0
				;;
			5)
				addPosition 1 1
				;;
			6)
				addPosition 1 2
				;;
			7)
				addPosition 2 0
				;;
			8)
				addPosition 2 1
				;;
			9)
				addPosition 2 2
				;;
			*)
				printf "Enter valid choice"
				;;
	esac
done 
	
	
