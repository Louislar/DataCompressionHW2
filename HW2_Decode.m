%讀入encode的檔案
fileID=fopen('jpegEncode.txt');
readIN=fread(fileID);
inStream=transpose(readIN);

%最終整張圖片的資料會紀錄在這裏
imgDecode64x64x8x8=zeros(64, 64, 8, 8);

%把讀入的檔案轉成binary的array
bitStream=[];
for i=1:length(inStream)
    temp=dec2bin(inStream(i));  %inStream='1010'
    %不足8個bit要在前面補0
    if length(temp)<8
        for j=1:8-length(temp)
            temp=['0' temp];
        end
    end
    %每一個數字後面都要加上空格, 這樣才能在call str2num時, 切分開來
    temp_blank='';
    for j=1:length(temp)
        temp_blank=[temp_blank temp(j) ' '];
    end
    temp_blank=str2num(temp_blank);
    bitStream=[bitStream temp_blank];
end

% AC要對照huffman table轉成<run, size>
% DC要對照huffman table轉成做完differential後的樣子
% Encode的時候是DC(1, 1)~DC(64, 64)接著才是AC(1, 1)~AC(64, 64)

%把DC轉回程還沒有做過huffman codeing的樣子, 並且轉回64x64
inputIndex=0;
[inputIndex, DCBeforeHuf]=DCHufReverse(bitStream); 
DCBeforeHuf=reshape(DCBeforeHuf, [64, 64]);
DCBeforeHuf=DCBeforeHuf.';

%再把DC轉回成沒有做過DIFF的樣子
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


%開始做AC的反huffman table
%ACBeforeRunSize = (64, 64, 63)
[ACBeforeRunSize, inputIndex]=ACHufReverse(bitStream, inputIndex);

%接著做AC反zigzag
for i=1:64
    for j=1:64
        imgDecode64x64x8x8(i, j, :, :)=ACZigzagReverse(reshape(ACBeforeRunSize(i, j, :), [1 63]));
    end
end

%把DC放到每個8x8的最左上角
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

%回復到沒有做Quantization以及DCT之前
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
        temp8x8=fix(temp8x8.*LuminanceQT);       % 反 quantization
        temp8x8=idct2(temp8x8);                  % 反 DCT
        imgDecode64x64x8x8(i, j, :, :)=temp8x8;
    end
end

%先把8x8拉平, 然後放回原本圖片的位置
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

%做成原本圖片的512x512
imgBeforeflat=reshape(imgDecodeflat, [512 512]);
imgBeforeflat=imgBeforeflat.';

%加回128
imgDDecode=zeros(512, 512);
for i=1:512
    for j=1:512
        imgDDecode(i, j)=imgBeforeflat(i, j)+128;
    end
end

%輸出圖片
imshow(imgDDecode, 'DisplayRange', [0 255]);
row=512;
col=512;
fid=fopen('Result.raw', 'w');
%先transpose, 因為matlab輸出是用一行一行輸出
imgDDecode=imgDDecode.';
cnt=fwrite(fid,imgDDecode,'uint8');
fclose(fid);
