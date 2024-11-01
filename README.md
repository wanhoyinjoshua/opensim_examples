# Muscle Analysis Toolkit

This MATLAB toolkit analyzes muscle performance by comparing current muscle data against reference data, outputting plots and analysis metrics. The toolkit utilizes OpenSim's `AnalyzeTool` for biomechanical analysis of gait motion data.
data and scripts obtained / modified from 
Arnold, A.S., Liu, M., Ounpuu, S., Swartz, M., Delp, S.L., The role of estimating hamstrings lengths and velocities in planning treatments for crouch gait, Gait and Posture, vol. 23, pp. 273-281, 2006.

## Folder Structure
- `utils/`: Contains helper functions for data processing.
- `results/`: Stores output files, including processed data and plots.
- `models/`: Contains the model files used in the analysis.
- `mot/`: Contains motion files (`.mot`) for reference and comparison.

## Primary Class: `MuscleAnalyser`


### Methods
1. **Constructor** (`MuscleAnalyser(settingsXml, outputPath, modelPath)`)
   - Initializes paths for settings, output, and the model file.
2. **`analyse(motPath, fileName)`**
   - Runs an analysis on the specified `.mot` file to generate msucle related properties.
   -  muscle length, tendon length, stiffness etc etc 
3. **`setReference(referenceMotFilePath)`**
   - Sets up reference data for later comparison.
4. **`getValues(entity, column)`**
   - Retrieves and normalizes data for specified analysis columns between the current and reference data.



## Utility Functions
- **`sto2matLabData(stopath, columnName)`**:
  - Reads `.sto` data files and extracts time series data and convert into matlab compatabile array struture. 
- **`savePlot2png(ref, current, currentDatarootPath, title_graph)`**:
  - Plots the reference and current data, saves it as a `.png` file, and returns the file path.

## Example Workflow
1. Initialize `MuscleAnalyser` and set up reference data:
   ```matlab
   Analyser = MuscleAnalyser(settingsXml, outputPath, modelPath);
   Analyser = Analyser.setReference(referenceMotFilePath);
2.  Analyze a series of .mot files:
    ```matlab
    for each file in crouched gait data
      Analyser.analyse(motPath, fileName);
      % Process, compare and plot data, saving results
    end
## Output
- **Table**: Summary table saves as a matlab table with each file's metrics:
  - `ID`: Identifier for the analyzed file.
  - `maxDiff_Length`: Difference in peak muscle length between the current and reference data. ( assuming we are only concerend about the positive peaks)
  - `maxDiff_Velocity`: Difference in peak muscle velocity between the current and reference data.
  - `velocitypngfilepath`: File path to the saved velocity comparison plot.
  - `lengthpngfilepath`: File path to the saved length comparison plot.
  - `sourcedatafile`: Path to the original `.mot` file used in the analysis.
- **Plots**: `.png` plots for muscle length and velocity comparisons, saved in the specified output directory.

![Muuscle length of semitendonous muscle](https://github.com/user-attachments/assets/4c46e292-4603-4c12-b8e1-6d707f998211)
![Velocity of muscle length of semitendonous muscle](https://github.com/user-attachments/assets/c60a1139-3eda-4361-a20a-ac584b531d04)


