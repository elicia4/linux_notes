Case statements allow us to do something depending on the value of a variable.
The format is as follows:

	case $var in
		1) echo "the variable equals 1";; # all cases end with ";;"
		# you can run multiple commands in a case
		2) echo "the variable equals 2"
		   echo "this is an example of multiple commands running in a case"
		   ;;
		# the case of '*' runs if all other cases don't, nothing matched before
		*) echo "the variable isn't 1 or 2";;
	esac
