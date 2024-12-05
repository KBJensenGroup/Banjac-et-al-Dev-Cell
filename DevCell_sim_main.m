clear;
globalStream = RandStream('mlfg6331_64');
RandStream.setGlobalStream(globalStream);

numStep=4*24; 
numSims=10000;


lambda_bottom=log(2)/24;
lambda_top=log(2)/12;

i_p00=1.0;
i_p01=0.0; 
i_p13=0.0;
i_p02=0.0; 
sample_prob=[0.7,0,0.3,0];


[average_top,average_bottom]=DevCell_sim_fun(numStep,numSims,sample_prob,lambda_bottom,lambda_top,i_p00,i_p01,i_p13,i_p02);
