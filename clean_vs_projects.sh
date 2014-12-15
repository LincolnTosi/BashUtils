# Lincoln Tosi 2/20/14
# automatically removes debug/release folders and unwanted file types

script_description="CLEAN VISUAL STUDIO PROJECTS IN DIR"

printf "\n ==== START SCRIPT ( $script_description ) ====\n\n"

# alert if there are no arguments
if [ -z "$1" ]
then
  echo "Please provide the directory to search for projects to clean."
  read
  exit 1
fi

# make sure the directory exists
PROJDIR=$1
if [ -e "$PROJDIR" ]
then
  echo "Found "$PROJDIR
else
  echo "Error: "$PROJDIR" not found!"
  read
  exit 1
fi

# remove Debug/Release/obj/bin folders
which find
which rm
cd "$PROJDIR"
find . -type d \( -name 'Debug' -o -name 'Release' -o -name 'debug' -o -name 'release' -o -name 'obj' -o -name 'bin' \) -exec rm '{}' -vrf \;

# remove unwanted file types
find . -name "*.sdf" -exec rm '{}' -vrf \;
find . -name "*.suo" -exec rm '{}' -vrf \;

printf "\n ==== END SCRIPT ( $script_description ) ====\n"
# read
exit 0
