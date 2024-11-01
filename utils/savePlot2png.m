
function Path= savePlot2png(ref,current,currentDatarootPath,title_graph)
figure('Visible', 'off'); 
    
    plot(ref.time,ref.value, 'b-', 'DisplayName', 'reference');
    hold on;
    plot(current.time, current.value, 'r-', 'DisplayName', 'current');
    xlabel('X-axis');
    ylabel('Y-axis');
    title(title_graph);
    legend show;
    grid on;


    exportgraphics(gcf, fullfile(currentDatarootPath,strcat(title_graph, '.png')), 'Resolution', 300);
    Path=fullfile(currentDatarootPath,strcat(title_graph, '.png'));
    clf; % Clear the current figure
    close all; % Close all open figures
  
end








