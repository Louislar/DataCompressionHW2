% https://stackoverflow.com/questions/43127920/how-do-i-read-a-raw-rgb-image-in-matlab
% https://www.mathworks.com/matlabcentral/answers/86889-open-a-24-bit-depth-interleaved-rgb-raw-file
filepath='D:\HW\資料壓縮\HW2\TestImage\GrayImage\Lena.raw';
filepath_home='E:\作業吧\資料壓縮\HW2\TestImage\GrayImage\Lena.raw';
row=512;
col=512;
fid=fopen(filepath, 'r');
img=fread(fid, [row, col], 'uint8');
fclose(fid);
img=img.';  %因為matlab fread讀出來會是一行一行的儲存, 所以需要transpose
imshow(img, 'DisplayRange', [0 255]);

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

% -128然後做DCT
% -128 offset
imgMinus128=img;
for i=1:512
    for j=1:512
        imgMinus128(i, j)=imgMinus128(i, j)-128;
    end
end
%DCT需要拉成8X8來做, 好多個8X8最後再組回原本的圖片
imgflat=imgMinus128.';
imgflat=imgflat(:);
imgflat=imgflat.';
img64x64x8x8=zeros(64, 64, 8, 8);
imgflatIndex=1;
for i=1:64
    for j=1:64
        for k=1:8
            for l=1:8
                img64x64x8x8(i, j, k, l)=imgflat(1, imgflatIndex);
                imgflatIndex=imgflatIndex+1;
            end
        end
    end
end
%DCT & Quantization
% Default Quantization factor is 50
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
        temp8x8=img64x64x8x8(i, j, 1:8, 1:8);
        temp8x8=reshape(temp8x8, [8 8]);
        temp8x8=dct2(temp8x8); %DCT
        temp8x8=fix(temp8x8./LuminanceQT); %quantization
        img64x64x8x8(i, j, :, :)=temp8x8;
    end
end

%開始做DC的differential coding, 以及AC的zip-zag
DiffDC=zeros(64, 64);
DiffDC(1, 1)=img64x64x8x8(1, 1, 1, 1);  %最左上角的block的DC不動
%第一行底下DC減上面DC
for i=2:64
    if (i~=1)
        DiffDC(i, 1)=img64x64x8x8(i, 1, 1, 1)-img64x64x8x8(i-1, 1, 1, 1);
    end
end
%其他行是右邊DC減左邊DC 
for i=1:64
    for j=2:64
        DiffDC(i, j)=img64x64x8x8(i, j, 1, 1)-img64x64x8x8(i, j-1, 1, 1);
    end
end

%DC的differential coding做完了, 接著再用DC的hyffman table
%把DC differential code轉成DC Code Word, 稱此process為VLC
%另寫一個VLC(huffman table)的函數會比較好
VLC_DC=[];
for i=1:64
    for j=1:64
        tempBitArray=DCCodeWord(DiffDC(i, j));
        VLC_DC=[VLC_DC tempBitArray];
    end
end

%接著做AC的zig-zag, 以及接下來的runlength coding
zigzagScan=zeros(64, 64, 63);
for i=1:64
    for j=1:64
        zigzagScan(i, j, :)=zig_zag(reshape(img64x64x8x8(i, j, 1:8, 1:8), [8 8]));
    end
end

%Run_length coding
Run_lengthCoding=[];

for i=1:64
    for j=1:64
        Run_lengthCoding=[Run_lengthCoding ACCodeWord( reshape(zigzagScan(i, j, 1:63), [1 63]) )];
    end
end

outputCode=[VLC_DC Run_lengthCoding];
%補0
if mod(length(outputCode), 8)~=0
    for i=1:(8-mod(length(outputCode), 8))
        outputCode=[outputCode 0];
    end
end
result = [];
%用成每8的bit合成1個byte輸出
for i=1:8:length(outputCode)
    temp=[];
    for j=0:7
        temp = [temp (outputCode(i+j)+48)];
    end
    result=[result bin2dec(char(temp))];
end
%寫出檔案
fileID=fopen('jpegEncode.txt','w');
fwrite(fileID,result);
fclose(fileID);


%imgDCT=imgMinus128;
%imgDCT=dct2(imgDCT);
imshow(imgDCT, 'DisplayRange', [0 255]);