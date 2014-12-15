# Lincoln Tosi 2/20/14
# automatically removes debug/release folders and unwanted file types
# automatically zips given submission dir
# automatically attempts to extract and build the submission .zip in both debug and release
# requires cygwin zip
# requires cygwin unzip or WinRAR
# requires MSBuild.exe in system PATH (for VS2013 it should be C:\Program Files (x86)\MSBuild\12.0\Bin\amd64)
# please read this script before attempting to use it

script_description="DIGIPEN PREMARE SUBMISSION"

printf "\n ==== START SCRIPT ( $script_description ) ====\n\n"

# alert if there are no arguments
if [ -z "$1" ]
then
  echo "Please provide the directory to prepare for submission."
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
find . -name "*.user" -exec rm '{}' -vrf \;

# create submission zip
ZIPNAME="${PWD##*/}"
cd ..
echo $ZIPNAME".zip"
echo $ZIPNAME
echo $PWD
find . -name $ZIPNAME".zip" -exec rm '{}' -vrf \;
zip -r $ZIPNAME".zip" $ZIPNAME

# extract and test building the submission
find . -type d -name '_testbuild' -exec rm '{}' -vrf \;
mkdir '_testbuild'
# unzip -K $ZIPNAME".zip" -d '_testbuild'
echo /cygdrive/c/"Program Files"/WinRAR/winrar.exe x $ZIPNAME'.zip' '*.*' '_testbuild'
/cygdrive/c/"Program Files"/WinRAR/winrar.exe x $ZIPNAME'.zip' '*.*' '_testbuild'
cd '_testbuild\'$ZIPNAME
echo $PWD

# make sure MSBuild.exe is in the system path
which MSBuild.exe
if [ $? == 0 ]
then
  echo "MSBuild.exe exists!"
  # invoke MSBuild.exe and check for build completion
  echo -e "Calling MSBuild.exe with parameters: "$ZIPNAME".sln, /p:\"Configuration=Debug\"\n"
  MSBuild.exe $ZIPNAME'.sln' /p:'Configuration=Debug'
  if [ $? == 0 ]
  then
    echo -e "\nDebug build completed successfully!"
  else
    echo -e "\nError: Debug build failed!"
    read
    exit 1
  fi

  echo -e "Calling MSBuild.exe with parameters: "$ZIPNAME".sln, /p:\"Configuration=Release\"\n"
  MSBuild.exe $ZIPNAME'.sln' /p:'Configuration=Release'
  if [ $? == 0 ]
  then
    echo -e "\nRelease build completed successfully!"
  else
    echo -e "\nError: Release build failed!"
    read
    exit 1
  fi
else
  echo "Error: MSBuild.exe could not be found!"
  read
  exit 1
fi

printf "\n ==== END SCRIPT ( $script_description ) ====\n"
# read
exit 0
