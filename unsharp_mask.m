function [] = unsharp_mask (nume,alpha,tip)
  %filtru unsharp masking pentru prelucrarea unei imagini grayscale/RGB
  %I: nume - numele fișierului cu imaginea de prelucrat
  %   alpha - valoare care definește transparenț
  %           are valori [0,1]
  %           0,valori apropiate de 0-evidențierea mai multor detalii
  %           1,valori apropiate de 1-detaliile sunt evidențiate
  %   tip - tip fișier pentru imaginea rezultată
  %E: -

  %Exemple de apel:
  %unsharp_mask('dog.jpg',1,'jpg');
  %unsharp_mask('dog.jpg',0,'jpg');
  %unsharp_mask('leaves.jpg',0,'jpg');
  %unsharp_mask('leaves.jpg',1,'jpg');


  %încărcare imagine
  poza=imread(nume);
  [m,n,p]=size(poza);   %[nr linii, nr coloane, nr plane]

  %aplicare filtru pe fiecare plan al imaginii
  R=zeros(m,n,p);   %R-imaginea filtrată
  for k=1:p
    h=fspecial('unsharp',alpha);
    R(:,:,k)=imfilter(poza(:,:,k),h);
  endfor
  R=uint8(R);

  %afișare imagine originală și filtrată
  figure
    subplot(1,2,1), imshow(poza), title('Imaginea originală');
    subplot(1,2,2), imshow(R), title('Imaginea sharpened');
  fi=[nume num2str(alpha) '-UMf.' tip];
  imwrite(R,fi,tip);

end
