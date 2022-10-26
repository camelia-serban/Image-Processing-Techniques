function []=c_gamma(nume, c, g, tip)
    % transformarea gamma pentru modificarea luminozitatii si contrastului
    % I: nume - numele fisierului care contine imaginea
    %    c, g - constantele transformarii (s = c * r^g )
    %    tip - tipul fisierului pentru salvarea imaginii prelucrate
    % E: -
    % Exemple de apel:
    % c_gamma('CopilS.bmp',1,1.15, 'png');  % fara normalizare
    % c_gamma('CopilS.bmp',1.5,0.75, 'png');    % cu normalizare
    % c_gamma('Amprenta.tif',0.5,1.15)
    % c_gamma('LENNAS.BMP',0.5,1.15, 'png');
    % c_gamma('MBS.jpg',0.4,1.2, 'png'); 
    % c_gamma('vulpea si marmota.jpg',1,1.2, 'png');
    % c_gamma('vulpea si marmota.jpg',1.2,0.8, 'png');
    
    poza=imread(nume);
%     [~,~,p]=size(poza);
%     rez=poza;
%     for k=1:p
%         rez(:,:,k)=gamma_plan(poza(:,:,k),c,g);
%     end;
    rez=uint8(c*double(poza).^g);
    figure
        %subplot(1,2,1), subimage(poza);
        subplot(1,2,1), imshow(poza);
        title('Imaginea initiala');
        %subplot(1,2,2), subimage(rez);
        subplot(1,2,2), imshow(rez);
        title('Imaginea transformata');
    imwrite(rez,[nume '-gamma.' tip],tip);
end

function [r]=gamma_plan(plan,c,g)
    % aplica transformarea gamma asupra unui plan al imaginii
    % I: plan - planul care trebuie prelucrat
    %    c, g - constantele transformarii (s=c * r^g )
    % E: r - rezultatul prelucrarii (planul modificat)
    
    r=double(plan);
    %r = r./255;           % normalizare
    %[m,n]=size(plan);
    %for i=1:m
    %    for j=1:n
    %        r(i,j)=(c*r(i,j)^g);
    %    end;
    %end;
    r=c*r.^g;
    %r = uint8(r*255);     % revenire dupa normalizare
    r=uint8(r);
end
    