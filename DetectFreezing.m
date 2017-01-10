classdef DetectFreezing < handle
    
    properties
        index = 0;
        xindex = 0;
        maxVector = []
        preValue = 0.0000;
        midValue = 0.0000;
        postValue = 0.0000;
        prevx = 0.0000;
        currentx = 0.0000;
        postx = 0.0000;
        maxTime = 0.00;
        minTime = 0.00;
        isFreezingOrTurning = false;
        isFreezing = false;
        freezeOrTurnTime = 0.00;
        freezeTime = 0.00;
    end
    
    methods
        %samples passed through this function are one by one from GyZ vector
        function Zscroll(fd, sample)
            %A function to detect freezing of gait            
            fd.index = 1 + fd.index;
            
            if(fd.index == 1)
               fd.preValue = sample; 
            
            elseif(fd.index == 2)
                fd.midValue = sample;
            
            
            else
                fd.postValue = sample;
                
                determineIfMax(fd);
                
            end
            
            if(numel(fd.maxVector) == 3)
                checkPeakDistances(fd);
                fd.maxVector = [];
            end
                fd.preValue = fd.midValue;
                fd.midValue = fd.postValue;
                
        end
        
        function Xscroll(fd, sample)
            fd.xindex = 1 + fd.xindex;
           if(fd.xindex == 1)
               fd.prevx = sample;
  
           elseif(fd.xindex == 2)
              fd.currentx = sample; 
              
           else
               fd.postx = sample;
               determineIfMin(fd);
               if(fd.isFreezingOrTurning == true)
                  if(abs(fd.maxTime - fd.minTime) < 2)
                      fd.isFreezing = true;
                      fd.freezeTime = fd.xindex*0.05;
                  else
                      fd.isFreezing = false;
                  end
               end
           end
           fd.prevx = fd.currentx;
           fd.currentx = fd.postx;
        end
               
        
        
        function determineIfMax(fd)
            if(fd.preValue < fd.midValue && fd.postValue < fd.midValue && fd.midValue > 0)
                fd.maxTime = (fd.index - 1)*0.05;
                fd.maxVector = [fd.maxVector fd.maxTime];
            end
        end
        
        
        function checkPeakDistances(fd)
            diff1 = abs(fd.maxVector(2) - fd.maxVector(1));
            diff2 = abs(fd.maxVector(3) - fd.maxVector(2));
            if(((diff1+diff2)/2) < 2)
                fd.isFreezingOrTurning = true;
                fd.freezeOrTurnTime = fd.index*0.05;
            end
        end
        
        function determineIfMin(fd)
            if(fd.prevx > fd.currentx && fd.postx > fd.currentx && fd.currentx < -0.5)
                fd.minTime = (fd.xindex - 1)*0.05;
            end
        end
        end
end