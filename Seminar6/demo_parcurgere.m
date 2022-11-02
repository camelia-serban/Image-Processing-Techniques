disp(' ');
disp('Demonstratie perechi de coordonate la aplicarea filtrului de corelatie');
disp('corespunzator celor 3 variante de implementare din fisierul alternative.m');

m1=5; n1=5;                 % dimensiuni filtru
a=(m1-1)/2; b=(n1-1)/2;     % jumatate din dimensiunile filtrului
i=10; j=10;     % coordonatele unui pixel oarecare din imaginea de filtrat (ne-extinsa)

disp(' ');
disp('Coordonate pixel filtrat in imaginea originala: (10,10)');
disp('Varianta 1 (folosita in functia filtru.c):');
disp('ind.parc.- ind.filtr.- imag. orig.- imag.ext.');
for s=-a:a
    for t=-b:b
        % pereche indici parcurgere
        sir1=sprintf('(%2d,%2d)  -  ',s,t);
        % pereche indici element in matricea filtru
        sir2=sprintf('(%2d,%2d)  -  ',1+a+s,1+b+t);
        % pereche indici in matricea de filtrat (ne-extinsa)
        sir3=sprintf('(%2d,%2d)  -  ',i+s , j+t );
        % pereche indici element in matricea de filtrat (imagine extinsa)
        % se adauga a respectiv b pentru ca matricea are a linii
        % suplimentare si b coloane suplimentare
        sir4=sprintf('(%2d,%2d)',i+a+s,j+b+t);
        disp([sir1 sir2 sir3 sir4]);
    end;
end;

disp(' ');
disp('Coordonate pixel filtrat in imaginea originala: (10,10)');
disp('Varianta 2, 3:');
disp('ind.parc.- ind.filtr.- imag. orig.- imag.ext.');
for s=1:m1
    for t=1:n1
        % pereche indici parcurgere
        sir1=sprintf('(%2d,%2d)  -  ',s,t);
        % pereche indici element in matricea filtru
        sir2=sprintf('(%2d,%2d)  -  ',s,t);
        % pereche indici in matricea de filtrat (ne-extinsa)
        sir3=sprintf('(%2d,%2d)  -  ',i+s-1-a , j+t-1-b );
        % pereche indici element in matricea de filtrat (imagine extinsa)
        % se adauga a respectiv b pentru ca matricea are a linii
        % suplimentare si b coloane suplimentare
        sir4=sprintf('(%2d,%2d)',i+s-1,j+t-1);
        disp([sir1 sir2 sir3 sir4]);
    end;
end;

disp(' ');
disp('Coordonate pixel filtrat in imaginea originala: (10,10)');
disp('Convolutie:');
disp('ind.parc.- ind.filtr.- imag. orig.- imag.ext.');
for s=1:m1
    for t=1:n1
        % pereche indici parcurgere
        sir1=sprintf('(%2d,%2d)  -  ',s,t);
        % pereche indici element in matricea filtru
        sir2=sprintf('(%2d,%2d)  -  ',s,t);
        % pereche indici in matricea de filtrat (ne-extinsa)
        sir3=sprintf('(%2d,%2d)  -  ',i+m1-s-a , j+n1-t-b );
        % pereche indici element in matricea de filtrat (imagine extinsa)
        % se adauga a respectiv b pentru ca matricea are a linii
        % suplimentare si b coloane suplimentare
        sir4=sprintf('(%2d,%2d)',i+m1-s,j+n1-t);
        disp([sir1 sir2 sir3 sir4]);
    end;
end;