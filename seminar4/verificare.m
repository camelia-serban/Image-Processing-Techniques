for i=1:15
    fi=['Ex' num2str(i) '.bmp'];
    fo=['Ex' num2str(i) '_r.bmp'];
    a=imread(fi);
    b=imread(fo);
    c=double(a)-double(b);
    d=length(find(c~=0));
    disp(['Pentru imaginea ' num2str(i) ' difera: ' num2str(d) ' pixeli']);
end;