"# ResponseOnsetTool

The way the tool works:

0. Copy the files in the folder "tool" into the parent directory of your data, ie:

Folder1 -> Folder2 -> DataFolder1, DataFolder2,...

then copy the scripts from "ROT Prototype v1.0.0" into Folder 2.

1. Start Matlab and open the script
2. Look at the example call at the top of "folder_response.m"

In our example, with the matlab files in Folder 2, this would be: "folder_repsonse('./DataFolder1/');"
Type that (with out the "") into the command line (next to the >>>) and press Enter.

3. Some important settings you can access via the file "set_parameters.m":

RESEARCH (=0,1)
decides wether your wav-files are plotted and saved as .png in addition to the extraction of the response time. Highly encouraged, since it helps spots mistakes in the tool. Set to RESEARCH = 0; if you need to get results fast, or are sure what you are doing.

SPLIT (=0,1)
if set, the Tool creates three folders responder, non_responder and record_error and copies the files into the folder where it believes they belong. Disable for faster computation. Very helpful to check four mistakes afterward.

RECORD_ERROR_THRESHOLD
then minimal value the mean amplitude of a file must surpass, otherwise it will be marked as a record error

The parameters file contains more parameters than those, for a complete overview open the file in Matlab. All parameters are accompanied by a description of what they get used for.
"
