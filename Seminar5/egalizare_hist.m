function []=egalizare_hist(nume,tip)
    % egalizarea histogramei pentru o imagine
    % I: nume - numele fisierului cu imaginea initiala, 
    %    tip - tipul fisierului pentru imaginea modificata
    % E: - 
    % exemple de apel:
    % egalizare_hist('MBS.jpg','png');
    % egalizare_hist('BufnitaS.png','png');
    % egalizare_hist('LennaS.bmp','png');
    % egalizare_hist('Lenna_monoS.bmp','png');
    % egalizare_hist('CatS.png','png');
    
    poza=imread(nume);   %incarcare img
    [~,~,p]=size(poza);  %calculez cate plane are
    rez=poza;
    for k=1:p
        rez(:,:,k)=egalizare_plan(poza(:,:,k));
    end;
    figure
        subplot(1,2,1), imshow(poza);
        title('Imaginea initiala');
        subplot(1,2,2), imshow(uint8(rez));
        title('Imaginea transformata');
    imwrite(rez,[nume '-eh.' tip],tip);
end

function [r]=egalizare_plan(plan)
    % egalizarea histogramei pentru un plan
    % I: plan - planul pe care se lucreaza
    % E: r - planul modificat
    
    [m,n]=size(plan);  %calcul nr linii si coloane
    L=255;
    h=zeros(1,L+1);
    for i=1:m
        for j=1:n
            h(plan(i,j)+1)=h(plan(i,j)+1)+1;  %marir val cu 1
        end;
    end;
    h=h/(m*n);  %transformare in probabilitati
    r=zeros(m,n);
    hnou=zeros(1,L+1);
    hnou(1)=h(1);
    for i=2:L+1
        hnou(i)=hnou(i-1)+h(i);
    end;
    for i=1:m   
        for j=1:n
            r(i,j)=L*hnou(plan(i,j)+1);
        end;
    end;
    r=uint8(r);
end

