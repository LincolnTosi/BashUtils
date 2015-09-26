### Installation (Windows)
- Install [cygwin](https://cygwin.com/install.html)
- Edit your system's PATH so that `cygwin64\bin` is listed first

>These steps basically ensure that the cygwin version of the command is called instead of the Windows version (if one exists). To check this, open cmd and ensure that typing `which find` returns `/usr/bin/find`
 
>Optionally, you can add an environment variable named `CYGWIN` with value `nodosfilewarning` to disable warnings when using Windows style paths
