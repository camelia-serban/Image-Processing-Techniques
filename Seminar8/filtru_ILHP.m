function [alpha]=filtru_ILHP(nume, D0, lh, tip, bw)
    % filtrare ideala low/high pass
    % I: nume - numele fisierului cu imaginea de filtrat, 
    %    D0 - raza filtrului,
    %    lh - low ('low' sau orice altceva) / high ('high'), 
    %    tip - tipul fisierului pentru imaginea rezultat
    %    bw - 1 pentru rezultat BW (numai pentru IHP - 'high')
    % E: alpha - procentul din puterea spectrala totala pastrata
    
    % Exemple de apel
    % filtru_ILHP('Lena_gs.bmp', 250, 'high', 'png', 1)     apoi D0 100, 50   
    % filtru_ILHP('Lena_gs.bmp', 100, 'high', 'png', 0)     apoi D0 50, 25
    % filtru_ILHP('Lena_gs.bmp', 150, 'low', 'png', 0)      apoi D0 50, 25
    
    poza=imread(nume);
    [m,n,p]=size(poza);
    % se lucreaza pe imagine gray-scale, 1 plan
    if p>1
        plan=rgb2gray(poza);
    else
        plan=poza;
    end;
    figure
        imshow(plan);
        title('Imaginea initiala');
    
    % l, c - dimensiuni expandare
    % m1, n1 - linia si coloana de unde incepem copierea imaginii initiale 
    % in imaginea expandata
    % m1,n1 - dim bordurii
    l=2*m;
    c=2*n;
    m1=fix(m/2)+1;
    n1=fix(n/2)+1;
    
    % 1. expandare imagine
    f=zeros(l,c);
    f( m1:m+m1-1 , n1:n+n1-1 )=double(plan);
        
    % 2. centrarea imaginii expandate
    fc=centrare(f);  %se gaseste la sfarsit
  
    % 3. transformarea Fourier
    fcTFD=fft2(fc);
    
    % 4. construire functie filtru ideal pentru filtrare "low pass"
    h=zeros(l,c);
    for i=1:l
        for j=1:c
            if Dist(i,j,l,c)<=D0
                h(i,j)=1;
            end;
        end;
    end;
    % filtrul "high pass" e negativul filtrului "low pass"
    if strcmp(lh,'high')
        h=~h;
    end;
    
    % 5. aplicare functie filtru
    %gTFD=zeros(l,c);
    %for i=1:l
    %    for j=1:c
    %        gTFD(i,j)=fcTFD(i,j)*h(i,j);
    %    end;
    %end;
    % varianta de implementare:
    gTFD=fcTFD.*h;  %. -> inmultire element cu element
    
    % 6. reconstruire imagine filtrata
    gc=real(ifft2(gTFD));
    
    % 7. eliminarea centrarii
    g=centrare(gc);
        
    % 8. extragere imagine rezultat
    if strcmp(lh, 'high') && bw==1
        rez1= g(m1:m+m1-1,n1:n+n1-1);  %extragere zona centrala
        % trecere la imaginea binara
        for i=1:m
            for j=1:n
                if(rez1(i,j)>0)
                    rez1(i,j)=255;
                end;
            end;
        end;
        rez=uint8(rez1);
    else    
        rez=uint8( g(m1:m+m1-1, n1:n+n1-1) );
    end;

    figure
        imshow(rez);
        title(['Imaginea filtrata ' lh ' pass cu raza ' num2str(D0)]);
    if strcmp(lh, 'high') && bw==1    
        fi=[nume '-' lh num2str(D0) 'BW.' tip];
    else
        fi=[nume '-' lh num2str(D0) '.' tip];
    end;
    imwrite(rez, fi, tip);
    
    %puterea spectrala
    alpha=calcul_alpha(fcTFD, D0);
    if strcmp(lh, 'high')
        alpha=100-alpha;
    end;
end

function [d]=Dist(i,j,l,c)
    % calcul distanta pentru punctul (i,j) fata de centru in imaginea (l,c)
    l1=l/2;
    c1=c/2;
    d=sqrt((i-l1)^2+(j-c1)^2);
end

function [alpha]=calcul_alpha(F,D0)
    % determinarea procentului din puterea spectrala totala pastrata
    
    [l,c]=size(F);
    %calculul puterii spectrale in fiecare punct
    P=zeros(l,c);
    for i=1:l
        for j=1:c
            P(i,j)=abs(F(i,j))^2;
        end;
    end;

    %calculul puterii spectrale totale
    PT=sum(sum(P));

    %calculul puterii spectrale considerate in total, pentru raza D0
    Pincl=0;
    for i=1:l
        for j=1:c
            if(Dist(i,j,l,c)<=D0)
                Pincl=Pincl+P(i,j);
            end;
        end;
    end;

    %calculul procentului alpha
    alpha=100*Pincl/PT;
end

function [g]=centrare(f)
    [m,n]=size(f);
    g=zeros(m,n);
    for l=1:m
        for c=1:n
            g(l,c)=f(l,c)*(-1)^(l+c);
        end;
    end;
end