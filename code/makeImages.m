close all
clc
clear all

%Parameters
NoIterations = 200;
SampleSize = 40;

%Definition of some constants
HEADER = 128;
WIDTH = 512;
HEIGHT = 512;

%Setup
set(0,'defaulttextInterpreter','latex')
set(0,'defaultaxesfontname','Helvetica Neue')
set(0,'defaultaxesfontsize',12)
set(0,'DefaultLineMarkerSize',2)

%--------------------------------------------------------------------------
%Image: Get the convergence of OSEM in the noiseless case
if 0
    A = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 1);
    B = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 10);
    C = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 50);
    D = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 250);
    E = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 750);
    F = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 2000);
    A(1) = 0.7;
    B(1) = 1.6;
    C(1) = 2;
    D(1) = 2.7;
    E(1) = 3.5;
    F(1) = 3.8;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1])
    
    subplot(2,3,1)
    imagesc(vec2mat(A, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 1')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,2)
    imagesc(vec2mat(B, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 10')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,3)
    imagesc(vec2mat(C, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 50')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,4)
    imagesc(vec2mat(D, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 250')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,5)
    imagesc(vec2mat(E, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 750')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,6)
    imagesc(vec2mat(F, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 2000')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    set(gcf,'PaperType','A2')
    orient(fig,'landscape')
    print(fig,'OSEMNoiselessConvergence.pdf','-dpdf')

end


%--------------------------------------------------------------------------
%Image: Get the convergence of ISRA in the noiseless case
if 0
    A = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 1);
    B = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 10);
    C = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 50);
    D = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 250);
    E = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 750);
    F = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 2000);
    A(1) = 0.7;
    B(1) = 1.6;
    C(1) = 2;
    D(1) = 2.7;
    E(1) = 3.5;
    F(1) = 3.8;
    fig = figure('units','normalized','outerposition',[0 0 1 1])
    
    subplot(2,3,1)
    imagesc(vec2mat(A, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 1')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,2)
    imagesc(vec2mat(B, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 10')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,3)
    imagesc(vec2mat(C, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 50')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,4)
    imagesc(vec2mat(D, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 250')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,5)
    imagesc(vec2mat(E, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 750')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,6)
    imagesc(vec2mat(F, HEIGHT))
    set(gca,'YDir','normal')
    title('Iteration 2000')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
       
    set(gcf,'PaperType','A2')
    orient(fig,'landscape')
    print(fig,'ISRANoiselessConvergence.pdf','-dpdf')

end


%--------------------------------------------------------------------------
%Image: The delta images of the noiseless osem case to investigate convergence
if 0
    A = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 1);
    B = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 2);
    DeltaAB = vec2mat(abs(abs(A)-abs(B)),HEIGHT);
    EpsilonAB = sum(abs(abs(A) - abs(B)))
    figAB = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaAB, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_0,I_1)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    C = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 10);
    D = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 11);
    DeltaCD = vec2mat(abs(abs(C)-abs(D)),HEIGHT);
    EpsilonCD = sum(abs(abs(C) - abs(D)))
    figCD = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaCD, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_10,I_11)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    E = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 50);
    F = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 51);
    DeltaEF = vec2mat(abs(abs(E)-abs(F)),HEIGHT);
    EpsilonEF = sum(abs(abs(E) - abs(F)))
    figEF = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaEF, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_50,I_51)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    G = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 250);
    H = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 251);
    DeltaGH = vec2mat(abs(abs(G)-abs(H)),HEIGHT);
    EpsilonGH = sum(abs(abs(G) - abs(H)))
    figGH = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaGH, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_250,I_251)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    I = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 750);
    J = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 751);
    DeltaIJ = vec2mat(abs(abs(I)-abs(J)),HEIGHT);
    EpsilonIJ = sum(abs(abs(I) - abs(J)))
    figIJ = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaIJ, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_750,I_751)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    K = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 1999);
    L = getImage('temp/Jaszczak20.osem', HEADER, WIDTH, HEIGHT, 2000);
    DeltaKL = vec2mat(abs(abs(K)-abs(L)),HEIGHT);
    DeltaKL(1,1)=0.00028;
    EpsilonKL = sum(abs(abs(K) - abs(L)))
    figKL = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaKL, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_{1999},I_{2000})$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
  
    orient(figAB,'landscape')
    print(figAB,'osemDelta1.pdf','-dpdf')
  
    orient(figCD,'landscape')
    print(figCD,'osemDelta2.pdf','-dpdf')  
   
    orient(figEF,'landscape')
    print(figEF,'osemDelta3.pdf','-dpdf')  
    
    orient(figGH,'landscape')
    print(figGH,'osemDelta4.pdf','-dpdf')  
    
    orient(figIJ,'landscape')
    print(figIJ,'osemDelta5.pdf','-dpdf')  
    
    orient(figKL,'landscape')
    print(figKL,'osemDelta6.pdf','-dpdf')
end


%--------------------------------------------------------------------------
%Plot: The delta value for each iteration
if 0
    %Preallocate the needed containers
    IterationValues = 1:1:2000;
    DeltaValue = zeros(2,numel(IterationValues));
        
        
    %Do for MLEM and ISRA
    for a = 1:2
       %Get the filename
        if a == 1
           FileName = 'temp/Jaszczak20.osem'
        elseif a == 2
            FileName = 'temp/Jaszczak20.isra'
        end
        
       %Get the file
        file = fopen(FileName);
        Images = fread(file,Inf,'float32');
        fclose(file);
        
        for i = 1:numel(IterationValues)
            if i == 1
                IterationImage1 = vec2mat(ones(WIDTH,HEIGHT),HEIGHT);
            else
                IterationImage1 = vec2mat(Images(1+HEADER+(i-2)*WIDTH*HEIGHT : HEADER+(i-1)*WIDTH*HEIGHT),HEIGHT);
            end
            IterationImage2 = vec2mat(Images(1+HEADER+(i-1)*WIDTH*HEIGHT : HEADER+i*WIDTH*HEIGHT),HEIGHT);
            DeltaImage = abs(abs(IterationImage1) - abs(IterationImage2));
            a
            Delta = sum(sum(DeltaImage,1),2)
            DeltaValue(a,i) = Delta;
        end
    end
    fig = figure('units','normalized','outerposition',[0 0 1 1],'PaperType','a3');
    set(gca, 'yscale', 'log')
    hold on
    plot(IterationValues(5:2000),DeltaValue(1,5:2000),'-bo','MarkerFaceColor','b')
    plot(IterationValues(5:2000),DeltaValue(2,5:2000),'-rs','MarkerFaceColor','r')
    hold off
    grid on

    
    legend('show')
    l = legend('MLEM','ISRA');
    set(l,'Interpreter','latex')
    set(l,'FontName','Helvetica Neue');
    set(l,'location','best');
    
    xlabel('$\#$ iteration')
    ylabel('log($\Delta$)')
    set(gca, 'yscale', 'log')
    
    orient(fig,'landscape')
    print(fig,'RateOfConvergence.pdf','-dpdf')
    
end

%--------------------------------------------------------------------------
%Image: The delta images of the noiseless isra case to investigate convergence
if 0
    A = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 1);
    B = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 2);
    DeltaAB = vec2mat(abs(abs(A)-abs(B)),HEIGHT);
    EpsilonAB = sum(abs(abs(A) - abs(B)))
    figAB = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaAB, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_0,I_1)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    C = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 10);
    D = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 11);
    DeltaCD = vec2mat(abs(abs(C)-abs(D)),HEIGHT);
    EpsilonCD = sum(abs(abs(C) - abs(D)))
    figCD = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaCD, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_10,I_11)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    E = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 50);
    F = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 51);
    DeltaEF = vec2mat(abs(abs(E)-abs(F)),HEIGHT);
    EpsilonEF = sum(abs(abs(E) - abs(F)))
    figEF = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaEF, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_50,I_51)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    G = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 250);
    H = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 251);
    DeltaGH = vec2mat(abs(abs(G)-abs(H)),HEIGHT);
    EpsilonGH = sum(abs(abs(G) - abs(H)))
    figGH = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaGH, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_250,I_251)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    I = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 750);
    J = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 751);
    DeltaIJ = vec2mat(abs(abs(I)-abs(J)),HEIGHT);
    EpsilonIJ = sum(abs(abs(I) - abs(J)))
    figIJ = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaIJ, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_750,I_751)$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 


    K = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 1999);
    L = getImage('temp/Jaszczak20.isra', HEADER, WIDTH, HEIGHT, 2000);
    DeltaKL = vec2mat(abs(abs(K)-abs(L)),HEIGHT);
	DeltaKL(1,1)=0.00028;
    EpsilonKL = sum(abs(abs(K) - abs(L)))
    figKL = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(DeltaKL, HEIGHT))
    set(gca,'YDir','normal')
    title('$\Delta(I_{1999},I_{2000})$')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
  
    orient(figAB,'landscape')
    print(figAB,'israDelta1.pdf','-dpdf')
  
    orient(figCD,'landscape')
    print(figCD,'israDelta2.pdf','-dpdf')  
   
    orient(figEF,'landscape')
    print(figEF,'israDelta3.pdf','-dpdf')  
    
    orient(figGH,'landscape')
    print(figGH,'israDelta4.pdf','-dpdf')  
    
    orient(figIJ,'landscape')
    print(figIJ,'israDelta5.pdf','-dpdf')  
    
    orient(figKL,'landscape')
    print(figKL,'israDelta6.pdf','-dpdf')
end


%--------------------------------------------------------------------------
%Differences between sinograms
if 0
    A = getImage('temp/Jaszczak20.s10mRun1',HEADER,WIDTH,HEIGHT,1);
    B = getImage('temp/Jaszczak20.s10mRun2',HEADER,WIDTH,HEIGHT,1);
    C = getImage('temp/Jaszczak20.s10mRun34',HEADER,WIDTH,HEIGHT,1);
    D = getImage('temp/Jaszczak20.s10mRun19',HEADER,WIDTH,HEIGHT,1);
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    subplot(2,3,1)
    imagesc(vec2mat(A, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected image based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,2)
    imagesc(vec2mat(B, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected image based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
        
    subplot(2,3,3)
    imagesc(vec2mat(A-B, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected image based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
        subplot(2,3,4)
    imagesc(vec2mat(C, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected image based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,5)
    imagesc(vec2mat(D, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected image based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    subplot(2,3,6)
    imagesc(vec2mat(C-D, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected image based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
end


%--------------------------------------------------------------------------
%Result images based on 40 noise realisations
if 0
%--------------------------------------------------------------------------
%One sample image based on 40 noise realisations ISRA 
    fclose('all')
    file = fopen('temp/Jaszczak20.isra10mRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    A(1) = 3;
    A(2) = 0;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(A, HEIGHT))
    set(gca,'YDir','normal')
    title('One sample ISRA image after 200 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    set(gca, 'LooseInset', get(gca,'TightInset'))
    print(fig,'OneSampleISRA.pdf','-dpdf')
    
    
    
%--------------------------------------------------------------------------
%Expectation image based on 40 noise realisations ISRA
    fclose('all')
    file = fopen('temp/Jaszczak20.isra10mRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.isra10mRun';
            FileName = strcat(FileName,int2str(i));
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end

    A = A./SampleSize;
    A(1) = 3;
    A(2) = 0;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(A, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected ISRA image after 200 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    set(gca, 'LooseInset', get(gca,'TightInset'))
    print(fig,'ExpISRA.pdf','-dpdf')



%--------------------------------------------------------------------------
%Bias image based on 40 noise realisations ISRA
    fclose('all')
    file = fopen('temp/Jaszczak20.isra10mRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.isra10mRun';
            FileName = strcat(FileName,int2str(i));
            disp(FileName)
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end

    A = A./SampleSize;
    B = getImage('temp/Jaszczak20.ima',HEADER,WIDTH,HEIGHT,1);
    CumulISRABiasAmplitude = sum(abs(abs(A) - abs(B)));
    CumulISRABias = sum(A-B);
    disp(CumulISRABias)
    disp(CumulISRABiasAmplitude)
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    C = A-B;
    C(1) = 2;
    C(2) = -1;
    imagesc(vec2mat(C, HEIGHT))
    set(gca,'YDir','normal')
    title('Bias ISRA image after 200 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'BiasISRA.pdf','-dpdf')



%--------------------------------------------------------------------------
%Variance image based on 40 noise realisations ISRA
    fclose('all')
    file = fopen('temp/Jaszczak20.isra10mRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.isra10mRun';
            FileName = strcat(FileName,int2str(i));
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end
    
    A = A./SampleSize;
    B = zeros(262144,1);
    
    for i=1:SampleSize
        FileName = 'temp/Jaszczak20.isra10mRun';
        FileName = strcat(FileName,int2str(i));
        file = fopen(FileName);
        temp = fread(file,Inf,'float32');
        B = B + (temp-A).*(temp-A);
    end
    
    B = B ./ (SampleSize-1);
    
    CumulISRAVarAmplitude = sum(abs(B));
    CumulISRAVar = sum(B);
    disp(CumulISRAVar)
    disp(CumulISRAVarAmplitude)
    B(1) = 4;
    B(2) = 0;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(B, HEIGHT))
    set(gca,'YDir','normal')
    title('Variance ISRA image after 200 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'VarISRA.pdf','-dpdf')


%--------------------------------------------------------------------------
%One sample image based on 40 noise realisations OSEM
    fclose('all')
    file = fopen('temp/Jaszczak20.osem10mRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    A(1) = 3;
    A(2) = 0;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(A, HEIGHT))
    set(gca,'YDir','normal')
    title('One sample MLEM image after 200 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    set(gca, 'LooseInset', get(gca,'TightInset'))
    print(fig,'OneSampleMLEM.pdf','-dpdf')
    
  
    
%--------------------------------------------------------------------------
%Expected image based on 40 noise realisations OSEM
    fclose('all')
    file = fopen('temp/Jaszczak20.osem10mRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.osem10mRun';
            FileName = strcat(FileName,int2str(i));
            disp(FileName)
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end

    A = A./SampleSize;
    A(1) = 3;
    A(2) = 0;    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(A, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected MLEM image after 200 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'ExpMLEM.pdf','-dpdf')



%--------------------------------------------------------------------------
%Bias image based on 40 noise realisations ISRA

    fclose('all')
    file = fopen('temp/Jaszczak20.osem10mRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.osem10mRun';
            FileName = strcat(FileName,int2str(i));
            disp(FileName)
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end

    A = A./SampleSize;
    B = getImage('temp/Jaszczak20.ima',HEADER,WIDTH,HEIGHT,1);
    CumulISRABiasAmplitude = sum(abs(abs(A) - abs(B)));
    CumulISRABias = sum(A-B);
    disp(CumulISRABias)
    disp(CumulISRABiasAmplitude)
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    C = A-B;
    C(1) = 2;
    C(2) = -1;
    imagesc(vec2mat(C, HEIGHT))
    set(gca,'YDir','normal')
    title('Bias MLEM image after 200 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'BiasMLEM.pdf','-dpdf')



%--------------------------------------------------------------------------
%Variance image based on 40 noise realisations ISRA

    fclose('all')
    file = fopen('temp/Jaszczak20.osem10mRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.osem10mRun';
            FileName = strcat(FileName,int2str(i));
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end
    
    A = A./SampleSize;
    B = zeros(262144,1);
    
    for i=1:SampleSize
        FileName = 'temp/Jaszczak20.osem10mRun';
        FileName = strcat(FileName,int2str(i));
        file = fopen(FileName);
        temp = fread(file,Inf,'float32');
        B = B + (temp-A).*(temp-A);
    end
    
    B = B ./ (SampleSize-1);
    
    CumulISRAVarAmplitude = sum(abs(B));
    CumulISRAVar = sum(B);
    disp(CumulISRAVar)
    disp(CumulISRAVarAmplitude)
    B(1) = 4;
    B(2) = 0;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(B, HEIGHT))
    set(gca,'YDir','normal')
    title('Variance MLEM image after 200 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'VarMLEM.pdf','-dpdf')



%--------------------------------------------------------------------------
%Expected image based on 40 noise realisations ISRA
    fclose('all')
    file = fopen('temp/Jaszczak20.isra10mLongRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.isra10mLongRun';
            FileName = strcat(FileName,int2str(i));
            disp(FileName)
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end

    A = A./SampleSize;
    A(1) = 4;
    A(2) = 0;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(A, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected ISRA image after 2000 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'ExpISRA2000.pdf','-dpdf')



%--------------------------------------------------------------------------
%Bias image based on 40 noise realisations ISRA
    fclose('all')
    file = fopen('temp/Jaszczak20.isra10mLongRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.isra10mLongRun';
            FileName = strcat(FileName,int2str(i));
            disp(FileName)
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end

    A = A./SampleSize;
    B = getImage('temp/Jaszczak20.ima',HEADER,WIDTH,HEIGHT,1);
    CumulISRABiasAmplitude = sum(abs(abs(A) - abs(B)));
    CumulISRABias = sum(A-B);
    disp(CumulISRABias)
    disp(CumulISRABiasAmplitude)
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    C=A-B;
    C(1) = 3;
    C(2) = -1.5;
    imagesc(vec2mat(C, HEIGHT))
    set(gca,'YDir','normal')
    title('Bias ISRA image after 2000 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'BiasISRA2000.pdf','-dpdf')



%--------------------------------------------------------------------------
%Variance image based on 40 noise realisations ISRA
    fclose('all')
    file = fopen('temp/Jaszczak20.isra10mLongRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.isra10mLongRun';
            FileName = strcat(FileName,int2str(i));
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end
    
    A = A./SampleSize;
    B = zeros(262144,1);
    
    for i=1:SampleSize
        FileName = 'temp/Jaszczak20.isra10mLongRun';
        FileName = strcat(FileName,int2str(i))
        file = fopen(FileName);
        temp = fread(file,Inf,'float32');
        B = B + (temp-A).*(temp-A);
    end
    
    B = B ./ (SampleSize-1);
    B(1) = 11;
    B(2) = 0;
    
    CumulISRAVarAmplitude = sum(abs(B));
    CumulISRAVar = sum(B);
    disp(CumulISRAVar)
    disp(CumulISRAVarAmplitude)
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(B, HEIGHT))
    set(gca,'YDir','normal')
    title('Variance ISRA image after 2000 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'VarISRA2000.pdf','-dpdf')



%--------------------------------------------------------------------------
%Expected image based on 40 noise realisations OSEM
    fclose('all')
    file = fopen('temp/Jaszczak20.osem10mLongRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.osem10mLongRun';
            FileName = strcat(FileName,int2str(i));
            disp(FileName)
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end

    A = A./SampleSize;
    A(1) = 4;
    A(2) = 0;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(A, HEIGHT))
    set(gca,'YDir','normal')
    title('Expected MLEM image after 2000 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'ExpMLEM2000.pdf','-dpdf')



%--------------------------------------------------------------------------
%Bias image based on 40 noise realisations ISRA
    fclose('all')
    file = fopen('temp/Jaszczak20.osem10mLongRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.osem10mLongRun';
            FileName = strcat(FileName,int2str(i));
            disp(FileName)
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end

    A = A./SampleSize;
    B = getImage('temp/Jaszczak20.ima',HEADER,WIDTH,HEIGHT,1);
    CumulISRABiasAmplitude = sum(abs(abs(A) - abs(B)));
    CumulISRABias = sum(A-B);
    disp(CumulISRABias)
    disp(CumulISRABiasAmplitude)
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    C = A-B;
    C(1) = 3;
    C(2) = -1.5;
    imagesc(vec2mat(C, HEIGHT))
    set(gca,'YDir','normal')
    title('Bias MLEM image after 2000 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'BiasMLEM2000.pdf','-dpdf')



%--------------------------------------------------------------------------
%Variance image based on 40 noise realisations ISRA
    fclose('all')
    file = fopen('temp/Jaszczak20.osem10mLongRun1');
    A = fread(file,Inf,'float32');
    fclose(file);
    
    if SampleSize > 1
        for i=2:SampleSize
            FileName = 'temp/Jaszczak20.osem10mLongRun';
            FileName = strcat(FileName,int2str(i));
            file = fopen(FileName);
            temp = fread(file,Inf,'float32');
            A = A + temp;
            fclose(file);
        end
    end
    
    A = A./SampleSize;
    B = zeros(262144,1);
    
    for i=1:SampleSize
        FileName = 'temp/Jaszczak20.osem10mLongRun';
        FileName = strcat(FileName,int2str(i));
        file = fopen(FileName);
        temp = fread(file,Inf,'float32');
        B = B + (temp-A).*(temp-A);
    end
    
    B = B ./ (SampleSize-1);
    B(1) = 11;
    B(2) = 0;
    CumulISRAVarAmplitude = sum(abs(B));
    CumulISRAVar = sum(B);
    disp(CumulISRAVar)
    disp(CumulISRAVarAmplitude)
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(vec2mat(B, HEIGHT))
    set(gca,'YDir','normal')
    title('Variance MLEM image after 2000 iterations based on 40 noise realisations')
    xlabel('$x$')
    ylabel('$y$')
    pbaspect([1 1 1])
    colorbar 
    
    orient(fig,'landscape')
    print(fig,'VarMLEM2000.pdf','-dpdf')
    fclose('all')
end


%--------------------------------------------------------------------------
%Study of a ROI (Region of Interest)
if 1
    %Reset Matlab and load the workspace
    clc
    clear all
    close all
    load('BiasVsVariance')
    
    
    %Make the containers
    ExpavAlgRoiIteration = zeros(NoAlgorithms,NoRois,NoIterations);
    BiasavAlgRoiIteration = zeros(NoAlgorithms,NoRois,NoIterations);
    VaravAlgRoiIteration = zeros(NoAlgorithms,NoRois,NoIterations);

    
    %Get the relevant values
    for a = 1:NoAlgorithms
        for temp = 1:NoRois
            r = Rois(temp);
            for i = 1:NoIterations
                %Begin iteration
                fprintf('Loop: %i.%i.%i\n',a,r,i);
                Expectation = zeros(T(r),1);
                Bias = zeros(T(r),1); 
                Variance = zeros(T(r),1);
                ReducedTrueImage = zeros(T(r),1);

                
                %To get the expected value at iteration i, in region r, for
                %algorithm a, loop over all samples, average all values and
                %divide by number of samples
                for s = 1:NoSamples
                    Expectation = Expectation + ...
                        squeeze(AlgorithmSampleRoiIterationValue(a,s,r,i,1:T(r)));
                end
                Expectation = Expectation ./ NoSamples;
                ExpavAlgRoiIteration(a,r,i) = sum(Expectation) / T(r);
                
                
                %The bias is easily found by doing E[X] - X_t
                for t = 1:T(r) 
                    ReducedTrueImage(t) = TrueImage(X(r,t),Y(r,t));
                end
                Bias = Expectation - ReducedTrueImage;
                BiasavAlgRoiIteration(a,r,i) = sum(Bias,1) / T(r);
 
           
                %The variance
                for s = 1:NoSamples
                    Variance = Variance + ...
                        (squeeze(AlgorithmSampleRoiIterationValue(a,s,r,i,1:T(r))) - Expectation).^2;
                end
                Variance = Variance ./ (NoSamples - 1);    
                VaravAlgRoiIteration(a,r,i) = sum(Variance,1) / T(r);
            end
        end
    end
      
    if 0
    %Try to add the 2000'th data point
    NoIterations = NoIterations + 1;
    BiasavAlgRoiIteration(1,1,201) = -0.009;
    BiasavAlgRoiIteration(1,2,201) = 0.078;
    BiasavAlgRoiIteration(1,3,201) = -0.035;
    BiasavAlgRoiIteration(1,4,201) = -0.010;

    BiasavAlgRoiIteration(2,1,201) = -0.010;
    BiasavAlgRoiIteration(2,2,201) = 0.078;
    BiasavAlgRoiIteration(2,3,201) = -0.038;
    BiasavAlgRoiIteration(2,4,201) = -0.038;
    
    
    VaravAlgRoiIteration(1,1,201) = 2.415;
    VaravAlgRoiIteration(1,2,201) = 0.141;
    VaravAlgRoiIteration(1,3,201) = 4.731;
    VaravAlgRoiIteration(1,4,201) = 0.873;

    VaravAlgRoiIteration(2,1,201) = 2.401;
    VaravAlgRoiIteration(2,2,201) = 0.138;
    VaravAlgRoiIteration(2,3,201) = 4.696;
    VaravAlgRoiIteration(2,4,201) = 0.872;
    
    %Make the relevant plots
    XValues = 1:NoIterations;
    
    %Figure 1: The expected values in each ROI
    fig = figure('units','normalized','outerposition',[0 0 1 1],'PaperType','a3');
    hold on
    trunc = 50 ;

    set(0,'DefaultLineMarkerSize',5)
    plot(XValues(1:trunc),squeeze( ExpavAlgRoiIteration(1,3,1:trunc) ),'-rs','MarkerFaceColor','r')
    plot(XValues(1:trunc),squeeze( ExpavAlgRoiIteration(2,3,1:trunc) ),'-mo','MarkerFaceColor','m')
    plot(XValues(1:trunc),squeeze( ExpavAlgRoiIteration(1,1,1:trunc) ),'-gs','MarkerFaceColor','g')
    plot(XValues(1:trunc),squeeze( ExpavAlgRoiIteration(2,1,1:trunc) ),'-yo','MarkerFaceColor','y')
    plot(XValues(1:trunc),squeeze( ExpavAlgRoiIteration(1,2,1:trunc) ),'-bs','MarkerFaceColor','b')
    plot(XValues(1:trunc),squeeze( ExpavAlgRoiIteration(2,2,1:trunc) ),'-co','MarkerFaceColor','c')
    plot(XValues(1:trunc),squeeze( ExpavAlgRoiIteration(1,4,1:trunc) ),'-ks','MarkerFaceColor','k')
    plot(XValues(1:trunc),squeeze( ExpavAlgRoiIteration(2,4,1:trunc) ),'-o','MarkerFaceColor',[0.6 0.6 0.6],'color',[0.6 0.6 0.6])

    legend('show')
    l = legend('$<E[\hat x]>_{hot}\ $ (MLEM)',...
        '$<E[\hat x]>_{hot}\ $ (ISRA)',...
        '$<E[\hat x]>_{backgr.}\ $ (MLEM)\quad \quad',...
        '$<E[\hat x]>_{backgr.}\ $ (ISRA)',...
        '$<E[\hat x]>_{cold}\ $ (MLEM)',...
        '$<E[\hat x]>_{cold}\ $ (ISRA)',...
        '$<E[\hat x]>_{edge}\ $ (MLEM)',...
        '$<E[\hat x]>_{edge}\ $ (ISRA)');
    set(l,'Interpreter','latex')
    set(l,'FontName','Helvetica Neue');
    set(l,'location','best');
    
    plot(XValues(1:trunc),ones(1,trunc)*0,'k')
    plot(XValues(1:trunc),ones(1,trunc)*1,'k')
    plot(XValues(1:trunc),ones(1,trunc)*2,'k')
    plot(XValues(1:trunc),ones(1,trunc)*0.4831,'k')
    text(trunc-trunc*0.15,0.05,'$<x>_{cold}$')
    text(trunc-trunc*0.15,0.53,'$<x>_{edge}$')
    text(trunc-trunc*0.15,1.05,'$<x>_{backgr.}$')
    text(trunc-trunc*0.15,2.05,'$<x>_{hot}$')
    
    ylim([-0.2 2.2])
    title('The average expected value in each ROI')
    xlabel('$\#$ iteration')
    ylabel('$<E[\hat x]>_{ROI}$')
    
    orient(fig,'landscape')
    print(fig,'TheExpInRois.pdf','-dpdf')
    
    
    %Figure 2.r: The bias vs. the variance in each ROI
    for r = 1:NoRois
        fig = figure('units','normalized','outerposition',[0 0 1 1],'PaperType','a3');
        hold on
        trunc = 201;
        
        set(0,'DefaultLineMarkerSize',4)
        plot(squeeze(VaravAlgRoiIteration(1,r,1:trunc)),squeeze(BiasavAlgRoiIteration(1,r,1:trunc)),'-bs','MarkerFaceColor','b')
        plot(squeeze(VaravAlgRoiIteration(2,r,1:trunc)),squeeze(BiasavAlgRoiIteration(2,r,1:trunc)),'-ro','MarkerFaceColor','r')
        
        legend('show')
        l = legend('MLEM','ISRA');
        set(l,'Interpreter','latex')
        set(l,'FontName','Helvetica Neue');
        set(l,'location','northeast');
        
        xl = xlim;
        yl = ylim;
        xrange = abs(xl(1) - xl(2));
        xlim([xl(1)-0.05*xrange xl(2)+0.05*xrange]);
        yrange = abs(yl(1) - yl(2));
        ylim([yl(1)-0.05*yrange yl(2)+0.05*yrange]);
        grid on
        
        %Set the axis and title
        if r == 2
            Title = 'The bias  vs. the variance in the cold ROI';
            title(Title)
            ylabel('$<b(\hat x)>_{cold}$')
            xlabel('$<\sigma^2(\hat x)>_{cold}$')
        elseif r == 3
            Title = 'The bias  vs. the variance in the hot ROI';
            title(Title)
            ylabel('$<b(\hat x)>_{hot}$')
            xlabel('$<\sigma^2(\hat x)>_{hot}$')
        elseif r == 1
            Title = 'The bias  vs. the variance in the background ROI';
            title(Title)
            ylabel('$<b(\hat x)>_{backgr.}$')
            xlabel('$<\sigma^2(\hat x)>_{backgr.}$')
        elseif r == 4
            Title = 'The bias vs. the variance on the outer edge';
            title(Title)
            ylabel('$<b(\hat x)>_{edge}$')
            xlabel('$<\sigma^2(\hat x)>_{edge}$')
        end
        
        for i = 1:trunc
            if mod(i,5) == 0 && i > 2
                yl = ylim;
                text(VaravAlgRoiIteration(1,r,i),BiasavAlgRoiIteration(1,r,i)+abs(yl(1)-yl(2))*0.015,int2str(i));
                text(VaravAlgRoiIteration(2,r,i),BiasavAlgRoiIteration(2,r,i)-abs(yl(1)-yl(2))*0.015,int2str(i));
            end
        end
        
        orient(fig,'landscape')
        Title = strcat(Title,'.pdf');
        print(fig,Title,'-dpdf')
    end    
    end
end


%--------------------------------------------------------------------------
%Define circular ROI
if 0
    %Definition of ROIs
    %r = 1: Background
    %r = 2: Cold
    %r = 3: Hot
    %r = 4: Circle
    counter = 1;
    X(1,1) = 0;
    Y(1,1) = 0;
    for x = 248:262
        for y = 248:262
            X(1,counter) = x;
            Y(1,counter) = y;
            counter = counter+1;
        end
    end

    counter = 1;
    X(2,1) = 0;
    Y(2,1) = 0;
    for x = 248:262
        for y = 190:204
            X(2,counter) = x;
            Y(2,counter) = y;
            counter = counter+1;
        end
    end

    counter = 1;
    X(3,1) = 0;
    Y(3,1) = 0;
    for x = 273:287
        for y = 137:151
            X(3,counter) = x;
            Y(3,counter) = y;
            counter = counter+1;
        end
    end

    counter = 1;
    X(4) = 0;
    Y(4) = 0;
    for x = 1:512
        for y = 1:512
            if sqrt((x-256)^2 + (y-256)^2) >= (390/2) && ...
                    sqrt((x-256)^2 + (y-256)^2) <= (410/2)
                X(4,counter) = x;
                Y(4,counter) = y;
                counter = counter + 1;
            end
        end
    end
    
    %Get the true image
    A = getImage('Jaszczak20.ima',HEADER,WIDTH,HEIGHT,1);
    B = vec2mat(A, HEIGHT);
    
    %Get the overlay
    C = zeros(512,512);
    for r = 1:4
        for i = 1:numel(squeeze(X(r,:)))
            if X(r,i) ~= 0 && Y(r,i) ~= 0
                C(X(r,i),Y(r,i)) = 5;
            end
        end
    end
    
    %Display image
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    imagesc(B)

    hold on
    h = image(cat(3, zeros(size(B))./2,zeros(size(B))./2, zeros(size(B))./2));
    set(h, 'AlphaData', C*0.7)
    hold off
    set(gca,'YDir','normal')
    pbaspect([1 1 1])
    colorbar 
    hold off

    orient(fig,'landscape')
    print(fig,'DefRoi.pdf','-dpdf')

end


%--------------------------------------------------------------------------
%Average hypothesis testing
if 0
    %Load the variables
    load('BiasVsVariance2000.mat')
    
    AverageOfEstimatorOverRoi = zeros(NoAlgorithms,NoSamples,NoRois);
    
    for a=1:NoAlgorithms
        for r = 1:NoRois
            for s = 1:NoSamples
                E = 0;
                for v = 1:T(r)
                    E = E + AlgorithmSampleRoiIterationValue(a,s,r,1,v);
                end
                E = E/T(r);    
                AverageOfEstimatorOverRoi(a,s,r) = E;
            end
        end
    end
    
    
    %Do all the t-tests based on 40 samples
    for a = 1:NoAlgorithms
        for r = 1:NoRois
            if r == 1
                mu = 1;
            elseif r == 2
                mu = 0;
            elseif r == 3
                mu = 2;
            elseif r == 4
                mu = 0.4831;
            end

            if r == 2
                [h(a,r),p(a,r)] = ttest(AverageOfEstimatorOverRoi(a,:,r),mu,0.01,'right');
            else
                [h(a,r),p(a,r)] = ttest(AverageOfEstimatorOverRoi(a,:,r),mu,0.01,'both');
            end
        end
    end
end


%--------------------------------------------------------------------------
%Individual hypothesis testing
if 0
    %Load the variables
    load('BiasVsVariance2000.mat')
    
    %Pre-allocation for speed
    h(1:NoAlgorithms,1:NoRois,1:max(T)) = 0;
    p = h;
    
    %Do all the t-tests based on 40 samples
    for a = 1:NoAlgorithms
        for r = 1:NoRois
            for v = 1:T(r)
                if r == 1
                    mu = 1;
                elseif r == 2
                    mu = 0;
                elseif r == 3
                    mu = 2;
                elseif r == 4
                    mu = TrueImage(X(4,v),Y(4,v));
                end
                
                [h(a,r,v),p(a,r,v)] = ttest(AlgorithmSampleRoiIterationValue(a,:,r,1,v),mu,0.01,'both');
                if isnan(p(a,r,v))
                    p(a,r,v) = 0.5;
                end
            end
        end
    end
        
%     fig = figure('units','normalized','outerposition',[0 0 1 1]);
%         title('t-test for MLEM (left) and ISRA (right) with $\alpha = 5\%$')
% 
%     subplot(1,2,1)
%     imagesc(vec2mat(squeeze(h(1,3,1:225)),15));
%     set(gca,'YDir','normal')
%     title('t-test for MLEM in the hot ROI with $\alpha = 5\%$')
%     xlabel('$x$')
%     ylabel('$y$')
%     pbaspect([1 1 1])
% 
% 
%     subplot(1,2,2)
%     imagesc(vec2mat(squeeze(h(2,3,1:225)),15));
%     set(gca,'YDir','normal')
%     title('t-test for ISRA in the hot ROI with $\alpha = 5\%$')
%     xlabel('$x$')
%     ylabel('$y$')
%     pbaspect([1 1 1])
% 
%     
%     orient(fig,'landscape')
%     set(gca, 'LooseInset', get(gca,'TightInset'))
%     print(fig,'blablabla.pdf','-dpdf')
    
    
    for a = 1:NoAlgorithms
        for r = 1:NoRois
            counter = 0;
            averageP = 0;
            for i = 1:T(r)
                averageP = averageP + p(a,r,i);

                if p(a,r,i) < 0.05
                    %fprintf('%i,...%i\n',i,p(a,r,i))
                    counter = counter + 1; 
                end
            end
        
            fprintf('-Alg. %i, Roi. %i--\n',a,r)
            T(r)
            counter
            counter*100/T(r)
            averageP / T(r)
        end
    end

end

