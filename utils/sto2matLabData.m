function [timeseries, yaxis]= sto2matLabData(stopath,columnName)
    
  
    import org.opensim.modeling.*
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



  
    
    % Replace with your desired column name
    dataArray = ArrayDouble();
    
    storage.getDataColumn(columnName, dataArray);
    
    data = zeros(nRows, 1);
    
    
    % Extract column data
    for i = 0:nRows-1
        data(i+1) = dataArray.get(i);
    end

    yaxis=data;
    
end


