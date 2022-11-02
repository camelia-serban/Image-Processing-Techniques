function [ ] = filtrare_medie( nume,filtru,tip )
    % filtru medie pentru prelucrarea unei imagini grayscale/RGB 
	% I: nume - fisierul cu imaginea de prelucrat, 
    %    filtru - fisier text care contine matricea filtru 
    %    tip - tip fisier pentru imaginea rezultata
    % E: -
    
    % Exemple de apel:
    % filtrare_medie('vulpea si marmota.jpg','m9','png');
    % parametrul filtru poate fi (din exemplele atasate):
    %       - pentru filtrare medie: m3, m5 sau m9 
    %       - pentru filtrare medie ponderata: mp3, mp5 sau mp9
    
    % incarcare imagine
    poza=imread(nume);
    [m,n,p]=size(poza);
    
    %incarcare filtru medie si aplicarea mediei
    nf=[filtru '.txt'];
    w=load(nf);
    suma=sum(sum(w)); 
    w=w/suma;
    
    % aplicare filtru pe fiecare plan al imaginii
    R=zeros(m,n,p);
    for k=1:p
        R(:,:,k)=filtru_c(poza(:,:,k),w);
    end;
    R=uint8(R);
    
    % vizualizare imagine initiala si filtrata
    %     figure
    %         imshow(poza);
    %         title('Imaginea initiala');
    %     figure
    %         imshow(R);
    %         title(['Imaginea filtrata cu filtrul ' filtru]);
    figure
        subplot(1,2,1), imshow(poza), title('Imaginea initiala');
        subplot(1,2,2), imshow(R), title(['Imaginea filtrata cu filtrul ' filtru]);
    fi=[nume '-' filtru '.' tip];
    imwrite(R,fi,tip);
end

