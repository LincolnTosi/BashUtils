# Lincoln Tosi
# automatically copies Visual Assist and AStyle settings to Google Drive

script_description="UPATE VISUALSTUDIO 2013 SETTINGS"
GDDIR="D:\Google Drive\Settings\Visual Studio 2013"
VADIR="$APPDATA\VisualAssist"
ASDIR="D:\Desktop"
VACPYDIR=$GDDIR"\Visual Assist"
ASCPYDIR=$GDDIR"\AStyle"

printf "\n ==== START SCRIPT ( $script_description ) ====\n\n"

echo "Make sure to export Visual Assist and Astyle settings before continuing!"
echo "Press enter to continue..."
read

# clean the Google Drive folder for both Visual Assist and AStyle
# rm -vrf "$VACPYDIR\Autotext"
# rm -vrf "$VACPYDIR\Dict"
# find "$VACPYDIR" -name "*.reg" -exec rm '{}' -vrf \;
# find "$ASCPYDIR" -name "AStyleExtension*.cfg" -exec rm '{}' -vrf \;

# copy Visual Assist settings to Google Drive
echo "$VADIR"
cd "$VADIR"
cp -vru Autotext "$VACPYDIR"
cp -vru Dict "$VACPYDIR"
find . -name "*.reg" -exec cp '{}' -vru "$VACPYDIR" \;

# copy AStyle settings to Google Drive
find "$ASDIR" -name "AStyleExtension*.cfg" -exec cp '{}' -vru "$ASCPYDIR" \;

# clean up excess settings files now that we've copied them
find "$VADIR" -name "*.reg" -exec rm '{}' -vrf \;
find "$ASDIR" -name "AStyleExtension*.cfg" -exec rm '{}' -vrf \;

printf "\n ==== END SCRIPT ( $script_description ) ====\n"
read
exit 0
