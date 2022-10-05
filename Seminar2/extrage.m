function [mesaj]=extrage(poza_o, poza_m, tip)
    % ascunde un mesaj (litere mici, fara spatii / diacritice etc.) 
    % in poza (color sau nuante de gri) prin modificarea cite unui pixel 
    % pentru fiecare litera, in pozitii aleatoare
    % I: poza_i - nume fisier imagine initiala, mesaj - text,
    %    poza_o - nume fisier poza originala (pt. utilizare la extragere), 
    %    poza_m - nume fisier poza modificata, tip - tip fisier imagini rezultate
    %    rezultat: (bmp, png, gif numai pentru nuante de gri)
    % E: ok - 1 in caz de succes, 0 daca imaginea nu are suficienti pixeli 
    %    utilizabili, 99 altfel
    % Exemple de apel:
    %     cod=ascunde('mb.jpg','totiiaunotazecelatpi','mb_orig','mb_mod','png');
    %     cod=ascunde('faza.bmp','maisuseogluma','original','modificat','png');
    
    IO=imread(poza_o);
    [~,~,p]=size(IO);
    %[nr linii, nr coloane, nr plane]
    %~ - folosita cand nu ne intereseaza o valoare
    % trecere de la domeniul [97,122] la [1, 26]
    
    mesaj=1;
    sir=mesaj;    
    
    if p==1
        [IM,mesaj]=codificare(IO,sir);
    elseif p==3
        nr=length(mesaj);
        %puncte=unidrnd(nr,1,2);
        %puncte=sort(puncte);
        puncte=[0 sort(unidrnd(nr,1,2)) nr];
        
        IM=IO;  %zeros(m,n,p);
        i=1;
        while (i<=3) && (mesaj==1)
            [IM(:,:,i),mesaj]=codificare(IO(:,:,i),sir(puncte(i)+1:puncte(i+1)));
            %: - toate liniile si toate coloanele
            i=i+1;
        end;
    else
        mesaj=99;
    end;
    
    if mesaj==1
        fo=[poza_o '.' tip];
        fm=[poza_m '.' tip];
        imwrite(IO,fo,tip);
        imwrite(IM,fm,tip);
    
%       figure
%         imshow(IO);
%         title('poza originala');
%       figure 
%         imshow(IM);
%         title('poza modificata');
    end;
end



function [poza_m,ok]=codificare(poza, mesaj)
    % codificare mesaj dat in 1 plan al pozei (primit)
    % I - poza - 1 plan=o matrice, 
    %     mesaj - coduri numerice asociate literelor (translatate, NU ASCII!)
    % E - poza_m - poza modificata, 1 plan=o matrice
    %     ok - 1 succes, 0 nu sint suficienti pixeli utilizabili
    
    poza_m=poza;
    vmax=255-max(mesaj);
    nr=length(mesaj);           % numar pixeli necesari
    p=pozitii(poza,nr,vmax);    % pixeli folositi: p e matrice cu 2 coloane
    [gasit,~]=size(p);          % numar pixeli utilizabili gasiti
    if gasit~=nr
        ok=0;
    else
        ok=1;
        for i=1:nr
            poza_m(p(i,1),p(i,2)) = poza_m(p(i,1),p(i,2)) + mesaj(i);
        end;
    end;
end



function [poz]=pozitii(poza,nr,vmax)
    % alegere pozitii aleatoare intr-o poza, sortate, sa nu depaseasca o
    % valoare maxima data
    % I: poza - imaginea (1 plan); nr - nr. pozitii necesare,
    %    vmax - val. maxima admisa
    % E: poz - matrice cu coordonatele pozitiilor alese, sortate lexicografic
    
    % verifica daca sint suficienti pixeli utilizabili 
    [temp]=find(poza<=vmax);  %se cauta element cu element in matricea poza si se compara cu vmax, apoi se salveaza intr-un masiv temp
    %temp - un vector de ranguri ale elementelor 
    nrdisp=length(temp);
    if nrdisp<nr    % ar trebui nrdisp mult mai mare ca nr, de ex. disp<10*nr
        poz=[];     % nici o pozitie
    else
        indici=zeros(1,nr);
        [lin,col]=ind2sub(size(poza),temp);
        poz=zeros(nr,2);
        p=0;
        while p<nr
            i=unidrnd(nrdisp);      % alege aleator unul din pixelii disponibili
            if ~ismember(i,indici)  % daca nu a fost deja ales
                p=p+1;          
                indici(p)=i;
                poz(p,1)=lin(i);
                poz(p,2)=col(i);
            end;
        end;
        poz=sortrows(poz);  %sorteaza liniile
    end;
end

