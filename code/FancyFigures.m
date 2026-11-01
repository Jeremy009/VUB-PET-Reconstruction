%Small script to plot some figures

%Clear console and setup environement
clc
set(0,'defaulttextInterpreter','latex')
set(0,'defaultaxesfontname','Helvetica Neue')
set(0,'defaultaxesfontsize',12)
set(0,'DefaultLineMarkerSize',10)


%Figure 1
if(0)
    x1 = [-10:.1:10];
    normal1 = normpdf(x1,0,1);
    normal2 = normpdf(x1,0,2);
    normal3 = normpdf(x1,0,3);
    normal4 = normpdf(x1,-5,3);

    figure;
    hold on
    plot(x1,normal1,'r')
    plot(x1,normal2,'g')
    plot(x1,normal3,'b')
    plot(x1,normal4,'k')
    xlabel('$x$')
    ylabel('$P(x \mid \mu, \sigma)$')
    title('Normal probability density functions')
    axis([-10,10,0,0.5])
    legend('show')
    legend('$\mu = 0,  \sigma = 1$ ','$\mu = 0,  \sigma = 2$ ','$\mu = 0,  \sigma = 3$ ','$\mu = -5, \sigma = 3\phantom{a}$')
end


%Figure 2
if(0)
    x2 = [0:1:40];
    binom1 = binopdf(x2,30,0.5);
    binom2 = binopdf(x2,30,0.7);
    binom3 = binopdf(x2,50,0.5);

    figure;
    hold on
    plot(x2,binom1,'r.')
    plot(x2,binom2,'g.')
    plot(x2,binom3,'b.')
    xlabel('$x$')
    ylabel('$P(x \mid p,n)$')
    title('Binomial probability mass functions')
    axis([0,40,0,0.3])
    legend('show')
    legend('$p = 0.5, n = 30~~~$ ','$p = 0.7, n = 30\ $ ','$p = 0.5, n = 50\ $ ')
end


%Figure 3
if(0)
    n = 10;
    p = 0.5;
    x3a = [0:1:n];
    x3b = [0:0.1:n];
    approx1 = binopdf(x3a,n,p);
    approx2 = normpdf(x3b,n*p,sqrt(n*p*(1-p)));

    figure;
    hold on
    bar(x3a,approx1,1)
    plot(x3b,approx2,'r')
    xlabel('$x$')
    ylabel('$P$')
    title('Normal approximation of binomial distribution')
    legend('show')
    legend('Binomial: $p = 0.5, n = 10\ $ ','Normal: $\mu = np, \sigma^2 = np(1-p)~~~~~~~$ ')
end


%figure 4
if(0)
    lambda1 = 1;
    lambda2 = 5;
    lambda3 = 10;
    x4 = 0:20;
    poiss1 = poisspdf(x4,lambda1);
    poiss2 = poisspdf(x4,lambda2);
    poiss3 = poisspdf(x4,lambda3);

    figure;
    hold on
    plot(x4,poiss1,'r.')
    plot(x4,poiss2,'g.')
    plot(x4,poiss3,'b.')

    xlabel('$x$')
    ylabel('$P(x \mid \lambda)$')
    title('Poisson probability mass functions')
    legend('show')
    legend('$\lambda = 1\ $', '$\lambda = 5\ $', '$\lambda = 10\ $')
end


%Figure 5
if(0)
    figure;
    hold on
    x = -5:.01:5;
    y = evpdf(x,2,1);
    plot(x,y,'r')
    indexmax = find(max(y) == y);
    xmax = x(indexmax);
    ymax = y(indexmax);
    strmax = ['$x_{ml}$ = ',num2str(xmax)];
    text(xmax+0.5,ymax,strmax,'HorizontalAlignment','left');
    
    z = 0:0.01:ymax;
    k = xmax;
    plot(k,z,'b.');
    
    xlabel('$\vec x$')
    ylabel('$\mathcal{L} \left( \vec x \mid \vec y \right)$')
    title('A likelihood function')
    
    figure;
    hold on
    x = -5:.0001:5;
    y = log(evpdf(x,2,1));
    plot(x,y,'r')
    indexmax = find(max(y) == y);
    xmax = x(indexmax);
    ymax = y(indexmax);
    strmax = ['$x_{ml}$ = ',num2str(xmax)];
    text(xmax+0.5,ymax,strmax,'HorizontalAlignment','left');
    
    z = -18:0.5:ymax;
    k = xmax;
    plot(k,z,'b.');
    
    xlabel('$\vec x$')
    ylabel('$l \left( \vec x \mid \vec y \right)$')
    title('The corresponding log-likelihood')
end


%Figure 6
if(1)
   X = [2 13/8+sqrt(78)/8];
   Y = -(X-2).^3+2*(X-2).^2-(X-2).^4+0.2;
   
   l = 13/8-sqrt(78)/8;
   k = -(l-2).^3+2*(l-2).^2-(l-2).^4+0.2;
   
   figure;
   hold on
   fplot(@(x) -(x-2)^3+2*(x-2)^2-(x-2)^4+0.2, [0 4],'r')
   plot(X,Y,'ko','MarkerFaceColor', 'k')
   plot(l,k,'bo','MarkerFaceColor', 'b')
   axis([0,4,0,4])

   axis
   xlabel('$x$')
   ylabel('$\mathcal{L}$')
   title('A likelihood with a local minimum and maximum')
end


%Figure 7
if(1)
   X = [1.5 2 2.5];
   Y = [1 1 1];
   
   figure;
   hold on
   fplot(@(x) x^4,[0 1],'r')
   fplot(@(x) 1,[1 (1/2)*(5*pi-10)],'r')
   fplot(@(x) sin(x+5),[(1/2)*(5*pi-10) 3*pi-5],'r')
   plot(X,Y,'ko','MarkerFaceColor', 'k')
   axis([0,5,0,1.5])

   axis
   xlabel('$x$')
   ylabel('$\mathcal{L}$')
   title('A partially flat likelihood')
end


%Figure 8
if(1)
   X = 0.5:0.25:3.75;
   Y = 0.05*X+0.8;
   x = 4;
   y = 0.05*x+0.8
    
   figure;
   hold on
   fplot(@(x) 0.05*x+0.8, [0 4],'r')
   fplot(@(x) -(x-4)^2+1,[4 5],'r')
   plot(X,Y,'ko','MarkerFaceColor', 'k')
   plot(x,y,'bo','MarkerFaceColor', 'b')
   axis([0,6,0,5])

   axis
   xlabel('$x$')
   ylabel('$\mathcal{L}$')
   title('An almost flat likelihood')
end


%Figure 8
if(1)
   X = [0.3 0.4 0.6];
   Y = [0.24 0.36 0.36];
    
   figure;
   hold on
   fplot(@(x) -(2*x-1)^2+0.4, [0 1],'r')
   plot(X,Y,'ko','MarkerFaceColor', 'k')
   axis([0,1,0,1])
   axis
   
   xlabel('$x$')
   ylabel('$\mathcal{L}$')
   title('Failing to converge')
end


%Figure 10
if(0)
    X = [1.79887 3.59773 3.59773];
    Y = [5 7.4407 9.57638];
    
   figure;
   hold on
   fplot(@(X) (65-((X-8).^2 + 2*X + 1 + 2*sin(X))) / (4), [0 13.87],'r')
   fplot(@(x) -0.754256*(x-3.59773)^2+7.4407, [0 7],'g')
   fplot(@(x) 5, [0 5.39],'b')
   plot(X,Y,'ko','MarkerFaceColor', 'k')
   line([3.59773 3.59773],[0 9.57638])
   line([1.79887 1.79887],[0 5])
   text(1.79887+0.5,0.5,'$x^{current}$','HorizontalAlignment','left');
   text(3.59773+0.5,0.5,'$x^{next}$','HorizontalAlignment','left');
   
   axis([0 14 0 14])
   xlabel('$x$')
   ylabel('$\mathcal{L}$')
   title('ISRA: Optimisation of a surrogate function')
   legend('show')
   legend('$L(x)$', '$K(x,x^{current}\phantom{a })$    ')
end