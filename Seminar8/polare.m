clear all;
%spirala lui Arhimede
a=0;
b=50;
j=1;
n=20;
for i=1:0.1:n*pi
    r(j)=a+b*i;
    x(j)=r(j)*cos(i);
    y(j)=r(j)*sin(i);
    j=j+1;
end;

figure
    plot(x,y, 'LineWidth',2);
    title(['Spirala lui Arhimede    a=' num2str(a) ', b=' num2str(b) ', ' num2str(n) ' semicercuri']);
    
    
clear all;

%roza polara
a=2;
n=4;
j=1;
for i=1:0.01:3*pi
    r(j)=a*cos(n*i);        % se poate folosi sin
    x(j)=r(j)*cos(i);
    y(j)=r(j)*sin(i);
    j=j+1;
end;

figure
    plot(x,y, 'LineWidth',2);
    title(['Roza polara    a=' num2str(a) ', n=' num2str(n)]);