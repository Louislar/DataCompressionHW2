%讀入encode的檔案
fileID=fopen('jpegEncode.txt');
readIN=fread(fileID);
inStream=transpose(readIN);

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



