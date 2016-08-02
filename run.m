clear;
if exist('report.txt','file')
    delete('report.txt');
    fp=fopen('report.txt','a');
    fclose(fp);
end
diary('report.txt');
diary on;
fprintf('This is the report of homework2: \n');
fprintf('------------------------------------------------------------------------------------\n');
for k=1:5
fprintf('Loop %d \n',k);
importTrain;
importTest;
G=GenerateBN(D_Train);
plot(G);
CPT=CPT(G,D_Train);
fprintf('CPT_best is:\n');
for i=1:6
    fprintf('CPT for gene%d:\n',i);
    disp(CPT{i});
    fprintf('\n');
end
clear CPT;
fprintf('------------------------------------------------------------------------------------\n');
fprintf('This is the prediction of 6 genes expression level: \n');
fprintf('(Reading guidance:column 1 to 20 is the prediction of expression level(0 or 1) colunm 21 is the\n');
fprintf('accuracy of current prediction.And I have done 6 times prediction for each gene.)\n');
for i=1:6
    CPT=CPT(G,D_Train);
    prediction=prediction(i,CPT,D_Test);
    fprintf('Prediction for gene%d:\n',i);
    disp(prediction);
    
    clear CPT;
    clear prediction;
end
score=score(G,D_Train)

clear;
end
diary off;