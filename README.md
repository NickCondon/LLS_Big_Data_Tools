# LLS Big Data Tools
Tools for big data processing of microscopy files.

Created by Dr Nicholas Condon from The Institute for Molecular Biosciences, The University of Queensland, Australia. (contact: n.condon@uq.edu.au)

The following tools are provided to help process large data-set images into either smaller single files for parrellelised processing, as well as to batch maximum Z-project and conbined into a single 2D .avi file for data surveying.

The macro files are:
* Directory_destacker.ijm
* Live_destacker.ijm
* Directory_Z-Projection.ijm

These macros are written in the Image J macro language.


## Directory_destacker.ijm 
This script takes 3D/4D images and de-stacks them into lower dimensional files. Files are filtered by their extension (.czi, .lsm etc) and are opened via Bioformats importer. Files to be processed should be within their own directory. Processed images/movies can be placed into a subdirectory called Filename_Extracted, or within the main working directory. A log file (Log_ImageDe-stacker.txt) will be saved within this directory for recording the processing steps chosen.
<br><br>
### Running the script
1. Drag the Directory_destacker.ijm file onto an open session of FIJI and select "Run" **or** if already installed nagivate to the Pluggins menu.
2. Read the acknowledgements window and select "OK"

<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_Splash.png"  width="400" height="310">
The acknowledgements splash screen for Directory_destacker.ijm
<br>
3. Read the directory warning and take note of your file extension
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_DirectoryWarning.png"  width="300" height="120">
The Directory warning window.
<br>
4. Navigate to your input directory of choice that contains your image files. (note sometimes FJIJ cannot display files within a directory, but the macro will still run).
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_ExampleofInputDirectory.png"  width="300" height="110">
Example input directory
<br>
5. Next the paramaters dialog will open. Confirm your file extension type in the text field. Select the dimensions you with to reduce your images by. Note: Ensuring the sub-directory tick box is selected will create a directory with the image name for output files to be put into.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_Preferences.png"  width="200" height="150">
Parameters window.
<br>
6. Next the macro will run through the images opening them one by one and splitting them out into the output directory. Upon completion the exit message will display.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/ExitMessage.png"  width="200" height="60">
Exit message.
<br>
7. Confirm outputs have saved within the output directory.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_OutputDirectory.png"  width="400" height="100">
Example Directory showing output folders.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_OutputDirectoryContents.png"  width="400" height="100">
Example output directory contents with individual files.
<br>
8. Confirm any issues by checking the Log.txt file
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_LogWindow.png"  width="390" height="500">
Example Log file
