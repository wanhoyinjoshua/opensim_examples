
%this script is to extract info from sto files and plot them. 

% Import OpenSim Libraries

% Load the .sto file



function plot_sto(crouched_stoFilepath,normal_stoFilePath,dataOutputPath,name)
    [normaltimeseries,normaldata]=sto2plotData(normal_stoFilePath,'semimem_r');
    [crouchedtime,crouchedata] =sto2plotData(crouched_stoFilepath,'semimem_r');
    
    if length(normaltimeseries)>length(crouchedtime)
        x2=normaltimeseries;
        x1=crouchedtime;
        y1=crouchedata
        y2=normaldata
    
        y1_interp = interp1(x1, y1, x2, 'linear'); % Interpolating y1 to match x2
        displayname1="crouched";
        displayname2="normal";
    else
        x2=crouchedtime;
        x1=normaltimeseries;
        y1=normaldata
        y2=crouchedata
        y1_interp = interp1(x1, y1, x2, 'linear'); % Interpolating y1 to match x2
        displayname1="normal";
        displayname2="crouched";
    end

    figure('Visible', 'off'); 
    
    plot(x2, y1_interp, 'b-', 'DisplayName', displayname1);
    hold on;
    plot(x2, y2, 'r-', 'DisplayName', displayname2);
    xlabel('X-axis');
    ylabel('Y-axis');
    title('Interpolated Shorter Array to Match Longer Array');
    legend show;
    grid on;


    exportgraphics(gcf, fullfile(dataOutputPath,name,'my_plot.png'), 'Resolution', 300);
        clf; % Clear the current figure
    close all; % Close all open figures
end








