%Ū�Jencode���ɮ�
fileID=fopen('jpegEncode.txt');
readIN=fread(fileID);
inStream=transpose(readIN);

%��Ū�J���ɮ��নbinary��array
bitStream=[];
for i=1:length(inStream)
    temp=dec2bin(inStream(i));  %inStream='1010'
    %����8��bit�n�b�e����0
    if length(temp)<8
        for j=1:8-length(temp)
            temp=['0' temp];
        end
    end
    %�C�@�ӼƦr�᭱���n�[�W�Ů�, �o�ˤ~��bcall str2num��, �����}��
    temp_blank='';
    for j=1:length(temp)
        temp_blank=[temp_blank temp(j) ' '];
    end
    temp_blank=str2num(temp_blank);
    bitStream=[bitStream temp_blank];
end

% AC�n���huffman table�ন<run, size>
% DC�n���huffman table�ন����differential�᪺�ˤl
% Encode���ɭԬODC(1, 1)~DC(64, 64)���ۤ~�OAC(1, 1)~AC(64, 64)

%��DC��^�{�٨S�����Lhuffman codeing���ˤl, �åB��^64x64
inputIndex=0;
[inputIndex, DCBeforeHuf]=DCHufReverse(bitStream); 
DCBeforeHuf=reshape(DCBeforeHuf, [64, 64]);
DCBeforeHuf=DCBeforeHuf.';

%�A��DC��^���S�����LDIFF���ˤl
DCBeforeDIFF=zeros(64, 64);
DCBeforeDIFF(1, 1)=DCBeforeHuf(1, 1);
for i=2:64
    DCBeforeDIFF(i, 1)=DCBeforeHuf(i, 1)+DCBeforeDIFF(i-1, 1);
end
for i=1:64
    for j=2:64
        DCBeforeDIFF(i, j)=DCBeforeHuf(i, j)+DCBeforeDIFF(i, j-1);
    end
end

%�}�l��AC����huffman table



