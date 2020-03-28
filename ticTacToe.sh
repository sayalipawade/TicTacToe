#!/bin/bash -x
echo "Welcome"

#constants
PLAYER1=""
PLAYER2=""

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

read -p "Enter 1 Single player Enter 2 Two player==" playerChoice
if [ $playerChoice -eq 1 ]
then
      read -p "Enter player name:" PLAYER1
      PLAYER2="Computer"
else
      read -p "Enter first player name:" PLAYER1
      read -p "Enter second player name:" PLAYER2
fi

#Begin With toss
toss=$((RANDOM%2+1))
if [[ $toss -eq 1 ]]
then
	printf "$PLAYER1 will play first\n"
else
	printf "$PLAYER2 will play first\n"
fi

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

#Add Position
function addPosition()
{
	if [ $(($toss%2)) -eq 0 ]
	then
		board[$1,$2]="O"
	else
		board[$1,$2]="X"
	fi
	winOrTie
	((toss++))
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
		printf "$PLAYER2 you are win..\n"
		end=0
		exit
	else
		printf "$PLAYER1 you are win..\n"
		end=0
		exit
	fi
}

#logic of computer
function playComputer()
{
	if [[ ${board[1,0]} == ${board[2,0]} || ${board[1,1]} == ${board[2,2]} || ${board[0,1]} == ${board[0,2]} ]]
	then
		addPosition 0 0
	elif [[ ${board[0,0]} == ${board[0,2]} || ${board[1,1]} == ${board[2,1]} ]]
	then
		addPosition 0 1
	elif [[ ${board[0,0]} == ${board[0,1]} || ${board[1,2]} == ${board[2,2]} || ${board[2,0]} == ${board[2,1]} ]]
	then
		addPosition 0 2
	elif [[ ${board[0,0]} == ${board[2,0]} || ${board[1,1]} == ${board[1,2]} ]]
	then 
		addPosition 1 0
	elif [[ ${board[1,0]} == ${board[1,2]} || ${board[0,1]} == ${board[2,1]} || ${board[0,0]} == ${board[2,2]} || ${board[0,2]} == ${board[2,0]} ]]
	then
		addPosition 1 1
	elif [[ ${board[0,2]} == ${board[2,2]} || ${board[1,0]} == ${board[1,1]} ]]
	then
		addPosition 1 2
	elif [[ ${board[0,0]} == ${board[1,0]} || ${board[2,1]} == ${board[2,2]} || ${board[0,2]} == ${board[1,1]} ]]
	then
		addPosition 2 0
	elif [[ ${board[0,1]} == ${board[1,1]} || ${board[2,0]} == ${board[2,2]} ]]
	then
		addPosition 2 1
	elif [[ ${board[2,0]} == ${board[2,1]} || ${board[0,2]} == ${board[1,2]} || ${board[0,0]} == ${board[1,1]} ]]
	then
		addPosition 2 2
	else
		randomPos1=$((RANDOM%3))
		randomPos2=$((RANDOM%3))
		while [[ ${board[$randomPos1,$randomPos2]} == 'O' || ${board[$randomPos1,$randomPos2]} == 'X' ]]
		do
			randomPos1=$((RANDOM%3))
			randomPos2=$((RANDOM%3))
		done
		addPosition $randomPos1 $randomPos2
	fi
}


#Loop for Win or tie
while [ $end -ne 0 ]
do
	printBoard
	if [ $(($toss%2)) -eq 0 ]
	then
			if [ $playerChoice -eq 1 ]
			then 
				playComputer
				printf "\n"
				printBoard
			else
				read -p "$PLAYER2 enter a position" choice
			fi
	fi
	if [ $(($toss%2)) -eq 1 ]
	then
			read -p "$PLAYER1 enter a position:" choice
	fi
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
	
	
