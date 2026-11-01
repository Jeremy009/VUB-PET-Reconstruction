%Setup environement
clear all
close all
clc
set(0,'defaulttextInterpreter','latex')
set(0,'defaultaxesfontname','Helvetica Neue')
set(0,'defaultaxesfontsize',12)
set(0,'DefaultLineMarkerSize',10)

%------------------------------------------------------------

%Parameters
A1 = 0.1;
A2 = 1;
TMax = 100;%100
maxIterations = 200;%200
k = 10000;%10000

%Initial guess for the image
ImageNoisy = [1 1];
   
%The system matrix
SystemMatrix = [[1 0];
                [0 1];
                [1 1]];
        
%Pre-allocate reconstruction vectors
X1Noisy = zeros(1,maxIterations);
X2Noisy = zeros(1,maxIterations);
BiasX1 = zeros(1,TMax);
BiasX2 = zeros(1,TMax);

%Run MLEM with different iteration values
TempX1 = zeros(1,k);
TempX2 = zeros(1,k);
TempAnalX1 = zeros(1,k);
TempAnalX2 = zeros(1,k);

for T = 1:TMax
    for j = 1:k
        if mod(j,1000)==0
            fprintf('Run %i.%i\n',T,j)
        end

        DataNoisy = [round(poissrnd(A1 * T)) round(poissrnd(A2 * T)) round(poissrnd((A1 + A2) * T))];
        ImageNoisy = [1 1];
        ImageNoisy = ISRA(ImageNoisy,DataNoisy,SystemMatrix,maxIterations,false)./T;
        
        if isnan(ImageNoisy(1)) 
            ImageNoisy(1) = 0;
        end
        if isnan(ImageNoisy(2))
            ImageNoisy(2) = 0;
        end
        TempX1(j) = ImageNoisy(1);
        TempX2(j) = ImageNoisy(2);
        
        TempAnalX1(j) = ((2*DataNoisy(1) - DataNoisy(2) + DataNoisy(3)) / (3*T));
        TempAnalX2(j) = ((2*DataNoisy(2) - DataNoisy(1) + DataNoisy(3)) / (3*T));
    end
    
    %Compute the bias of the analytical LS estimators
    Ex1Anal = sum(TempAnalX1)/numel(TempAnalX1);
    Ex2Anal = sum(TempAnalX2)/numel(TempAnalX2);
    
    BiasX1Anal(T) = Ex1Anal - A1;
    BiasX2Anal(T) = Ex2Anal - A2;
    
    %Get a numerical estimation on the error on the bias
    StdX1Anal(T) = 0;
    StdX2Anal(T) = 0;
    BiasX1TempAnal = zeros(1,sqrt(k));
    BiasX2TempAnal = zeros(1,sqrt(k));
    
    for l = 1:sqrt(k)
        Ex1Temp = sum(TempAnalX1(1+(l-1)*sqrt(k):l*sqrt(k)))/numel(TempAnalX1(1+(l-1)*sqrt(k):l*sqrt(k)));
        Ex2Temp = sum(TempAnalX2(1+(l-1)*sqrt(k):l*sqrt(k)))/numel(TempAnalX2(1+(l-1)*sqrt(k):l*sqrt(k)));
        BiasX1TempAnal(l) = Ex1Temp - A1;
        BiasX2TempAnal(l) = Ex2Temp - A2;
    end
    
    for l = 1:numel(BiasX1TempAnal)
        StdX1Anal(T) = StdX1Anal(T) + (BiasX1Anal(T)-BiasX1TempAnal(l))^2;
        StdX2Anal(T) = StdX2Anal(T) + (BiasX2Anal(T)-BiasX2TempAnal(l))^2;
    end
    StdX1Anal(T) = sqrt(StdX1Anal(T)/(sqrt(k)-1));
    StdX2Anal(T) = sqrt(StdX2Anal(T)/(sqrt(k)-1));
    
    
    
    
    
    %Compute the bias at time T
    Ex1 = sum(TempX1)/numel(TempX1);
    Ex2 = sum(TempX2)/numel(TempX2);
     
    BiasX1(T) = Ex1 - A1;
    BiasX2(T) = Ex2 - A2;
    
    %Get a numerical estimation on the error on the bias
    StdX1(T) = 0;
    StdX2(T) = 0;
    BiasX1Temp = zeros(1,sqrt(k));
    BiasX2Temp = zeros(1,sqrt(k));
    
    for l = 1:sqrt(k)
        Ex1Temp = sum(TempX1(1+(l-1)*sqrt(k):l*sqrt(k)))/numel(TempX1(1+(l-1)*sqrt(k):l*sqrt(k)));
        Ex2Temp = sum(TempX2(1+(l-1)*sqrt(k):l*sqrt(k)))/numel(TempX2(1+(l-1)*sqrt(k):l*sqrt(k)));
        BiasX1Temp(l) = Ex1Temp - A1;
        BiasX2Temp(l) = Ex2Temp - A2;
    end
    
    for l = 1:numel(BiasX1Temp)
        StdX1(T) = StdX1(T) + (BiasX1(T)-BiasX1Temp(l))^2;
        StdX2(T) = StdX2(T) + (BiasX2(T)-BiasX2Temp(l))^2;
    end
    StdX1(T) = sqrt(StdX1(T)/(sqrt(k)-1));
    StdX2(T) = sqrt(StdX2(T)/(sqrt(k)-1));
    
    
    
    
end

    figure;
    XTime = 1:1:TMax;
    hold on
    plot(XTime,BiasX1,'.b-')
    %errorbar(BiasX1,StdX1)
    plot(XTime,BiasX1Anal,'.g-')
    %errorbar(BiasX1Anal,StdX1Anal)
    legend('ISRA 100 iterations','Analytical LS estimators')
    h1 = plot(XTime,zeros(1,TMax),'r')
    set(get(get(h1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    xlabel('t')
    ylabel('$b(\hat x_1)(t)$')
    title({'The bias of the estimator as a function of the time'})
    hold off
    
    
    
    figure;
    hold on
    plot(XTime,BiasX2,'.b-')
    %errorbar(BiasX2,StdX2)
    plot(XTime,BiasX2Anal,'.g-')
    %errorbar(BiasX2Anal,StdX2Anal)
    legend('ISRA 100 iterations','Analytical LS estimators')
     legend('Location','east')
    h2 = plot(XTime,zeros(1,TMax),'r')
    set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    xlabel('t')
    ylabel('$b(\hat x_2)(t)$')
    title({'The bias of the estimators as a function of the time'})
    hold off

