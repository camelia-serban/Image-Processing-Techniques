function []=negativa(nume, tip)
    % inversarea luminozitatii unei imagini
    % I: nume - numele fisierului care contine imaginea
    %    tip - tipul fisierului pentru salvarea imaginii prelucrate
    % E: -
    % Exemple de apel:
    % negativa('Cat.jpg','png');
    % negativa('MB.jpg','png');
    % negativa('Lenna_mono.bmp','png');
    
    poza=imread(nume);
    % [~,~,p]=size(poza);
    % rez=poza;
    % for k=1:p
    %    rez(:,:,k)=neg_plan(poza(:,:,k));
    % end;
    rez=255-poza;
    figure
        subplot(1,2,1), imshow(poza);
        title('Imaginea initiala');
        subplot(1,2,2), imshow(rez);
        title('Imaginea transformata');
    imwrite(rez,[nume '-negativ.' tip],tip);
end

function [r]=neg_plan(plan)
    % aplica transformarea negativa asupra unui plan al imaginii
    % I: plan - planul care trebuie prelucrat
    % E: r - rezultatul prelucrarii (planul modificat)
    
    r=255-plan;
end
    