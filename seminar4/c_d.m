function [rez, vp, R, medie, er]=c_d(nrp, baza_nume, tip, nrc)
    % Comprimarea unui set de imagini prin retinerea unui numar mic de
    % componente principale. Imaginile sint in nuante de gri (1 singur
    % plan) si au toate ACEEASI DIMENSIUNE si TEMATICA. Imaginile au
    % dimensiuni MICI
    % I: nrp - numarul de imagini, 
    %    baza_nume - numele fisierelor sint formate pornind de la aceasta baza plus numarul curent, 
    %    tip - tipul fisierelor imagine, 
    %    nrc - numarul de componente pastrate (<<lin*col)
    % E: rez - cod de terminare a operatiei (0=succes, 1=imagini cu
    %    dimensiuni diferite, 2=imagini cu mai mult de un plan)
    %    er - eroarea (medie pe pixel)
    %    date reprezentind imaginile comprimate: 
    %    vp - componentele principale (nrc*(m*n)), 
    %    R - reprezentarea comprimata (nrc*nrp),
    %    medie - vectorul (imaginea) medie ((m*n)*1) 
    
    % Exemplu de apel: 
    %   [rez,~,~,~,er]=c_d(15,'ex','bmp',20);
    
    % incarcare imagini cu verificarea dimensiunilor si numarului de plane
    k=0;  %k- nr de img incarcate
    rez=0;
    while k<nrp && ~rez
        k=k+1;
        fi=[baza_nume num2str(k) '.' tip];  %construies numele fisierului
        poza=imread(fi);   %incarcare imagine
        [m,n,p]=size(poza);
        if p>1
            rez=2;                              %imagine RGB
        else
            if ~exist('imagini','var')         %verific daca exista o variabila imagini %daca e prima imagine
                imagini=uint8(zeros(m,n,nrp));  %aloca variabila
                m1=m;n1=n;      %pastreaza dim. prima imagine pt. comparatie
            end;
            if m~=m1 || n~=n1                   %alte dimensiuni
                rez=1;
            else
                imagini(:,:,k)=poza;            %adauga imagine la masiv 3d
                % optional putem afisa pe ecran imaginile incarcate
                    figure
                    imshow(imagini(:,:,k));
                    title(['Imaginea initiala ' num2str(k)]);
                %inchidere optional
            end;
        end;
    end;
    
	% daca au aparut erori la preluarea imaginilor stop
    if rez
        disp(['Imaginea ' num2str(k) 'nu corespunde: ']);  %nr imaginii problema este dat de k
        if rez==1 
            disp('Are dimensiuni diferite');
        else
            disp('Are mai mult de un plan');
        end;
	
    else
        % altfel se prelucreaza imaginile
        p=m*n;
        % liniarizarea imaginilor initiale, pe linii (lexicografic)
        im_lin=zeros(p,nrp);
        for k=1:nrp     %pt fiecare imagine se realizeaza liniarizarea
            im_lin(:,k)=reshape(imagini(:,:,k)',[1 m*n]);   %reshape liniarizeaza pe coloana
            %liniarizare "manuala"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %for i=1:m               
            %    for j=1:n
            %        im_lin(n*(i-1)+j, k)=double(imagini(i,j,k));
            %    end;
            %end;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end;
        
        %calcul imaginii medii
        % calcul medie si centrare date
        medie=mean(im_lin,2);   % 2 - media coloanelor
        for k=1:nrp
            im_lin(:,k)=im_lin(:,k)-medie;
        end;
        
        % matricea de covarianta de selectie
        ss=cov(im_lin.');
        %varianta pentru calculul matricei de covarianta:%%%%%%%%%%%%
        %ss=zeros(p,p);
        %for k=1:nrp
        %    ss = ss + im_lin(:,k) * (im_lin(:,k).');
        %end;
        %ss=ss/(nrp-1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        % determinarea componentelor principale si retinerea primelor nrc
        [V,L]=eig(ss);
        vp=V(:, p : -1 : p-nrc+1);
		valp=diag(L);
		%er=sum(valp(1:p-nrc))/(m*n*nrp);       %eroare relativa
        er=sum(valp(1:p-nrc));                  %eroare absoluta
        
        % reprezentarea folosind doar componentele retinute
        R=zeros(nrc,nrp);
        for k=1:nrp
            R(:,k)=vp' * im_lin(:,k);
        end;
     
        % reconstructia imaginilor din reprezentarea cu componentele princ.
        im_noi_l=zeros(p,nrp);
        for k=1:nrp
            im_noi_l(:,k)=vp * R(:,k);
        end;
        
        % adaugare medie si revenire la forma matriceala
        im_noi=uint8(zeros(m,n,nrp));
        for k=1:nrp
            matrice=reshape( im_noi_l(:,k)+medie, [n m] );
            im_noi(:,:,k)=uint8(matrice');
            %revenire "manuala"%%%%%%%%%%%%%%%%%%%
            %for i=1:m         
            %    for j=1:n
            %        im_noi(i,j,k)=uint8( im_noi_l((i-1)*n+j,k) + medie((i-1)*n+j) );
            %    end;
            %end;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            figure
                imshow( im_noi(:,:,k) );
                title(['Imaginea ' num2str(k) ' reconstruita']);
			fo=[baza_nume num2str(k) '_r.' tip];  %construire nume fisier
            imwrite(im_noi(:,:,k),fo,tip);
        end;
    end;
end
                
        