%This script is the implementation of the ML-EM algorithm for the simple 
%toy problem. It is not yet generalised to be used for NxM type of
%problems.

%Setup environement
clear all
close all
clc
set(0,'defaulttextInterpreter','latex')
set(0,'defaultaxesfontname','Helvetica Neue')
set(0,'defaultaxesfontsize',12)
set(0,'DefaultLineMarkerSize',10)

%Load external scripts

%------------------------------------------------------------

%Parameters
A1 = 0.1;
A2 = 1;
T = 1;
maxIterations = 50;

%Initial guess for the image
ImagePure = [1 1];
ImageNoisy = [1 1];

%Generate the pure and noisy data
DataPure = [A1*T A2*T (A1+A2)*T];
DataNoisy = [round(poissrnd(A1 * T)) round(poissrnd(A2 * T)) round(poissrnd((A1 + A2) * T))];
        
%The system matrix
SystemMatrix = [[1 0];
                [0 1];
                [1 1]];
        
%Pre-allocate reconstruction vectors
X1Pure = zeros(1,maxIterations);
X2Pure = zeros(1,maxIterations);
X1Noisy = zeros(1,maxIterations);
X2Noisy = zeros(1,maxIterations);

%Run ISRA with different iteration values
for i = 1:maxIterations
    ImagePure = ISRA(ImagePure,DataPure,SystemMatrix,1,false)./T;
    ImageNoisy = ISRA(ImageNoisy,DataNoisy,SystemMatrix,1,false)./T;
    
    X1Pure(i) = ImagePure(1);
    X2Pure(i) = ImagePure(2);
    X1Noisy(i) = ImageNoisy(1);
    X2Noisy(i) = ImageNoisy(2);
end

%Get the analytical ML estimators
    
    x1mlPure = ((DataPure(1)*(DataPure(1) + DataPure(2) + DataPure(3))) / (2*T*(DataPure(1) + DataPure(2))));
    x2mlPure = ((DataPure(2)*(DataPure(1) + DataPure(2) + DataPure(3))) / (2*T*(DataPure(1) + DataPure(2))));
    
    x1mlNoisy = ((DataNoisy(1)*(DataNoisy(1) + DataNoisy(2) + DataNoisy(3))) / (2*T*(DataNoisy(1) + DataNoisy(2))));
    x2mlNoisy = ((DataNoisy(2)*(DataNoisy(1) + DataNoisy(2) + DataNoisy(3))) / (2*T*(DataNoisy(1) + DataNoisy(2))));

    x1ls = ((2*DataNoisy(1) - DataNoisy(2) + DataNoisy(3)) / (3*T));
    x2ls = ((2*DataNoisy(2) - DataNoisy(1) + DataNoisy(3)) / (3*T));
    
    
%Produce the output
Results = [X1Pure X2Pure; X1Noisy X2Noisy];
for j = 1:2
    for i = 1:numel(X1Pure)
        if (ismember(i, [1 5 10 20 25 30 50 100])) 
            fprintf('%i & %0.5f & %0.5f\\\\ \n',i,Results(j,i),Results(j,i+numel(X1Pure)))
        end
    end
    fprintf('\n----------------------\n')
end




%Print figures
figure;
hold on
plot(1:maxIterations, X1Pure - A1, 'b.-')
line([0 maxIterations],[0 0],'Color','red')
title('ISRA convergence with exact data')
xlabel('Iterations')
ylabel('$\hat x_1 - x_1$')
xl = xlim;
yl = ylim;
axis([xl(1)-0.5 xl(2)+0.5 yl(1)-0.5 yl(2)+0.5])
hold off
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'1','-dpdf')



figure;
hold on
plot(1:maxIterations, X2Pure - A2, 'b.-')
line([0 maxIterations],[0 0],'Color','red')
title('ISRA convergence with exact data')
xlabel('Iterations')
ylabel('$\hat x_2 - x_2$')
xl = xlim;
yl = ylim;
axis([xl(1)-0.5 xl(2)+0.5 yl(1)-0.5 yl(2)+0.5])
hold off
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'2','-dpdf')



figure;
hold on
plot(1:maxIterations, X1Noisy - A1, 'b.-')
line([0 maxIterations],[0 0],'Color','red')
title('ISRA convergence with low count noisy data')
xlabel('Iterations')
ylabel('$\hat x_1 - x_1$')
xl = xlim;
yl = ylim;
axis([xl(1)-0.5 xl(2)+0.5 yl(1)-0.5 yl(2)+0.5])
hold off
fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'5','-dpdf')



figure;
hold on
plot(1:maxIterations, X2Noisy - A2, 'b.-')
line([0 maxIterations],[0 0],'Color','red')
title('ISRA convergence with low count noisy data')
xlabel('Iterations')
ylabel('$\hat x_2 - x_2$')
xl = xlim;
yl = ylim;
axis([xl(1)-0.5 xl(2)+0.5 yl(1)-0.5 yl(2)+0.5])
hold off
fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,'6','-dpdf')