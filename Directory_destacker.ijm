print("\\Clear")
 
//	MIT License

//	Copyright (c) 2019 Nicholas Condon n.condon@uq.edu.au

//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:

//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.

//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.


//IMB Macro Splash screen (Do not remove this acknowledgement)
scripttitle="Image De-Stacker";
version="1.2";
versiondate="13/10/2019";
description="Details: <br>This script takes 3D/4D images and de-stacks them into lower dimensional files. Files are filtered by their extension (.czi, .lsm etc)"
+"and are opened via Bioformats importer. <br><br> Files to be processed should be within their own directory. <br><br> "
+"Processed images/movies can be placed into a subdirectory called Filename_Extracted, or within the main working directory. <br><br> "
+"A log file (Log_ImageDe-stacker.txt) will be saved within this directory for recording the processing steps chosen"
    
    showMessage("Institute for Molecular Biosciences ImageJ Script", "<html>" 
    +"<h1><font size=6 color=Teal>ACRF: Cancer Biology Imaging Facility</h1>
    +"<h1><font size=5 color=Purple><i>The Institute for Molecular Bioscience <br> The University of Queensland</i></h1>
    +"<h4><a href=http://imb.uq.edu.au/Microscopy/>ACRF: Cancer Biology Imaging Facility</a><\h4>"
    +"<h1><font color=black>ImageJ Script Macro: "+scripttitle+"</h1> "
    +"<p1>Version: "+version+" ("+versiondate+")</p1>"
    +"<H2><font size=3>Created by Nicholas Condon</H2>"	
    +"<p1><font size=2> contact n.condon@uq.edu.au \n </p1>" 
    +"<P4><font size=2> Available for use/modification/sharing under the "+"<p4><a href=https://opensource.org/licenses/MIT/>MIT License</a><\h4> </P4>"
    +"<h3>   <\h3>"    
    +"<p1><font size=3 \b i>"+description+".</p1>"
   	+"<h1><font size=2> </h1>"  
	+"<h0><font size=5> </h0>"
    +"");


//Log Window Title and Acknowledgement
print("");
print("FIJI Macro: "+scripttitle);
print("Version: "+version+" ("+versiondate+")");
print("ACRF: Cancer Biology Imaging Facility");
print("By Nicholas Condon (2019) n.condon@uq.edu.au")
print("");
getDateAndTime(year, month, week, day, hour, min, sec, msec);
print("Script Run Date: "+day+"/"+(month+1)+"/"+year+"  Time: " +hour+":"+min+":"+sec);
print("");
    

//Directory Warning panel     
Dialog.create("Choosing your image location");
 	Dialog.addMessage("Use the next window to navigate to your directory of images.");
  	Dialog.addMessage("(Note a sub-directory will be made for each input image within this fodler) ");
  	Dialog.addMessage("Take note of your file extension (eg .tif, .czi)");
 Dialog.show();


//Directory location selector
path = getDirectory("Choose Source Directory ");
list = getFileList(path);


setBatchMode(true);


//Parameter selection box
ext = ".tif";
  Dialog.create("Select DIMENSIONALITY");
  	Dialog.addString("File Extension:", ext);
 	Dialog.addMessage("(For example .czi  .lsm  .nd2  .lif  .ims)");
  	Dialog.addMessage(" ");
  	Dialog.addMessage("Select how you wish to reduce the dimensionality of your files");
  	Dialog.addCheckbox("Frames", false);
  	Dialog.addCheckbox("Slices", false);
 	Dialog.addCheckbox("Channels", false);
 	Dialog.addCheckbox("Save into subfolders", true);
 	Dialog.show();
	choiceFrames=Dialog.getCheckbox();
	choiceSlices = Dialog.getCheckbox();
	choiceChannels = Dialog.getCheckbox();
	choiceSubfolders = Dialog.getCheckbox();
	ext = Dialog.getString();




//Printing Parameters to log file
print("**** Parameters ****")
print("File extension: "+ext);
if (choiceFrames == 1) print("Reducing by Frame: ON");
if (choiceFrames == 0) print("Reducing by Frame: OFF");
if (choiceSlices == 1) print("Reducing by Slice: ON");
if (choiceSlices == 0) print("Reducing by Slice: OFF");
if (choiceChannels == 1) print("Reducing by Channel: ON");
if (choiceChannels == 0) print("Reducing by Channel: OFF");
if (choiceSubfolders == 1) print("Saving into Subfolders: ON");
if (choiceSubfolders == 0) print("Saving into Subfolders: OFF");



//Timer Sequence start
start = getTime();


//File Opening
for (z=0; z<list.length; z++) {
//confirms only files being opened contain the filetype as defined by ext
	if (endsWith(list[z],ext)){
	run("Bio-Formats Importer", "open="+path+list[z]+" autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	
 	windowtitle = getTitle();
	windowtitlenoext = replace(windowtitle, ext, "");
	print("");
	print("Opening File "+(z+1)+" of "+list.length+": "+windowtitle);

	//Creating directories
	resultsDir = path+windowtitlenoext+"_Extracted/";
	if(choiceSubfolders ==0){resultsDir=path;}
		File.makeDirectory(resultsDir);
		d = Stack.getDimensions(width, height, channels, slices, frames); 
		print("Total Number of Frames = "+frames);
		print("Total Number of Slices = "+slices);
		print("Total Number of Channels = "+channels);
		
		
		//Loops through each frame of the stack until total frames are saved out individually
		if (choiceFrames==1 && choiceSlices==0 && choiceChannels==0){
			for (i=0; i<frames; i++){
				fr=i+1;
				Stack.setFrame(i); 
				run("Reduce Dimensionality...", "slices channels keep"); 
				rename(windowtitlenoext+"_t"+fr);
			 	finalname = getTitle();
				print("Saving Frame # "+fr+" of "+frames);
				saveAs("Tiff", resultsDir+ finalname+".tif"); 
				close();}}

		//Loops through each frame and slice until all are saved		
		if (choiceFrames==1 && choiceSlices==1 && choiceChannels==0){
				for (i=0; i<frames; i++){
				fr=i+1;
				Stack.setFrame(i); 
				run("Reduce Dimensionality...", "slices channels keep"); 
				rename(windowtitlenoext+"_t"+fr);
				for (s=0; s<slices; s++){
					sl=s+1;
					Stack.setSlice(s); 
					run("Reduce Dimensionality...", "channels keep"); 
					rename(windowtitlenoext+"_t"+fr+"_z"+sl);
					finalname = getTitle();
					print("Saving Frame # "+fr+" of "+frames+" Slice # "+sl);
					saveAs("Tiff", resultsDir+ finalname+".tif"); 
					close();}
					close();
					}}

		//Loops through each frame, slice, and channel, until all are saved
		if (choiceFrames==1 && choiceSlices==1 && choiceChannels==1){
				//i=1;s=1;c=1;
				for (i=0; i<frames; i++){ 
					Stack.setFrame(i); 
					run("Reduce Dimensionality...", "slices channels keep"); 
					rename(windowtitlenoext+"_t"+i);
					fr=i+1;
				 	for (s=0; s<slices; s++){ 
				 		Stack.setSlice(s);
						run("Reduce Dimensionality...", "channels keep"); 
						rename(windowtitlenoext+"_t"+fr+"_z"+s);
						sl=s+1;
						for (c=0; c<channels; c++){
							ch=c+1;
							run("Duplicate...", "duplicate channels="+ch);
							rename(windowtitlenoext+"_t"+fr+"_z"+sl+"_c"+ch);
							finalname = getTitle();
							print("Saving Frame # "+fr+" of "+frames+" Slice # "+sl+" of "+slices+" Channel # "+ch+" of "+channels);
							saveAs("Tiff", resultsDir+ finalname+".tif"); 
							close();
							}
						close();
						}
					close(); 
						}
						}

		//saves out only channels
		if (choiceFrames==0 && choiceSlices==0 && choiceChannels==1){
				for (c=0; c<channels; c++){
					ch=c+1;
					run("Duplicate...", "duplicate channels="+ch);
					rename(windowtitlenoext+"_c"+ch);
					finalname = getTitle();
					print("Saving Channel # "+ch+" of "+channels);
							saveAs("Tiff", resultsDir+ finalname+".tif"); 
							close();
							}
		}

		//saves out slices and channels
		if (choiceFrames==0 && choiceSlices==1 && choiceChannels==0){
				for (s=0; s<slices; s++){
					sl=s+1;
					Stack.setSlice(s); 
					run("Reduce Dimensionality...", "frames channels keep"); 
					rename(windowtitlenoext+"_z"+sl);
					finalname = getTitle();
					print("Saving Slice # "+sl+" of "+slices);
					saveAs("Tiff", resultsDir+ finalname+".tif"); 
					close();}
					}

		//saves out frames and channels
		if (choiceFrames==1 && choiceSlices==0 && choiceChannels==1){
				//i=1;s=1;c=1;
				for (i=0; i<frames; i++){ 
					Stack.setFrame(i); 
					run("Reduce Dimensionality...", "slices channels keep"); 
					rename(windowtitlenoext+"_t"+i);
					fr=i+1; 	
					for (c=0; c<channels; c++){
							ch=c+1;
							run("Duplicate...", "duplicate channels="+ch);
							rename(windowtitlenoext+"_t"+fr+"_c"+ch);
							finalname = getTitle();
							print("Saving Frame # "+fr+" of "+frames+" Channel # "+ch+" of "+channels);
							saveAs("Tiff", resultsDir+ finalname+".tif"); 
							close();
							}
						close();
						}
					 
						}
	}
		
		close(); 
		}

//Printing script runtime
print("");
print("Batch Completed");
print("Total Runtime was:");
print((getTime()-start)/1000); 

//Saving Log File
selectWindow("Log");
saveAs("Text", path+"Log_"+scripttitle+".txt");

//Termination warning (batch ended)
title = "Batch Completed";
msg = "Put down that coffee! Your analysis is finished";
waitForUser(title, msg); 					
