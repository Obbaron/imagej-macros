macro "Set Measurements for Porosity" {
	run("Set Measurements...", "area shape feret's display redirect=None decimal=3");
}
macro "Calculate Polygon Area" {
	if (selectionType() == -1) {
    		exit("No selection found. Please use the Polygon tool to select an area first.");
	}
	imageName = getTitle();
	List.setMeasurements;
	polygonArea = List.getValue("Area");
	getPixelSize(unit, pixelWidth, pixelHeight);
	
	showMessage("Polygon Area: " + polygonArea + " " + unit + "²");
	
	// Comment out below to not save file
	// saveDir = getDirectory("image");
	// baseName = File.nameWithoutExtension;
	// resultText = "Image: " + imageName + "\nPolygon Area: " + polygonArea + " " + unit + "²";
	// File.saveString(resultText, saveDir + baseName + "_area.txt");
}
macro "PolyPore" {
	if (selectionType() == -1) {
		exit("No selection found. Please use the Polygon tool to select an area first.");
	}
	imageName = getTitle();
	List.setMeasurements;
	polygonArea = List.getValue("Area");
	getPixelSize(unit, pixelWidth, pixelHeight);
	
	saveDir = getDirectory("image");
	baseName = substring(imageName, 0, lastIndexOf(imageName, "."));
	
	run("8-bit");
	run("Clear Outside");
	run("Crop");
	setBackgroundColor(255, 255, 255);
	run("Clear Outside");
	
	run("Threshold...");
	setAutoThreshold("Default no-reset");
    
	waitForUser("Check threshold", "Adjust the threshold if needed, then click OK to continue.");
	//setThreshold(0, 64);

	if (isOpen("Threshold")) {
		selectWindow("Threshold");
		run("Close");
	}
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("Analyze Particles...", "display exclude clear include");
	
	if (nResults > 0) {
		for (i = 0; i < nResults; i++) {
			area = getResult("Area", i);
			diameter = 2 * sqrt(area / PI);
			setResult("Diameter", i, diameter);
		}
		updateResults();
	}

	run("Summarize");
		
	if (nResults > 0) {
		lastRow = nResults;
		
		setResult("Label", lastRow, "Polygon Surface Area:");
		setResult("Area", lastRow, polygonArea);
		updateResults();

		saveAs("Results", saveDir + baseName + "_Results.csv");

		showMessage("Results saved to: " + saveDir + baseName + "_Results.csv");
	
	} else {
		
		showMessage("No particles detected.");
	}
	close("*");
	if (isOpen("Results")) {
		selectWindow("Results");
		run("Close");
	}
}
