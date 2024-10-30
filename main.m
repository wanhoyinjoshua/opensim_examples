%simulating dependency
import org.opensim.modeling.*
addpath('./utils')

%this main will literally define the entry point ( where are the mot files
%are, and then loop through them and output the file into a specific
%directory 
currentDir = pwd;
openSimsModelFullPath= fullfile(currentDir,'/models/gait2392_simbody.osim')
settingsFullPath=fullfile(currentDir,'/muscle_analysis_test.xml')
motDataFullPath= fullfile(currentDir,'/mot/crouched_gait')
dataOutputPath= fullfile (currentDir,'results')
motfolder=dir(motDataFullPath)
motfolder = motfolder(~ismember({motfolder.name}, {'.', '..'}));
tic;
for index = 1:getFilesCount(motDataFullPath)
    % Code to execute in each iteration
    trial(settingsFullPath,openSimsModelFullPath,dataOutputPath,motDataFullPath,motfolder(index).name)
    %generate png as well...
   
    normal_stoFilePath = './results/normal.mot/test_MuscleAnalysis_Length.sto'; % Update this to your .sto file path
    plot_sto(fullfile(dataOutputPath,motfolder(index).name,"test_MuscleAnalysis_Length.sto"),normal_stoFilePath,dataOutputPath,motfolder(index).name)

end
elapsedTime = toc;

%second step will be essentially obtain the normal reference and have a
%graphs outputted. 
disp(elapsedTime)

