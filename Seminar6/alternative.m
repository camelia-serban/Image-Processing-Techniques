% NU EXECUTATI ACEST SCRIPT! 
% scopul este prezentarea unor secvente de cod ca variante de implementare

% fiind calculate valorile:

% m, n - dimensiuni imagine
% m1, n1 - dimensiuni filtru (valori impare)
% a, b - jumatate din dimensiunile filtrului (valori pare)
% l, c - dimensiuni imagine extinsa

% si considerind: f - imaginea initiala extinsa, w - filtrul
% urmatoarele secvente sint echivalente pentru aplicarea filtrului corelatie

% 1: R - imaginea filtrata (nu e extinsa)
    for i=1:m
        for j=1:n
            for s=-a:a
                for t=-b:b
                    R(i,j)=R(i,j)+w(1+a+s,1+b+t)*f(i+a+s,j+b+t);
                end;
            end;
        end;
    end;
    
% 2: g - imaginea filtrata extinsa, R - imaginea filtrata
    for i=1:m
        for j=1:n
            for s=1:m1
                for t=1:n1
                    g(i+a,j+b)=g(i+a,j+b)+w(s,t)*f(i+s-1,j+t-1);  %matricea extinsa
                end;
            end;
        end;
    end;
    R=uint8( g(a+1:a+m, b+1:b+n) );  %extragere zona centrala
    
 %3: R - imaginea filtrata (nu e extinsa)
    for i=1:m
        for j=1:n
            for s=1:m1
                for t=1:n1
                    R(i,j)=R(i,j)+w(s,t)*f(i+s-1,j+t-1);
                end;
            end;
        end;
    end;