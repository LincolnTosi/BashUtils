Lincoln Tosi 12/14/14
If you plan on using these scripts, please make sure that:

1. You have cygwin installed! (if you're on windows)
2. Your cygwin64\bin directory is listed first in your system PATH environment variable. This basically insures that the cygwin version of the command is called instead of the Windows version (if one exists). To check this, open cmd and make sure "which find" returns "/usr/bin/find".

Optionally do these as well:
- Add an environment variable "CYGWIN" with value "nodosfilewarning" to disable warnings about using Windows style paths.