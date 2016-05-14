# Tab to USFM Converter

This script converts Scripture edited in TAB separated formar to basic USFM tags   /id  Book /c Chapter /v verse  . This can be imported into ParaText Software .

### Please follow below steps for convert file

1. First line of file should not be blank.
2. Two space or tab between verse number and verse.
3. All verse should be in single line (enter should not be present between sentences
4. File name should be single word (like: 1Corinthians.txt)
5. Output file will be inside same folder with extension .usfm


###Make file executable with below command from console/ Terminal

$ chmod +x tab_to_usfm.rb

###Please check example file with below command:

$ ./tab_to_usfm.rb 1Corinthians.txt


Developed by Uday Kumar uday.kumar@bridgeconn.com

Forked and Modified by Joel Mathew joelalive@gmail.com

[Bridge Connectivity Solutions](http://bridgeconn.com/)
