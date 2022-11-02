function [ R ] = filtru_c( I, w )
    % aplicarea filtrului de tip corelatie pe o imagine (un plan)
    % I: I - imaginea initiala (un plan)
    %    w - filtrul aplicat (matrice patrata, dimensiuni impare)
    % E: R - imaginea filtrata
    
    % pentru operatia de corelatie se poate folosi functia MatLab filter2(w,f)
    % pentru operatia de convolutie se poate folosi functia MatLab conv2
    
    [m,n]=size(I);
    [m1,n1]=size(w);
   
    a=(m1-1)/2; b=(n1-1)/2;
    l=m+2*a; c=n+2*b;   %dim imaginii extinse
    
    f=zeros(l,c);
   
    f(a+1:m+a,b+1:n+b)=double(I);
    R=zeros(m,n);  %imaginea rezultata (fara bordura)
       
    % filtrare cu masca w
    for i=1:m
        for j=1:n  
            for s=-a:a  %pt masca
                for t=-b:b   %pt masca
                    R(i,j)=R(i,j)+w(1+a+s,1+b+t)*f(i+a+s,j+b+t);
                end;
            end;
        end;
    end;
end

