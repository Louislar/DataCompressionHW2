%Ū�Jencode���ɮ�
fileID=fopen('jpegEncode.txt');
readIN=fread(fileID);
inStream=transpose(readIN);

%�̲׾�i�Ϥ�����Ʒ|�����b�o��
imgDecode64x64x8x8=zeros(64, 64, 8, 8);

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
%ACBeforeRunSize = (64, 64, 63)
[ACBeforeRunSize, inputIndex]=ACHufReverse(bitStream, inputIndex);

%���۰�AC��zigzag
for i=1:64
    for j=1:64
        imgDecode64x64x8x8(i, j, :, :)=ACZigzagReverse(reshape(ACBeforeRunSize(i, j, :), [1 63]));
    end
end

%��DC���C��8x8���̥��W��
for i=1:64
    for j=1:64
        imgDecode64x64x8x8(i, j, 1, 1)=DCBeforeDIFF(i, j);
    end
end

%Quantization Table
LuminanceQT=[16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 36 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99
    ];
ChrominanceQT=[17 18 24 47 99 99 99 99;
    18 21 26 66 99 99 99 99;
    24 26 56 99 99 99 99 99;
    47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    ];

%�^�_��S����Quantization�H��DCT���e
QF=50;
factor=100;
if QF>=50
    factor=200-2*QF;
end
if QF<50
    factor=5000/QF;
end
LuminanceQT=LuminanceQT.*(factor/100);
for i=1:64
    for j=1:64
        temp8x8=imgDecode64x64x8x8(i, j, 1:8, 1:8);
        temp8x8=reshape(temp8x8, [8 8]);
        temp8x8=fix(temp8x8.*LuminanceQT);       % �� quantization
        temp8x8=idct2(temp8x8);                  % �� DCT
        imgDecode64x64x8x8(i, j, :, :)=temp8x8;
    end
end

%����8x8�ԥ�, �M���^�쥻�Ϥ�����m
imgDecodeflat=[];
for i=1:64
    for j=1:64
        for k=1:8
            for l=1:8
                imgDecodeflat=[imgDecodeflat imgDecode64x64x8x8(i, j, k, l)];
            end
        end
    end
end

%�����쥻�Ϥ���512x512
imgBeforeflat=reshape(imgDecodeflat, [512 512]);
imgBeforeflat=imgBeforeflat.';

%�[�^128
imgDDecode=zeros(512, 512);
for i=1:512
    for j=1:512
        imgDDecode(i, j)=imgBeforeflat(i, j)+128;
    end
end

%��X�Ϥ�
imshow(imgDDecode, 'DisplayRange', [0 255]);
row=512;
col=512;
fid=fopen('Result.raw', 'w');
%��transpose, �]��matlab��X�O�Τ@��@���X
imgDDecode=imgDDecode.';
cnt=fwrite(fid,imgDDecode,'uint8');
fclose(fid);
