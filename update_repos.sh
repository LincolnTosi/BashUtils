# Lincoln Tosi 2/20/14
# automates syncing multiple mercurial repositories

script_description="UPATE REPOS"
array=(
"/cygdrive/d/Desktop/Homework"
"/cygdrive/d/Desktop/Projects"
#"/cygdrive/d/Desktop/CloudyClouds"
)

printf "\n ==== START SCRIPT ( $script_description ) ====\n"

printf "Number of repositories: ${#array[*]}\n\n"

for item in ${array[*]}
do
  if [ -e $item ]
  then
    printf "%s\n" $item

    cd $item
    if [ $? != 0 ]
    then
      printf "ERROR: Could not enter %s!\n" $item
      read
      exit 1
    fi

    hg pull
    if [ $? != 0 ]
    then
      echo "ERROR: Could not pull!"
      read
      exit 1
    fi

    hg update
    if [ $? != 0 ]
    then
      echo "ERROR: Could not update!"
      read
      exit 1
    fi

    hg diff
    if [ -n "$(hg diff)" ]
    then
      printf "Uncommitted changes from %s\n" $item
      printf "Please enter a commit message: "
      read var_msg
      echo "Committing with message: $var_msg"

      hg commit -m"$var_msg"
      if [ $? != 0 ]
      then
        echo "ERROR: Could not commit!"
        read
        exit 1
      fi
    fi

    hg push
    if [ $? != 0 ]
    then
      printf "Did not push!\n\n"
    else
      printf "Push complete!\n\n"
    fi
  else
    printf "Error: %s is incorrect!" $item
    read
    exit 1
  fi
done

printf "\n ==== END SCRIPT ( $script_description ) ====\n"
# read
exit 0
