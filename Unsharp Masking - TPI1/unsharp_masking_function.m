function [] = unsharp_masking_function (nume,tip)
  %filtru unsharp masking pentru prelucrarea unei imagini grayscale/RGB
  %I: nume - numele fișierului cu imaginea de prelucrat
  %   tip - tip fișier pentru imaginea rezultată
  %E: -

  %Exemple de apel:
  %unsharp_masking_function('leaves.jpg','jpg');
  %unsharp_masking_function('dog.jpg','jpg');

  %încărcare imagine
  poza=imread(nume);
  [m,n,p]=size(poza);

  %aplicare filtru pe fiecare plan al imaginii
  A=zeros(m,n,p);
  for k=1:p
    h=fspecial('average');
    A(:,:,k)=imfilter(poza(:,:,k),h);
  endfor
  A=uint8(A);

  %afișare imagine originală și filtrată
  figure
  R=zeros(m,n,p);
  R=(poza-A)+poza;
  R=uint8(R);
    subplot(1,2,1), imshow(poza), title('Imaginea originală');
    subplot(1,2,2), imshow(R), title('Imaginea sharpened');
  fi=[nume '-UMF.' tip];
  imwrite(R,fi,tip);

end
