
function trial(settingPath,osimModelPath,outputDataPath,motPath,fileName)
    import org.opensim.modeling.*
    tool=AnalyzeTool(settingPath,false);
    model = Model(osimModelPath);
    tool.setLoadModelAndInput(true)
    osimModel=model;
    tool.setModel(osimModel);
    
    
    if ~exist(fullfile(outputDataPath,fileName), 'dir')
        % Create the folder
        mkdir(fullfile(outputDataPath,fileName));
        tool.setResultsDir(fullfile(outputDataPath,fileName));
    else
        tool.setResultsDir(fullfile(outputDataPath,fileName));
        
    end
    tool.setInitialTime(0);
    tool.setFinalTime(1);
    tool.setCoordinatesFileName(fullfile(motPath,fileName));
    %out_path_xml=fullfile('C:\Users\wanho\Documents\matlab_opensim_tut\results',['muscle_analysis_.xml']);
    %tool.print(out_path_xml);
    tool.run;

end
