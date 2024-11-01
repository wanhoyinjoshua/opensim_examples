classdef MuscleAnalyser
    
 
    
    properties
        dataOutputPath
        referenceDatarootPath
        currentDatarootPath
        

    end
    
    properties (Access = private)
        xmlsettings
        osimModelPath
        motPath
        
        
    end
    

    
    methods
        % Constructor
        function obj = MuscleAnalyser(settingsXml,outputPath,modelPath)
         
            if nargin > 0 % Only set if inputs are provided
               
                obj.dataOutputPath=outputPath;
                obj.xmlsettings=settingsXml;
                obj.osimModelPath=modelPath;
                
               
            end
        end
        
        % Public Method
        function Analyser = analyse(obj,motPath,fileName)
           
            obj.runAnalysis(motPath,fileName)
            obj.currentDatarootPath=fullfile(obj.dataOutputPath, fileName);

            Analyser=obj;
            return 
        end

        function Analyser = setReference(obj,referenceMotFilePath)
           
            obj.runAnalysis(referenceMotFilePath,"normal")

        

            obj.referenceDatarootPath=fullfile(obj.dataOutputPath,'normal');
            obj.currentDatarootPath=fullfile(obj.dataOutputPath,'normal');

            Analyser=obj;

            return 
        end

        


      
        function [ref,cur] =getValues(obj,entity,column)
            
            disp(obj.currentDatarootPath)
            [reftime,refvalue]=sto2matLabData(fullfile(obj.referenceDatarootPath,entity),column);
            [time,value]=sto2matLabData(fullfile(obj.currentDatarootPath,entity),column);
         

            reference = struct('time', reftime, 'value', refvalue);
            current= struct('time', time, 'value', value);
            
            if length(reference.time)>length(current.time)
                %meaning the current values will have to be inteprolated 
                current_interp = interp1(current.time, current.value, reference.time, 'linear');

                current.value=current_interp;
                current.time=reference.time;



            else
                reference_interp = interp1(reference.time, reference.value, current.time, 'linear');

                reference.value=reference_interp;
                reference.time=current.time;
            end

            ref=reference;
            cur=current;


        
        
          end

        
    end

    methods (Access = private)
        function runAnalysis(obj,motPath,fileName)
            import org.opensim.modeling.*
            tool=AnalyzeTool(obj.xmlsettings,false);
            model = Model(obj.osimModelPath);
            tool.setLoadModelAndInput(true)
            osimModel=model;
            tool.setModel(osimModel);
            
            
            if ~exist(fullfile(obj.dataOutputPath,fileName), 'dir')
                % Create the folder
                mkdir(fullfile(obj.dataOutputPath,fileName));
                tool.setResultsDir(fullfile(obj.dataOutputPath,fileName));
            else
                tool.setResultsDir(fullfile(obj.dataOutputPath,fileName));
                
            end
            tool.setInitialTime(0);
            tool.setFinalTime(1);
            tool.setCoordinatesFileName(motPath);
            %out_path_xml=fullfile('C:\Users\wanho\Documents\matlab_opensim_tut\results',['muscle_analysis_.xml']);
            %tool.print(out_path_xml);
            tool.run;
            
        
        end

        
       
    end
end
