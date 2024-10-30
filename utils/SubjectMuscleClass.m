classdef SubjectMuscleClass
    %MYCLASS A simple example class in MATLAB
    
    %% Properties
    
    properties
        raw_dataseries_y % Public property
        x_data_num; % Default value
        normalised_dataseries_y =[]
        isShort
        isSlow
        stoPath

    end
    
    properties (Access = private)
        StorageObject
    end
    
    %% Methods
    
    methods
        % Constructor
        function obj = SubjectMuscleClass(StoragePath)
            %MYCLASS Construct an instance of this class
            if nargin > 0 % Only set if inputs are provided
                
                
                obj.stoPath=StoragePath;
               
            end
        end
        
        % Public Method
        function [name,numRows,result] = myMethod(obj)
            %MYMETHOD Example method that performs a simple operation
            [name,numRows,result] = obj.sto2matlabData('semimem_r');
            return 
        end

        
    end

    methods (Access = private)
        function [name,numRows,result] = sto2matlabData(obj, TargetColumn)
            % Private method only accessible within the class
            import org.opensim.modeling.*
            opensimArrayDbl = ArrayDouble();
            storage = Storage(obj.stoPath);
            storage.getDataColumn(TargetColumn,opensimArrayDbl);
            nRows = opensimArrayDbl.getSize();
            matlabDataArray = zeros(nRows, 1);
            
            
            % Extract time data
            for i = 0:nRows-1
                %matlab is 1 based and opensim is 0 based
                matlabDataArray(i+1) = opensimArrayDbl.get(i);
            end
            result=matlabDataArray;
            name=TargetColumn;
            numRows=nRows;

        end
    end
end
