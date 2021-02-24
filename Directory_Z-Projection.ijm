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
scripttitle="Directory_Z-Projection";
version="1.3";
versiondate="13/10/2019";
description="Details: <br>This script takes 3D/4D images and Z-projects (Maximum, Minimum, Average, Sum Slices) them as well as outputting .tif and/or .avi. <br><br>"
+"Files are filtered by their extension (.czi, .lsm etc) and are opened via Bioformats importer. <br><br> "
+"Files to be processed should be within their own directory. Processed images/movies will be placed into a subdirectory called (projectiontype)_Results_(Date&time). <br> <br>"
+"This script can be used to convert files to .tif by selecting 'No Projection' and 'Save .tif output'. <br><br> "
+"The checkbox for concatonation will combine all output files into a single .avi file, suitable for Lattice Light-sheet data-sets. <br><br>"
+"A log file (.txt) will be saved within this directory for recording the processing steps chosen"
    
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
print("Version: "+version+" Version Date: "+versiondate);
print("ACRF: Cancer Biology Imaging Facility");
print("By Nicholas Condon (2019) n.condon@uq.edu.au")
print("");
getDateAndTime(year, month, week, day, hour, min, sec, msec);
print("");
print("Script Run Date: "+day+"/"+(month+1)+"/"+year+"  Time: " +hour+":"+min+":"+sec);


//Directory Warning and Instruction panel     
Dialog.create("Choosing your working directory.");
 	Dialog.addMessage("Use the next window to navigate to the directory of your images.");
  	Dialog.addMessage("(Note a sub-directory will be made within this folder for output files) ");
  	Dialog.addMessage("Take note of your file extension (eg .tif, .czi)");
 	Dialog.show(); 


//Setting up directory locations etc
run("Clear Results");
path = getDirectory("Choose Source Directory ");
list = getFileList(path);

	
//file extension selector
	ext = ".tif";
  Dialog.create("Parameters");
	Dialog.addMessage("Select the processing steps you would like to run:")
	Dialog.addMessage(" ");
  	Dialog.addChoice("Run Z-Projection", newArray("Max Intensity", "Min Intensity", "Average Intensity", "Sum Slices", "No Projection"));
  	Dialog.addString("Choose your file extension:", ext);
 	Dialog.addMessage("(For example .czi  .lsm  .nd2  .lif  .ims)");
 	Dialog.addCheckbox("Re-set Brightness & Contrast", true);
 	Dialog.addCheckbox("Save AVI movie output", false);
  	Dialog.addCheckbox("Save .tif output", true);
  	Dialog.addMessage(" ");
  	Dialog.addCheckbox("Concatenate output files into one avi", false);
  	Dialog.addCheckbox("Run in batch mode (Background)", true);
  Dialog.show();
  
  projectiontype = Dialog.getChoice();
  autoscale = Dialog.getCheckbox();
  avi = Dialog.getCheckbox();
  tif = Dialog.getCheckbox();
  ext = Dialog.getString();
  conc = Dialog.getCheckbox();
  batch=Dialog.getCheckbox();
	
print("**** Parameters ****")
print("Projection Method: "+projectiontype);
print("File extension: "+ext);
if (autoscale == 1) print("Reset Brightness & Contrast: ON");
if (autoscale == 0) print("Reset Brightness & Contrast: OFF");
if (avi == 1) print("Avi output: ON");
if (avi == 0) print("Avi output: OFF");
if (tif == 1) print(".tif output: ON");
if (tif == 0) print(".tif output: OFF");
if (conc == 1) print("Output files will be concatenated into a single AVI");


//batch mode conditional run
if (batch==1){
	setBatchMode(true);
	print("Running in batch mode.");
	}

print("");	
print("");	

//AVI parameter box
if (avi==1 || conc ==1){
	fps=10;
	Dialog.create("Avi Parameters");
		Dialog.addMessage("Select the AVI output parameters")
		Dialog.addMessage(" ");
  		Dialog.addChoice("Compression", newArray("None", "PNG", "JPEG"));
  		Dialog.addString("Frame Rate (fps):", fps);
  	Dialog.show();
  	compression = Dialog.getChoice();
  	fps = Dialog.getString();
}


//Setting up output file directory
getDateAndTime(year, month, week, day, hour, min, sec, msec);
start = getTime();
resultsDir = path+projectiontype+"_Results__"+year+"-"+month+1+"-"+day+"_at_"+hour+"."+min+"/";
File.makeDirectory(resultsDir);


//File opening loop
for (z=0; z<list.length; z++) {
//confirms .tif only files being opened (change to any other format if required)
	if (endsWith(list[z],ext)){
		open(path+list[z]);
 		windowtitle = getTitle();
		windowtitlenoext = replace(windowtitle, ext, "");
		print("");
		print("Opening File: "+(z+1)+" of "+list.length+"  Filename: "+windowtitle);

	//Re-set B&C section
	if (autoscale==true) {
		d = Stack.getDimensions(width, height, channels, slices, frames); 
		//moves to the middle slice of your images to perform colour reset
		setSlice(nSlices/2);
		for (sl=0; sl<channels; sl++){
			Stack.setChannel(sl);
			resetMinAndMax();
			print("Setting Autoscale for channel "+(sl+1));
			}
		}


	if (projectiontype=="No Projection") {
		print("Not Performing Z-Projection");
		
		if (tif==1){
			print("Saving .tif  (Z-Projection Type = "+projectiontype+")");
			saveAs("Tiff", resultsDir+ windowtitlenoext+"_" +projectiontype);
			}}		


	//Projection type loop
	if (projectiontype!="No Projection") {
		print("Performing Z-Projection");
		run("Z Project...", "projection=["+projectiontype+"] all");
		if (tif==1){
			print("Saving .tif  (Z-Projection Type = "+projectiontype+")");
			saveAs("Tiff", resultsDir+ windowtitlenoext+"_" +projectiontype);
			}

		
	//AVI file loop
	if (avi==true) {
		if (frames!=1){
			print("Saving .avi (Compression ="+compression+", fps= "+fps+")");
			run("AVI... ", "compression="+compression+" frame="+fps+" save=[" + resultsDir + windowtitlenoext+"_"+projectiontype +".avi"+ "]");
			close();
			}
		}
    
    
while(nImages>0){close();}
print(" ");
    }
  }
}

if (conc == 1){
	print("");
	print("Opening files for concatenation");
	run("Image Sequence...", "open=["+resultsDir+"] file=.tif sort");
	run("AVI... ", "compression="+compression+" frame="+fps+" save=[" + resultsDir +"Concatenated-MOVIE_"+windowtitlenoext+"_.avi"+ "]");
}

print("");
print("Batch Completed");
print("Total Runtime was:");
print((getTime()-start)/1000); 

selectWindow("Log");
saveAs("Text", resultsDir+"Log.txt");

//Termination warning (batch ended)
title = "Batch Completed";
msg = "Put down that coffee! Your job is finished";
waitForUser(title, msg);  
