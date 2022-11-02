function [ ] = filtrare_Laplace( nume,tip_L,cu_scadere,tip )
    % filtru Laplace pentru prelucrarea unei imagini grayscale/RGB
    % I: nume - numele fisierului cu imaginea de prelucrat 
    %    tip_L - tipul filtrului Laplace: 0 - inv 90g., 1 - inv 45g.
    %    cu_scadere - 0 pentru filtru simplu, 1 - cu scadere din original
    %    tip - tip fisier pentru imaginea rezultata
    % E: -
    
    % Exemple de apel:
    % filtrare_Laplace('Lenna-mono.bmp',0,0,'png');
    % filtrare_Laplace('Lenna-mono.bmp',1,0,'png');
    % filtrare_Laplace('Lenna-mono.bmp',0,1,'png');
    % filtrare_Laplace('Lenna-mono.bmp',1,1,'png');
    % filtrare_Laplace('vulpea si marmota.jpg',0,0,'png');
    % filtrare_Laplace('vulpea si marmota.jpg',1,0,'png');
    % filtrare_Laplace('vulpea si marmota.jpg',0,1,'png');
    % filtrare_Laplace('vulpea si marmota.jpg',1,1,'png');
    
    % incarcare imagine
    poza=imread(nume);
    [m,n,p]=size(poza);
    
    % construire matrice filtru Laplace
    if tip_L==0
        w=[0 1 0; 1 -4 1; 0 1 0];  %la rotatii de 90grade
    else
        w=[1 1 1; 1 -8 1; 1 1 1];  %la rotatii de 45grade -> pastreaza mai multe detalii
    end;

    % aplicare filtru pe fiecare plan al imaginii
    R=zeros(m,n,p);
    for k=1:p
        R(:,:,k)=filtru_c(poza(:,:,k),w);
    end;
    R=uint8(R);
    
    if ~cu_scadere
        figure
            subplot(1,2,1), imshow(poza), title('Imaginea initiala');
            subplot(1,2,2), imshow(R), title(['Imaginea filtrata Laplace in varianta ' num2str(tip_L)]);
        fi=[nume '-L' num2str(tip_L) '.' tip];
        imwrite(R,fi,tip);
    else
        R = poza - R; 
        figure
            subplot(1,2,1), imshow(poza), title('Imaginea initiala');
            subplot(1,2,2), imshow(R), title(['Imaginea filtrata Laplace in varianta ' num2str(tip_L) ' cu scadere']);
        fi=[nume '-L' num2str(tip_L) 'S.' tip];
        imwrite(R,fi,tip);
    end;
end

