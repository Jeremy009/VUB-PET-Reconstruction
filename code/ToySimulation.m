%Do the configuration
clc
set(0,'defaulttextInterpreter','latex')
set(0,'defaultaxesfontname','Helvetica Neue')
set(0,'defaultaxesfontsize',12)
set(0,'DefaultLineMarkerSize',10)


%Setup
A1 = 0.1;
A2 = 1;        
t = 1; 
G = 0.5;                          %This is an infinite sum used for the var of the ml estimators. 
simulationNumber = 1000;          %WolframAlpha is able to comupte the sum.
runNumber = simulationNumber;
TMAX = 50;
textRequired = 1;
requireFigures = 1;


%----------------------------------------------------------------------
%----------------------------------------------------------------------


%Make some vectors to store the bias in function of the time
%myXVector contains the time
%myYVector contains the biasses' value
%myErrorVector contains the standard deviation of the bias
%This runs for different times
XTime = 1:1:TMAX;

YExpectedValueBiasX1ML = zeros(1,TMAX);
YVarianceBiasX1ML = zeros(1,TMAX);

YExpectedValueBiasX2ML = zeros(1,TMAX);
YVarianceBiasX2ML = zeros(1,TMAX);

YExpectedValueBiasX1LS = zeros(1,TMAX);
YVarianceBiasX1LS = zeros(1,TMAX);

YExpectedValueBiasX2LS = zeros(1,TMAX);
YVarianceBiasX2LS = zeros(1,TMAX);


%Make a loop that repeats the whole simulation for different time values
for T = t:TMAX
    %Get theoretical results for ML
    TExpValA1ML = A1 - ((exp(-T*(A1 + A2)))*(A1 - A2))/4;
    TExpValA2ML = A2 - ((exp(-T*(A2 + A1)))*(A2 - A1))/4;

    mu = A1 + A2;
    nu = A1*A2;
    X = T*(A1+A2);

    TVarA1ML = -((A1 + ((A2 - A1) * exp(-T*mu) / 4))^2) ...
       + (exp(-T*mu) * (T*mu + (T*mu)^2) / (16*T^2)) ...
       + ((T*A1 + (T*A1)^2) / (4*T^2)) ...
       + ((nu*(1-exp(-T*mu)) + A1^2*T*mu) / (2*T*mu)) ...
        + ((1/4) * (T*mu + (T*mu)^2)/((T*mu)^2)) ...
         * ((A1^2 * (1-exp(-T*mu)) + nu*G));

    TVarA2ML = -((A2 + ((A1 - A2) * exp(-T*mu) / 4))^2) ...
       + (exp(-T*mu) * (T*mu + (T*mu)^2) / (16*T^2)) ...
       + ((T*A2 + (T*A2)^2) / (4*T^2)) ...
       + ((nu*(1-exp(-T*mu)) + A2^2*T*mu) / (2*T*mu)) ...
        + ((1/4) * (T*mu + (T*mu)^2)/((T*mu)^2)) ...
         * ((A2^2 * (1-exp(-T*mu)) + nu*G));

     K = (exp(-t*(A1+A2))) / (4);
     L = 1/(2*t*(A1+A2));
     
     J1 = [[1 + (t*(A1-A2)-1)*K (t*(A1-A2)+1)*K];[(t*(A2-A1)+1)*K 1 + (t*(A2-A1)-1)*K]];
     I = [[A1^2+2*A1*A2 -A1*A2];[-A1*A2 A2^2+2*A1*A2]];
     J2 = J1.';
     covML = J1*L*I*J2;
    TCramerRaoA1ML = covML(1,1); 
    TCramerRaoA2ML = covML(2,2);

    TBiasA1ML = (-exp(-T*(A1+A2))) / (4) * (A1-A2);
    TBiasA2ML = (-exp(-T*(A2+A1))) / (4) * (A2-A1);

    TMSEA1ML = TVarA1ML + TBiasA1ML^2;
    TMSEA2ML = TVarA2ML + TBiasA2ML^2;


    %Get the theoretical results for the LS case
    TExpValA1LS = A1;
    TExpValA2LS = A2; 

    Lambda1 = A1*t;
    Lambda2 = A2*t;
    Lambda3 = (A1 + A2)*t;

    TVarA1LS = (1/(9*t*t)) * (4*Lambda1 + Lambda2 + Lambda3);
    TVarA2LS = (1/(9*t*t)) * (4*Lambda2 + Lambda1 + Lambda3);

    TCramerRaoA1LS = ((A1^2 + 2*A1*A2) / (2*T*(A1+A2)));
    TCramerRaoA2LS = (A2^2 + 2*A1*A2) / (2*T*(A1+A2));

    TBiasA1LS = 0;
    TBiasA2LS = 0;

    TMSEA1LS = TVarA1LS;
    TMSEA2LS = TVarA2LS;

    %----------------------------------------------------------------------   
    
    %Start simulating data a couple of times
    %Pre-initialise the vectors
    X1ML = zeros(1,simulationNumber*simulationNumber);
    X2ML = zeros(1,simulationNumber*simulationNumber);
    X1LS = zeros(1,simulationNumber*simulationNumber);
    X2LS = zeros(1,simulationNumber*simulationNumber);

    %Simulate the data
    for i = 1:simulationNumber*simulationNumber
        %Progress output
        if mod(i,1000) == 0 
            fprintf('Simulation: %i.%i\n',T,i) 
        end

        %Simulate data
        y1 = round(poissrnd(A1 * T));
        y2 = round(poissrnd(A2 * T));
        y3 = round(poissrnd((A1 + A2) * T));

        %Get the ML estimators
        if (y1+y2) == 0
            %The special case ML estimators
            x1ml = y3 / (4*T);
            x2ml = y3 / (4*T);

        else
            %The regular ML estimators
            x1ml = ((y1*(y1 + y2 + y3)) / (2*T*(y1 + y2)));
            x2ml = ((y2*(y1 + y2 + y3)) / (2*T*(y1 + y2)));
        end

        %Get the LS estimators
        x1ls = ((2*y1 - y2 + y3) / (3*T));
        x2ls = ((2*y2 - y1 + y3) / (3*T));

        %Store the results
        X1ML(i) = x1ml;
        X2ML(i) = x2ml;
        X1LS(i) = x1ls;
        X2LS(i) = x2ls;
    end
    
    %Get estimators expected value
    expectedValueX1ML = sum(X1ML) / simulationNumber^2;
    expectedValueX2ML = sum(X2ML) / simulationNumber^2;
    expectedValueX1LS = sum(X1LS) / simulationNumber^2;
    expectedValueX2LS = sum(X2LS) / simulationNumber^2;
    
    %Get estimators bias
    biasX1ML = expectedValueX1ML - A1;
    biasX2ML = expectedValueX2ML - A2;
    biasX1LS = expectedValueX1LS - A1;
    biasX2LS = expectedValueX2LS - A2;
    
    %Get estimators variance
    varianceX1ML = 0;
    varianceX2ML = 0;
    varianceX1LS = 0;
    varianceX2LS = 0;
    for i = 1:numel(X1ML)
        varianceX1ML = varianceX1ML + (X1ML(i) - expectedValueX1ML)^2;
        varianceX2ML = varianceX2ML + (X2ML(i) - expectedValueX2ML)^2;
        varianceX1LS = varianceX1LS + (X1LS(i) - expectedValueX1LS)^2;
        varianceX2LS = varianceX2LS + (X2LS(i) - expectedValueX2LS)^2;
    end
    varianceX1ML = varianceX1ML /(simulationNumber^2-1);
    varianceX2ML = varianceX2ML /(simulationNumber^2-1);
    varianceX1LS = varianceX1LS /(simulationNumber^2-1);
    varianceX2LS = varianceX2LS /(simulationNumber^2-1);        
    
    %Get estimators standard deviation
    stdX1ML = sqrt(varianceX1ML);
    stdX2ML = sqrt(varianceX2ML);
    stdX1LS = sqrt(varianceX1LS);
    stdX2LS = sqrt(varianceX2LS);
    
    %Get estimators mean square error
    mseX1ML = varianceX1ML + biasX1ML^2; 
    mseX2ML = varianceX2ML + biasX2ML^2;
    mseX1LS = varianceX1LS + biasX1LS^2;
    mseX2LS = varianceX2LS + biasX2LS^2;
    
    %Estimate error on bias: generate sample of biasses
    biasSampleX1ML = zeros(1,simulationNumber);
    biasSampleX2ML = zeros(1,simulationNumber);
    biasSampleX1LS = zeros(1,simulationNumber);
    biasSampleX2LS = zeros(1,simulationNumber);
    for i = 1:simulationNumber
        a = (i-1)*simulationNumber+1;
        b = i*simulationNumber;
        biasSampleX1ML(i) = (sum(X1ML(a:b)) / simulationNumber) - A1;
        biasSampleX2ML(i) = (sum(X2ML(a:b)) / simulationNumber) - A2;
        biasSampleX1LS(i) = (sum(X1LS(a:b)) / simulationNumber) - A1;
        biasSampleX2LS(i) = (sum(X2LS(a:b)) / simulationNumber) - A2;     
    end
    
    %Estimate error on bias: get expected value of bias in sample   
    ExpValBiasX1ML = sum(biasSampleX1ML) / numel(biasSampleX1ML);
    ExpValBiasX2ML = sum(biasSampleX2ML) / numel(biasSampleX2ML);
    ExpValBiasX1LS = sum(biasSampleX1LS) / numel(biasSampleX1LS);
    ExpValBiasX2LS = sum(biasSampleX2LS) / numel(biasSampleX2LS);

    %Estimate error on bias: get variance
    varBiasX1ML = 0;
    varBiasX2ML = 0;
    varBiasX1LS = 0;
    varBiasX2LS = 0;
    for i = 1:simulationNumber
        varBiasX1ML = varBiasX1ML + (biasSampleX1ML(i) - ExpValBiasX1ML)^2;
        varBiasX2ML = varBiasX2ML + (biasSampleX2ML(i) - ExpValBiasX2ML)^2;
        varBiasX1LS = varBiasX1LS + (biasSampleX1LS(i) - ExpValBiasX1LS)^2;
        varBiasX2LS = varBiasX2LS + (biasSampleX2LS(i) - ExpValBiasX2LS)^2;
    end
    varBiasX1ML = varBiasX1ML / (simulationNumber-1);
    varBiasX2ML = varBiasX2ML / (simulationNumber-1);
    varBiasX1LS = varBiasX1LS / (simulationNumber-1);
    varBiasX2LS = varBiasX2LS / (simulationNumber-1);
    
    %Estimate error on bias: get standard deviation
    stdBiasX1ML = sqrt(varBiasX1ML);
    stdBiasX2ML = sqrt(varBiasX2ML);
    stdBiasX1LS = sqrt(varBiasX1LS);
    stdBiasX2LS = sqrt(varBiasX2LS);
    
    
    YExpectedValueBiasX1ML(T) = biasX1ML;
    YVarianceBiasX1ML(T) = varBiasX1ML;

    YExpectedValueBiasX2ML(T) = biasX2ML;
    YVarianceBiasX2ML(T) = varBiasX2ML;

    YExpectedValueBiasX1LS(T) = biasX1LS;
    YVarianceBiasX1LS(T) = varBiasX1LS;

    YExpectedValueBiasX2LS(T) = biasX2LS;
    YVarianceBiasX2LS(T) = varBiasX2LS;
end

%Output results
fprintf('\n\n\n--- X1ML obs ---\n')
fprintf('%0.5f\n',expectedValueX1ML)
fprintf('%0.5f\n',biasX1ML)
fprintf('%0.5f\n',stdX1ML)
fprintf('%0.5f\n',varianceX1ML)
fprintf('-\n')
fprintf('%0.5f\n',ExpValBiasX1ML)
fprintf('%0.5f\n',stdBiasX1ML)
fprintf('%0.5f\n',mseX1ML)

fprintf('\n\n\n--- X2ML obs ---\n')
fprintf('%0.5f\n',expectedValueX2ML)
fprintf('%0.5f\n',biasX2ML)
fprintf('%0.5f\n',stdX2ML)
fprintf('%0.5f\n',varianceX2ML)
fprintf('-\n')
fprintf('%0.5f\n',ExpValBiasX2ML)
fprintf('%0.5f\n',stdBiasX2ML)
fprintf('%0.5f\n',mseX2ML)

fprintf('\n\n\n--- X1LS obs ---\n')
fprintf('%0.5f\n',expectedValueX1LS)
fprintf('%0.5f\n',biasX1LS)
fprintf('%0.5f\n',stdX1LS)
fprintf('%0.5f\n',varianceX1LS)
fprintf('-\n')
fprintf('%0.5f\n',ExpValBiasX1LS)
fprintf('%0.5f\n',stdBiasX1LS)
fprintf('%0.5f\n',mseX1LS)

fprintf('\n\n\n--- X2LS obs ---\n')
fprintf('%0.5f\n',expectedValueX2LS)
fprintf('%0.5f\n',biasX2LS)
fprintf('%0.5f\n',stdX2LS)
fprintf('%0.5f\n',varianceX2LS)
fprintf('-\n')
fprintf('%0.5f\n',ExpValBiasX2LS)
fprintf('%0.5f\n',stdBiasX2LS)
fprintf('%0.5f\n',mseX2LS)
    
if requireFigures
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    subplot(4,1,1)
    hold on
    plot(XTime,zeros(1,TMAX),'r')
    plot(XTime,YExpectedValueBiasX1ML,'b.')
    errorbar(YExpectedValueBiasX1ML,sqrt(YVarianceBiasX1ML))
    xlabel('t')
    ylabel('$b(\hat x_{1,ML\ })(t)$')
    title({'The bias of the estimators as a function of the time with parameters:';'$x_1 = 0.1$ \phantom{hellowwwwwww} $x_2 = 1.0$ \phantom{hellowwwwwww} $k = 1\ 000\ 000$'})
    hold off
    
    subplot(4,1,2)
    hold on
    plot(XTime,zeros(1,TMAX),'r')
    plot(XTime,YExpectedValueBiasX2ML,'b.')
    errorbar(YExpectedValueBiasX2ML,sqrt(YVarianceBiasX2ML))
    xlabel('t')
    ylabel('$b(\hat x_{2,ML\ })(t)$')
    hold off
    
    subplot(4,1,3)
    hold on
    plot(XTime,zeros(1,TMAX),'r')
    plot(XTime,YExpectedValueBiasX1LS,'b.')
    errorbar(YExpectedValueBiasX1LS,sqrt(YVarianceBiasX1LS))
    xlabel('t')
    ylabel('$b(\hat x_{1,LS\ })(t)$')
    hold off

    subplot(4,1,4)
    hold on
    plot(XTime,zeros(1,TMAX),'r')
    plot(XTime,YExpectedValueBiasX2LS,'b.')
    errorbar(YExpectedValueBiasX2LS,sqrt(YVarianceBiasX2LS))
    xlabel('t')
    ylabel('$b(\hat x_{2,LS\ })(t)$')
    hold off
    
    fig = gcf;
    orient(fig,'portrait')

    
    print('-fillpage','FillPageFigure','-dpdf')
end    
    
%         
% 
%     
%     for i = 1:numel(X1ML)
%             ObservedVariancesX1ML(j) = ObservedVariancesX1ML(j) + (X1ML(i) - ObservedExpectationsX1ML(j))^(2);
%             ObservedVariancesX2ML(j) = ObservedVariancesX2ML(j) + (X2ML(i) - ObservedExpectationsX2ML(j))^(2);
%             ObservedVariancesX1LS(j) = ObservedVariancesX1LS(j) + (X1LS(i) - ObservedExpectationsX1LS(j))^(2);
%             ObservedVariancesX2LS(j) = ObservedVariancesX2LS(j) + (X2LS(i) - ObservedExpectationsX2LS(j))^(2);
%         end
%         ObservedVariancesX1ML(j) = ObservedVariancesX1ML(j) / (simulationNumber-1);
%         ObservedVariancesX2ML(j) = ObservedVariancesX2ML(j) / (simulationNumber-1);
%         ObservedVariancesX1LS(j) = ObservedVariancesX1LS(j) / (simulationNumber-1);
%         ObservedVariancesX2LS(j) = ObservedVariancesX2LS(j) / (simulationNumber-1);
%             
%             
%     ObservedExpectationsX1ML = zeros(1,runNumber*simulationNumber);
%     ObservedExpectationsX2ML = zeros(1,runNumber*simulationNumber);
%     ObservedExpectationsX1LS = zeros(1,runNumber*simulationNumber);
%     ObservedExpectationsX2LS = zeros(1,runNumber*simulationNumber);
% 
%     ObservedVariancesX1ML = zeros(1,runNumber*simulationNumber);
%     ObservedVariancesX2ML = zeros(1,runNumber*simulationNumber);
%     ObservedVariancesX1LS = zeros(1,runNumber*simulationNumber);
%     ObservedVariancesX2LS = zeros(1,runNumber*simulationNumber);
% 
%     BiasX1ML = zeros(1,runNumber*simulationNumber);
%     BiasX2ML = zeros(1,runNumber*simulationNumber);
%     BiasX1LS = zeros(1,runNumber*simulationNumber);
%     BiasX2LS = zeros(1,runNumber*simulationNumber);
% 
% 
%     %Do j runs of i simulations
%     for j = 1:runNumber
%         for i = 1:simulationNumber 
%             %Progress output
%             if mod(i,100) == 0 
%                 fprintf('Simulation: %i.%i.%i \n',T,j,i) 
%             end
% 
%             %Simulate data
%             y1 = round(poissrnd(A1 * T));
%             y2 = round(poissrnd(A2 * T));
%             y3 = round(poissrnd((A1 + A2) * T));
% 
%             %Get the ML estimators
%             if (y1+y2) == 0
%                 %The special case ML estimators
%                 x1ml = y3 / (4*T);
%                 x2ml = y3 / (4*T);
% 
%             else
%                 %The regular ML estimators
%                 x1ml = ((y1*(y1 + y2 + y3)) / (2*T*(y1 + y2)));
%                 x2ml = ((y2*(y1 + y2 + y3)) / (2*T*(y1 + y2)));
%             end
% 
%             %Get the LS estimators
%             x1ls = ((2*y1 - y2 + y3) / (3*T));
%             x2ls = ((2*y2 - y1 + y3) / (3*T));
% 
%             %Store the results
%             X1ML(i) = x1ml;
%             X2ML(i) = x2ml;
%             X1LS(i) = x1ls;
%             X2LS(i) = x2ls;
%         end
% 
% 
%         %Get the expected value of the different estimators
%         ObservedExpectationsX1ML(j) = sum(X1ML) / simulationNumber;
%         ObservedExpectationsX2ML(j) = sum(X2ML) / simulationNumber;
%         ObservedExpectationsX1LS(j) = sum(X1LS) / simulationNumber;
%         ObservedExpectationsX2LS(j) = sum(X2LS) / simulationNumber;
% 
%         
%         %Get the variance of the different estimators
%         for i = 1:numel(X1ML)
%             ObservedVariancesX1ML(j) = ObservedVariancesX1ML(j) + (X1ML(i) - ObservedExpectationsX1ML(j))^(2);
%             ObservedVariancesX2ML(j) = ObservedVariancesX2ML(j) + (X2ML(i) - ObservedExpectationsX2ML(j))^(2);
%             ObservedVariancesX1LS(j) = ObservedVariancesX1LS(j) + (X1LS(i) - ObservedExpectationsX1LS(j))^(2);
%             ObservedVariancesX2LS(j) = ObservedVariancesX2LS(j) + (X2LS(i) - ObservedExpectationsX2LS(j))^(2);
%         end
%         ObservedVariancesX1ML(j) = ObservedVariancesX1ML(j) / (simulationNumber-1);
%         ObservedVariancesX2ML(j) = ObservedVariancesX2ML(j) / (simulationNumber-1);
%         ObservedVariancesX1LS(j) = ObservedVariancesX1LS(j) / (simulationNumber-1);
%         ObservedVariancesX2LS(j) = ObservedVariancesX2LS(j) / (simulationNumber-1);
% 
%         
%         %Get the bias of the different estimators
%         BiasX1ML(j) = ObservedExpectationsX1ML(j) - A1;
%         BiasX2ML(j) = ObservedExpectationsX2ML(j) - A2;
%         BiasX1LS(j) = ObservedExpectationsX1LS(j) - A1;
%         BiasX2LS(j) = ObservedExpectationsX2LS(j) - A2;
%     end
% 
%     
%     %Compute the total expected value
%     OExpectedValueX1ML = sum(ObservedExpectationsX1ML) / numel(ObservedExpectationsX1ML);
%     OExpectedValueX2ML = sum(ObservedExpectationsX2ML) / numel(ObservedExpectationsX2ML);
%     OExpectedValueX1LS = sum(ObservedExpectationsX1LS) / numel(ObservedExpectationsX1LS);
%     OExpectedValueX2LS = sum(ObservedExpectationsX2LS) / numel(ObservedExpectationsX2LS);
%     
%     
%     %Compute the total variance
%     OVarianceX1ML = sum(ObservedVariancesX1ML) / numel(ObservedVariancesX1ML);
%     OVarianceX2ML = sum(ObservedVariancesX2ML) / numel(ObservedVariancesX2ML);
%     OVarianceX1LS = sum(ObservedVariancesX1LS) / numel(ObservedVariancesX1LS);
%     OVarianceX2LS = sum(ObservedVariancesX2LS) / numel(ObservedVariancesX2LS);
%     
% 
%     %Compute the expected value of the biasses
%     OExpectedValueBiasX1ML = sum(BiasX1ML) / numel(BiasX1ML);
%     OExpectedValueBiasX2ML = sum(BiasX2ML) / numel(BiasX2LS);
%     OExpectedValueBiasX1LS = sum(BiasX1LS) / numel(BiasX1ML);
%     OExpectedValueBiasX2LS = sum(BiasX2LS) / numel(BiasX2LS);
% 
% 
%     %Get the variances of the different biasses
%     OVariancesBiasX1ML = 0;
%     OVariancesBiasX2ML = 0;
%     OVariancesBiasX1LS = 0;
%     OVariancesBiasX2LS = 0;
% 
%     for i = 1:numel(BiasX1ML)
%         OVariancesBiasX1ML = OVariancesBiasX1ML + (BiasX1ML(i) - OExpectedValueBiasX1ML)^(2);
%         OVariancesBiasX2ML = OVariancesBiasX2ML + (BiasX2ML(i) - OExpectedValueBiasX2ML)^(2);
%         OVariancesBiasX1LS = OVariancesBiasX1LS + (BiasX1LS(i) - OExpectedValueBiasX1LS)^(2);
%         OVariancesBiasX2LS = OVariancesBiasX2LS + (BiasX2LS(i) - OExpectedValueBiasX2LS)^(2);
%     end
%     OVariancesBiasX1ML = OVariancesBiasX1ML / (numel(BiasX1ML)-1);
%     OVariancesBiasX2ML = OVariancesBiasX2ML / (numel(BiasX2ML)-1);
%     OVariancesBiasX1LS = OVariancesBiasX1LS / (numel(BiasX1LS)-1);
%     OVariancesBiasX2LS = OVariancesBiasX2LS / (numel(BiasX2LS)-1);
%     
%     
%     %Get the MSE of the different estimators
%     OMSEX1ML = OVarianceX1ML + (OExpectedValueX1ML - A1)^2;
%     OMSEX2ML = OVarianceX2ML + (OExpectedValueX2ML - A2)^2;
%     OMSEX1LS = OVarianceX1LS + (OExpectedValueX1LS - A1)^2;
%     OMSEX2LS = OVarianceX2LS + (OExpectedValueX2LS - A2)^2;

    %----------------------------------------------------------------------
    
    %Produce output
%     fprintf('\n\n\n--- X1ML theo ---\n')
%     fprintf('%0.5f\n',TExpValA1ML)
%     fprintf('%0.5f\n',TVarA1ML)
%     fprintf('%0.5f\n',TCramerRaoA1ML)
%     fprintf('%0.5f\n',TBiasA1ML)
%     fprintf('-\n')
%     fprintf('%0.5f\n',TMSEA1ML)
%     
%     fprintf('\n\n\n--- X1ML obs ---\n')
%     fprintf('%0.5f\n',OExpectedValueX1ML)
%     fprintf('%0.5f\n',OVarianceX1ML)
%     fprintf('-\n')
%     fprintf('%0.5f\n',OExpectedValueBiasX1ML)
%     fprintf('%0.5f\n',OVariancesBiasX1ML)
%     fprintf('%0.5f\n',OMSEX1ML)
%     
%     
%     fprintf('\n\n\n--- X2ML theo ---\n')
%     fprintf('%0.5f\n',TExpValA2ML)
%     fprintf('%0.5f\n',TVarA2ML)
%     fprintf('%0.5f\n',TCramerRaoA2ML)
%     fprintf('%0.5f\n',TBiasA2ML)    
%     fprintf('-\n')
%     fprintf('%0.5f\n',TMSEA2ML)
%     
%     fprintf('\n\n\n--- X2ML obs ---\n')
%     fprintf('%0.5f\n',OExpectedValueX2ML)
%     fprintf('%0.5f\n',OVarianceX2ML)
%     fprintf('-\n')
%     fprintf('%0.5f\n',OExpectedValueBiasX2ML)
%     fprintf('%0.5f\n',OVariancesBiasX2ML)
%     fprintf('%0.5f\n',OMSEX2ML)
% 
%     
%     fprintf('\n\n\n--- X1LS theo ---\n')
%     fprintf('%0.5f\n',TExpValA1LS)
%     fprintf('%0.5f\n',TVarA1LS)
%     fprintf('%0.5f\n',TCramerRaoA1LS)
%     fprintf('%0.5f\n',TBiasA1LS)
%     fprintf('-\n')
%     fprintf('%0.5f\n',TMSEA1LS)
% 
%     fprintf('\n\n\n--- X1LS obs ---\n')
%     fprintf('%0.5f\n',OExpectedValueX1LS)
%     fprintf('%0.5f\n',OVarianceX1LS)
%     fprintf('-\n')
%     fprintf('%0.5f\n',OExpectedValueBiasX1LS)
%     fprintf('%0.5f\n',OVariancesBiasX1LS)
%     fprintf('%0.5f\n',OMSEX1LS)
%     
%     
%     fprintf('\n\n\n--- X2LS theo ---\n')
%     fprintf('%0.5f\n',TExpValA2LS)
%     fprintf('%0.5f\n',TVarA2LS)
%     fprintf('%0.5f\n',TCramerRaoA2LS)
%     fprintf('%0.5f\n',TBiasA2LS)
%     fprintf('-\n')
%     fprintf('%0.5f\n',TMSEA2LS)
% 
%     fprintf('\n\n\n--- X2LS obs ---\n')
%     fprintf('%0.5f\n',OExpectedValueX2LS)
%     fprintf('%0.5f\n',OVarianceX2LS)
%     fprintf('-\n')
%     fprintf('%0.5f\n',OExpectedValueBiasX2LS)
%     fprintf('%0.5f\n',OVariancesBiasX2LS)
%     fprintf('%0.5f\n',OMSEX2LS)
%   
%     %----------------------------------------------------------------------
%     
%     %Store the expected value of the biasses, and their errors
%     YExpectedValueBiasX1ML(T) = OExpectedValueBiasX1ML;
%     YVarianceBiasX1ML(T) = sqrt(OVariancesBiasX1ML);
%     
%     YExpectedValueBiasX2ML(T) = OExpectedValueBiasX2ML;
%     YVarianceBiasX2ML(T) = sqrt(OVariancesBiasX2ML);
%     
%     YExpectedValueBiasX1LS(T) = OExpectedValueBiasX1LS;
%     YVarianceBiasX1LS(T) = sqrt(OVariancesBiasX1LS);
%     
%     YExpectedValueBiasX2LS(T) = OExpectedValueBiasX2LS;
%     YVarianceBiasX2LS(T) = sqrt(OVariancesBiasX2LS);
% end
% 
% if requireFigures
%     subplot(4,1,1)
%     hold on
%     plot(XTime,zeros(1,TMAX),'r')
%     plot(XTime,YExpectedValueBiasX1ML,'b.')
%     errorbar(YExpectedValueBiasX1ML,YVarianceBiasX1ML)
%     xlabel('t')
%     ylabel('$E[b(\hat x)](t)$')
%     title('The bias of the Maximum Likelihood estimator of $x_1$')
%     hold off
%     
%     subplot(4,1,2)
%     hold on
%     plot(XTime,zeros(1,TMAX),'r')
%     plot(XTime,YExpectedValueBiasX2ML,'b.')
%     errorbar(YExpectedValueBiasX2ML,YVarianceBiasX2ML)
%     xlabel('t')
%     ylabel('$E[b(\hat x)](t)$')
%     title('The bias of the Maximum Likelihood estimator of $x_2$')
%     hold off
%     
%     subplot(4,1,3)
%     hold on
%     plot(XTime,zeros(1,TMAX),'r')
%     plot(XTime,YExpectedValueBiasX1LS,'b.')
%     errorbar(YExpectedValueBiasX1LS,YVarianceBiasX1LS)
%     xlabel('t')
%     ylabel('$E[b(\hat x)](t)$')
%     title('The bias of the Least Square estimator of $x_1$')
%     hold off
% 
%     subplot(4,1,4)
%     hold on
%     plot(XTime,zeros(1,TMAX),'r')
%     plot(XTime,YExpectedValueBiasX2LS,'b.')
%     errorbar(YExpectedValueBiasX2LS,YVarianceBiasX2LS)
%     xlabel('t')
%     ylabel('$E[b(\hat x)](t)$')
%     title('The bias of the Least Square estimator of $x_2$')
%     hold off
% end
