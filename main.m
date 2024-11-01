
addpath('./utils')

% start output table setup
columnNames = {'ID', 'maxDiff_Length','maxDiff_Velocity','velocitypngfilepath','lengthpngfilepath','sourcedatafile'};
columnTypes = {'char', 'double', 'double','char','char','char'};
myTable = table('Size', [0, numel(columnNames)], 'VariableTypes', columnTypes, 'VariableNames', columnNames);
%end output table setup

%settings for analysis
currentDir = pwd;
settingsXml=fullfile(currentDir,'/muscle_analysis_test.xml');
outputPath=fullfile (currentDir,'results');
modelPath=fullfile(currentDir,'/models/gait2392_simbody.osim');
%end

%initialise analyser and set up reference value for plots later on
Analyser=MuscleAnalyser(settingsXml,outputPath,modelPath);
Analyser=Analyser.setReference(fullfile(currentDir,'/mot/normal_gait/normal.mot'));
%

%now loop through the mot files you wish to analyse
motDataFullPath= fullfile(currentDir,'/mot/crouched_gait');

motfolderdir=dir(fullfile(currentDir,'/mot/crouched_gait'));

motfolder = motfolderdir(~ismember({motfolderdir.name}, {'.', '..'}));

for index = 1:getFilesCount(motDataFullPath)

motfilepath=strcat(motDataFullPath,'\',motfolder(index).name);
Analyser=Analyser.analyse(motfilepath,motfolder(index).name);

%extract data series, it also normalise the data for you, ensuring the
%both arrays contain same no of datapoints
[len_ref,len_current]=Analyser.getValues('test_MuscleAnalysis_Length.sto','semiten_r');
[v_ref,v_current]=Analyser.getValues('test_MuscleAnalysis_FiberVelocity.sto','semiten_r');

%calculate values based on raw data , can compute anything 
minLengthDiff=min(len_current.value)-min(len_ref.value);
maxLengthDiff=max(len_current.value)- max(len_ref.value);
minVelocityDiff=min(v_current.value)-min(v_ref.value);
maxVelocityDiff=max(v_current.value)- max(v_ref.value);


%handle plot and save png
lengthpicpath=savePlot2png(len_ref,len_current,Analyser.currentDatarootPath,"Muuscle length of semitendonous muscle");
velocitypicpath=savePlot2png(v_ref,v_current,Analyser.currentDatarootPath,"Velocity of muscle length of semitendonous muscle");

%append data to master data frame from each mot file. 
newRow1 = table({motfolder(index).name},maxLengthDiff,maxVelocityDiff,{velocitypicpath},{lengthpicpath},{fileToanalyse},'VariableNames', columnNames);
myTable = [myTable; newRow1];
end








