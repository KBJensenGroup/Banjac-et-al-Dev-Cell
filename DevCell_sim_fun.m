function [average_top,average_bottom]=DevCell_sim_fun(numStep,numSims,w,cellCycle,fastCycle,p00,p01,p13,p02)

res_bottom=zeros(numStep,numSims);
res_top=zeros(numStep,numSims);

%0-stem cells
%0.5 Differentiated bottom cell 
%1-Progenitor cells
%2-Differentiated top cell

for k=1:numSims
    
    start_state=randsample([0,0.5,1,2],1,true,w);
           
    startCells=[start_state];
    endCells=[start_state];   

    for i=1:numStep
                
        startCells=endCells;     
        endCells=[];
        newCells=[];

     
        for j=1:length(startCells)
                
             newState=[startCells(j)];
             newCell=[];
             
             if startCells(j)==0 
                 if rand()<cellCycle
                
                 
                  newCell=[0];
                  
                 end
        
             end
    
            if startCells(j)==1 
                if rand()<fastCycle                     
               
                   newCell=[1];
                end
    
            end  

           endCells=[endCells newState];
           newCells=[newCells newCell];
    
        end
      
        allS=find(endCells==0);
    
        for  j=1:length(allS) 
            
            this_j=allS(j);

            if rand()<(1-p00) 
                 
                if rand()<p01 

                    endCells(this_j)=1;
                else

                    endCells(this_j)=0.5; 

                end

            end
       
        end
        allP=find(endCells==1);

        for j=1:length(allP)

            this_j=allP(j);

            if rand()<p13 

                endCells(this_j)=2; 

            end

        end
        allS0=find(endCells==0.5);

        for j=1:length(allS0) 

            this_j=allS0(j);

            if rand()<p02

                endCells(this_j)=2;

            end

        end
       endCells=[endCells newCells];
       all_L=length(endCells);
     
        if ~isempty(find(endCells<1, 1))
            res_bottom(i,k)=all_L;
        else
            res_top(i,k)=all_L;
            
        end
    end
end

average_bottom=zeros(numStep,1); 

average_top=zeros(numStep,1);

for i=1:numStep
    
    k_bottom=find(res_bottom(i,:)>0); 
    k_top=find(res_top(i,:)>0); 

    if ~isempty(k_bottom)

        average_bottom(i)=mean(res_bottom(i,k_bottom));
    else
        average_bottom(i)=0;
    end

    if ~isempty(k_top)
        average_top(i)=mean(res_top(i,k_top));
         

    else
        average_top(i)=0;
    end

end

end

