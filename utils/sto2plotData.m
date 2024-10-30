function [timeseries, yaxis]= sto2plotDaa()
    
    newClass=SubjectMuscleClass('C:\Users\wanho\Documents\matlab_opensim_tut\results\crouch1.mot\test_MuscleAnalysis_Length.sto');
    disp(newClass);
    [C,D,F]=newClass.myMethod()
    %{
    storage = Storage(stopath);
    % Get time column
    timeArray = ArrayDouble();
    storage.getTimeColumn(timeArray);
    nRows = timeArray.getSize();
    time = zeros(nRows, 1);
    
    
    % Extract time data
    for i = 0:nRows-1
        time(i+1) = timeArray.get(i);
    end
    timeseries=time;



    % Get data for a specific column by its label (example: "muscle_activation")
    
    %'semimem_r'; % Replace with your desired column name
    dataArray = ArrayDouble();
    
    storage.getDataColumn(columnName, dataArray);
    
    data = zeros(nRows, 1);
    
    
    % Extract column data
    for i = 0:nRows-1
        data(i+1) = dataArray.get(i);
    end

    yaxis=data;
    %}
end


[time,s]=sto2plotDaa();