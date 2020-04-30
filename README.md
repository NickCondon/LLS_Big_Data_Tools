# LLS Big Data Tools
Tools for big data processing of microscopy files.

Created by Dr Nicholas Condon from The Institute for Molecular Biosciences, The University of Queensland, Australia. (contact: n.condon@uq.edu.au)

The following tools are provided to help process large data-set images into either smaller single files for parrellelised processing, as well as to batch maximum Z-project and combined into a single 2D .avi file for data surveying.

The macro files are:
* [Directory_destacker.ijm]
* [Live_destacker.ijm]
* [Directory_Z-Projection.ijm]

These macros are written in the Image J macro language and can be run in [FIJI](http://fiji.sc). The Reduce Dimensionality tool within FIJI is based off the original macro by Jérôme Mutterer and is used here in the Live_destacker.ijm and Directory_destacker.ijm macros.

This Repository is featured in 03/2020 Edition of Imaging & Microscopy. See [here](https://analyticalscience.wiley.com/do/10.1002/was.000005) for the link.


## Preventing the Bio-formats Importer window from displaying
The Bio-Formats opener window will pop-up for each image file unless you change the following within the Bio-Formats configuration panel.

1. Open FIJI
2. Navigate to Plugins > Bio-Formats > Bio-Formats Plugins Configuration
3. Select Formats
4. Select your desired file format (e.g. “Zeiss CZI”) and select “Windowless”
5. Close the Bio-Formats Plugins Configuration window

Now the importer window won’t open for this file-type. To restore this, simply untick ‘Windowless”

## Installing and Running the scripts
The easiest way to install these scripts is to download this entire Git and place it within the Plugins folder of FIJI. After a re-start you should see a new Plugins Menu called "LLS Big Data Tools" which will contain the 3 main macros. Alternatively you can download the Git and drag & drop the .ijm files onto the main FIJI window and select Run.

The following sections contain instructions and example screenshots of the the scripts being run.

### Directory_destacker.ijm 
This script takes 3D/4D images and de-stacks them into lower dimensional files. Files are filtered by their extension (.czi, .lsm etc) and are opened via Bioformats importer. Files to be processed should be within their own directory. Processed images/movies can be placed into a subdirectory called Filename_Extracted, or within the main working directory. A log file (Log_ImageDe-stacker.txt) will be saved within this directory for recording the processing steps chosen.
<br><br>
#### Running the script
1. Drag the Directory_destacker.ijm file onto an open session of FIJI and select "Run" **or** if already installed navigate to the Plugins menu.
2. Read the acknowledgements window and select "OK"

<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_Splash.png"  width="400" height="310">


3. Read the directory warning and take note of your file extension
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_DirectoryWarning.png"  width="300" height="120">


4. Navigate to your input directory of choice that contains your image files. (note sometimes FJIJ cannot display files within a directory, but the macro will still run).
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_ExampleofInputDirectory.png"  width="300" height="110">


5. Next the parameters dialog will open. Confirm your file extension type in the text field. Select the dimensions you with to reduce your images by. Note: Ensuring the sub-directory tick box is selected will create a directory with the image name for output files to be put into.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_Preferences.png"  width="200" height="150">


6. Next the macro will run through the images opening them one by one and splitting them out into the output directory. Upon completion the exit message will display.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/ExitMessage.png"  width="200" height="60">


7. Confirm outputs have saved within the output directory.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_OutputDirectory.png"  width="400" height="100">
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_OutputDirectoryContents.png"  width="400" height="100">


8. Confirm any issues by checking the Log.txt file
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DDS_LogWindow.png"  width="390" height="500">


### Live_destacker.ijm 
This script takes already open 3D/4D images and de-stacks them into lower dimensional files. Image file should already be open and selected within the FIJI environment. Processed images will be placed into a subdirectory called filename+'_extracted'. The log window display the current frame position and/or completion time.

#### Running the script
1. Drag the Live_destacker.ijm file onto an open session of FIJI and select "Run" **or** if already installed navigate to the Plugins menu.
2. Read the acknowledgements window and select "OK"

<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/LDS_Splash.png"  width="400" height="310">


3. Read the directory warning and take note of your file extension
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/LDS_DirectoryWarning.png"  width="300" height="80">


4. Navigate to your input directory of choice that contains your image files. (note sometimes FIJI cannot display files within a directory, but the macro will still run).
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/LDS_OutputDirectoryPrompt.png"  width="300" height="210">


5. Next the parameters dialog will open. Confirm your file extension type in the text field. Select the dimensions you with to reduce your images by. Note: Ensuring the sub-directory tick box is selected will create a directory with the image name for output files to be put into.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/LDS_Paramaters.png"  width="200" height="150">


6. Next the macro will run through the images opening them one by one and splitting them out into the output directory. Upon completion the exit message will display.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/ExitMessage.png"  width="200" height="60">


7. Confirm outputs have saved within the output directory.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/LDS_OutputDirectory.png"  width="400" height="100">
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/LDS_OutputDirectoryContents.png"  width="400" height="100">


8. Confirm any issues by checking the Log.txt file
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/LDS_LogWindow.png"  width="390" height="500">


### Directory_Z-Projection.ijm
This script takes 3D/4D images and Z-projects (Maximum, Minimum, Average, Sum Slices) them as well as outputting .tif and/or .avi. Files are filtered by their extension (.czi, .lsm etc) and are opened via Bioformats importer. Files to be processed should be within their own directory. Processed images/movies will be placed into a subdirectory called (projectiontype)_Results_(Date&time). 

This script can be used to convert files to .tif by selecting 'No Projection' and 'Save .tif output'.  The checkbox for concatonation will combine all output files into a single .avi file, suitable for Lattice Light-sheet data-sets. A log file (.txt) will be saved within this directory for recording the processing steps chosen.
 
#### Running the script
1. Drag the Directory_Z-Projection.ijm file onto an open session of FIJI and select "Run" **or** if already installed navigate to the Plugins menu.

2. Read the acknowledgements window and select "OK"
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DZP_Splash.png"  width="400" height="310">


3. Read the directory warning and take note of your file extension
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DZP_DirectoryWarning.png"  width="300" height="120">


4. Navigate to your input directory of choice that contains your image files. (note sometimes FJIJ cannot display files within a directory, but the macro will still run).
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DZP_ExampleofInputDirectory.png"  width="300" height="110">


5. Next the parameters dialog will open. Confirm your file extension type in the text field. Select the dimensions you with to reduce your images by. Note: Ensuring the sub-directory tick box is selected will create a directory with the image name for output files to be put into.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DZP_Parameters.png"  width="200" height="150">


5a. Next if the AVI output file has been selected, the following window will display. Choose the relevent compresison settings and frame rate.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DZP_AVIParamaters.png"  width="200" height="150">


6. Next the macro will run through the images opening them one by one and splitting them out into the output directory. Upon completion the exit message will display.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/ExitMessage.png"  width="200" height="60">


7. Confirm outputs have saved within the output directory.
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DZP_OutputDirectory.png"  width="400" height="120">
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DZP_OutputDirectoryContents.png"  width="400" height="120">


8. Confirm any issues by checking the Log.txt file
<img src="https://github.com/NickCondon/LLS_Big_Data_Tools/blob/master/Screenshots/DZP_LogWindow.png"  width="390" height="480">
