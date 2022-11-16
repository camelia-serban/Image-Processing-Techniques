function []=ex_Fourier(nume, tip)
    % exemplificarea reprezentarii polare prin transformarea Fourier a 
    % unei imagini monocrome
    % I: nume - numele fisierului care contine imaginea
    %    tip - tipul fisierelor in care se salveaza imaginile rezultate
    % E: -
    % Exemple de apel:
    % ex_Fourier('amprenta_gs.tif', 'png');
    % ex_Fourier('filtrumedie.jpg','png');
    % ex_Fourier('mb.jpg','png');
    % ex_Fourier('vulpea si marmota.jpg','png');
    % ex_Fourier('cat.jpg','png');
    
    % preluare imagine
    poza=imread(nume);
    [m,n,p]=size(poza);
    if p>1
        plan=rgb2gray(poza);
    else
        plan=poza;
    end;
    
    figure
        imshow(plan);
        title('Imaginea initiala');
        
    f=double(plan);
    %f=centrare(f);
    
    % aplicare TFD si calcul faza, spectru
    y=fft2(f);      % fast-fourier-transform
    R=real(y);      % partea reala
    I=imag(y);      % partea imaginara
    Spectru=abs(y);
    %   atan2 calc. arctangenta in [-pi,pi]; atan calc. in [-pi/2,pi/2]
    Faza=atan2(I,R);
    
    % reprezentare polara
    r_polara=zeros(m,n);
    for i=1:m
        for j=1:n
            r_polara(i,j)= Spectru(i,j) * exp( 1i*Faza(i,j) );
        end;
    end;
    
    % reconstruire imagine pe baza reprezentarii polare
    % dif. intre y si r_polara e insignifianta (erori de calcul si repr.)
    g1=ifft2(r_polara); % inverse fft - sau g1=ifft2(y);
    %g1=centrare(g1);
    figure
        imshow(uint8(g1));
        title('Imaginea reconstruita');
    fi=[nume '-rec.' tip];
    imwrite(uint8(g1),fi,tip);
       
    % imagine reconstruita folosind doar spectrul (faza=1)
    g2=ifft2(Spectru);
    %g2=centrare(g2);
    figure
        imshow(uint8(g2));
        title('Imaginea reconstruita folosind doar spectrul (faza=1)');
    fi=[nume '-spectru.' tip];
    imwrite(uint8(g2),fi,tip);
    
    % imagine reconstruita folosind doar faza; imag. trebuie adusa in 0..255
    Faza1=zeros(m,n);
    for i=1:m
        for j=1:n
            Faza1(i,j)=exp(1i*Faza(i,j));
        end;
    end;
    g3=ifft2(Faza1);
    %g3=centrare(g3);
    % reducere pe 0..255
    vmin=min(min(g3)); vmax=max(max(g3));
    g3=g3-vmin*ones(m,n);
    g3=g3*255/(vmax-vmin);
    figure
        imshow(uint8(g3));
        title('Imaginea reconstruita folosind doar faza');
    fi=[nume '-faza.' tip];
    imwrite(uint8(g3),fi,tip);
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