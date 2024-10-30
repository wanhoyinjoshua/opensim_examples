function files_count=getFilesCount(directorypath)
    
    fileList = dir(directorypath); % Get all files and folders in the specified folder
    fileList = fileList(~[fileList.isdir]); % Remove any directories from the list
    
    fileCount = numel(fileList); % Count the number of files
    
    files_count=fileCount;