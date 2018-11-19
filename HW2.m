% https://stackoverflow.com/questions/43127920/how-do-i-read-a-raw-rgb-image-in-matlab
% https://www.mathworks.com/matlabcentral/answers/86889-open-a-24-bit-depth-interleaved-rgb-raw-file
row=512;
col=512;
fid=fopen('D:\HW\資料壓縮\HW2\TestImage\GrayImage\Lena.raw', 'r');
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
        temp8x8=dct2(temp8x8);
        temp8x8=temp8x8./LuminanceQT;
        img64x64x8x8(i, j, :, :)=temp8x8;
    end
end

%開始做DC的differential coding, 以及AC的zip-zag

%imgDCT=imgMinus128;
%imgDCT=dct2(imgDCT);
imshow(imgDCT, 'DisplayRange', [0 255]);