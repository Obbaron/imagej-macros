# PolyPore - ImageJ Porosity Analysis Macro

A collection of ImageJ macros for analyzing porosity in polygon selection

## Macros

- **Set Measurements for Porosity**: Configure ImageJ measurements for porosity analysis
- **Calculate Polygon Area**: Quickly measure the area of a polygon selection
- **PolyPore**: Records porosity results within polygon selection, and the polygon's area, to CSV

## Installation

1. Download the macro file (`PolyPore.ijm`)
2. In ImageJ/Fiji, go to `Plugins > Macros > Install...`
3. Select the downloaded macro file
4. The macros will appear in `Plugins > Macros` menu

## Usage

### Set Measurements for Porosity

Run this macro first to set measurements to include: area, shape descriptors, Feret's diameter

### Calculate Polygon Area

Displays the area of a selected region in a dialog box.

### PolyPore (Main Analysis)

Complete porosity analysis workflow for measuring pores within a defined region.

**Steps:**
1. Open your image in ImageJ
2. Set the scale if needed: `Analyze > Set Scale...`
3. Select the Polygon tool and draw around your region of interest
4. Run the macro: `Plugins > Macros > PolyPore`
5. The Threshold dialog will appear with an automatic threshold applied
6. Adjust the threshold if needed and click "OK" to continue (threshold dialog can be automated - see Tips)
7. Results are automatically saved to CSV in the same directory as the image

**Output:**
- CSV with pore measurements
- Summary row with total measurements
- Polygon surface area included in results
- File saved as: `[original_filename]_Results.csv`

## Tips

- If you know the threshold beforhand, you can comment out "waitForUser" and use "setThreshold" instead
- If all the images to analyze use the same scale, set scale globally and it will stay applied for this session
