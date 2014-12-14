# Lincoln Tosi
# automatically copies Visual Assist and AStyle settings to Google Drive

script_description="UPATE VISUAL STUDIO 2013 SETTINGS"
GDDIR="D:\Google Drive\Settings\Visual Studio 2013"
VADIR="$APPDATA\VisualAssist"
ASDIR="D:\Desktop"
VACPYDIR=$GDDIR"\Visual Assist"
ASCPYDIR=$GDDIR"\AStyle"

printf "\n ==== START SCRIPT ( $script_description ) ====\n\n"

# copy Google Drive\Visual Assist settings to Visual Assist
echo "$VACPYDIR"
cd "$VACPYDIR"
cp -vru Autotext "$VADIR"
cp -vru Dict "$VADIR"
find . -name "*.reg" -exec regedit.exe '{}' \;

# copy Google Drive\AStyle settings to AStyle
printf "\nYou have to import AStyle settings manually... I'll open the directory for you.\n"
explorer "$ASCPYDIR"

printf "\n ==== END SCRIPT ( $script_description ) ====\n"
read
exit 0
