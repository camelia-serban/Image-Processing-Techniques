function [] = grafic_spectru_Fourier(nume)
    % Vizualizarea spectrului pentru pixelii unei imagini cu/fara centrare
    % imaginea poate fi RGB, se converteste la nuante de gri pentru calcul
    % I: nume - identificator fisier cu imaginea utilizata
    % E: -
    % exemple de apel:
    % grafic_spectru_Fourier('Lena_gs.bmp');
    
    poza=imread(nume);     %preluare imagine    
    [m,n,p]=size(poza);
    if p>1
        I=rgb2gray(poza);
    else
        I=poza;
    end;
    
    f=double(I);
    
    % spectrul reprezentarii Fourier pentru imaginea originala
    g=fft2(f);      % transformarea Fourier a imaginii originale
    sp=abs(g);
    figure
        mesh(sp);
        axis tight;
        title('Spectrul imaginii originale');
   
    % spectrul reprezentarii Fourier pentru imaginea centrata
    % centrare
    for i=1:m
        for j=1:n
            f(i,j)=f(i,j)*(-1)^(i+j);
        end;
    end;
    g=fft2(f);  % transformarea Fourier a imaginii centrate
    sp=abs(g);
    figure
        mesh(sp);
        axis tight;
        title('Spectrul imaginii centrate');
end

