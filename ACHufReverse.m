%input0: 傳入input數列, 全部都是0101的壓縮後資料
%input1: 傳入input數列現在已經被解開的Index數

function [output, inputIndexTemp]=ACHufReverse(input0, input1)
inputNumSeq=input0;
inputIndexTemp=input1;
codewordTable={
    [0 0] [0 1] [1 0 0] [1 0 1 1] [1 1 0 1 0] [1 1 1 1 0 0 0] [1 1 1 1 1 0 0 0] [1 1 1 1 1 1 0 1 1 0] [1 1 1 1 1 1 1 1 1 0 0 0 0 0 1 0] [1 1 1 1 1 1 1 1 1 0 0 0 0 0 1 1];
    [1 1 0 0] [1 1 0 1 1] [1 1 1 1  0 0 1] [1 1 1 1  1 0 1 1  0] [1 1 1 1  1 1 1 0  1 1 0] [1 1 1 1  1 1 1 1  1 0 0 0  0 1 0 0] [1 1 1 1  1 1 1 1  1 0 0 0  0 1 0 1] [1 1 1 1  1 1 1 1  1 0 0 0  0 1 1 0] [1 1 1 1  1 1 1 1  1 0 0 0  0 1 1 1] [1 1 1 1  1 1 1 1  1 0 0 0  1 0 0 0];
    [1 1 1 0  0] [1 1 1 1  1 0 0 1] [1 1 1 1  1 1 0 1  1 1] [1 1 1 1  1 1 1 1  0 1 0 0] [1 1 1 1  1 1 1 1  1 0 0 0  1 0 0 1] [1 1 1 1  1 1 1 1  1 0 0 0  1 0 1 0] [1 1 1 1  1 1 1 1  1 0 0 0  1 0 1 1] [1 1 1 1  1 1 1 1  1 0 0 0  1 1 0 0] [1 1 1 1  1 1 1 1  1 0 0 0  1 1 0 1] [1 1 1 1  1 1 1 1  1 0 0 0  1 1 1 0];
    [1 1 1 0  1 0] [1 1 1 1  1 0 1 1  1] [1 1 1 1  1 1 1 1  0 1 0 1] [1 1 1 1  1 1 1 1  1 0 0 0  1 1 1 1] [1 1 1 1  1 1 1 1  1 0 0 1  0 0 0 0] [1 1 1 1  1 1 1 1  1 0 0 1  0 0 0 1] [1 1 1 1  1 1 1 1  1 0 0 1  0 0 1 0] [1 1 1 1  1 1 1 1  1 0 0 1  0 0 1 1] [1 1 1 1  1 1 1 1  1 0 0 1  0 1 0 0] [1 1 1 1  1 1 1 1  1 0 0 1  0 1 0 1];
    [1 1 1 0  1 1] [1 1 1 1  1 1 1 0  0 0] [1 1 1 1  1 1 1 1  1 0 0 1  0 1 1 0] [1 1 1 1  1 1 1 1  1 0 0 1  0 1 1 1] [1 1 1 1  1 1 1 1  1 0 0 1  1 0 0 0] [1 1 1 1  1 1 1 1  1 0 0 1  1 0 0 1] [1 1 1 1  1 1 1 1  1 0 0 1  1 0 1 0] [1 1 1 1  1 1 1 1  1 0 0 1  1 0 1 1] [1 1 1 1  1 1 1 1  1 0 0 1  1 1 0 0] [1 1 1 1  1 1 1 1  1 0 0 1  1 1 0 1];
    [1 1 1 1  0 1 0] [1 1 1 1  1 1 1 0  1 1 1] [1 1 1 1  1 1 1 1  1 0 0 1  1 1 1 0] [1 1 1 1  1 1 1 1  1 0 0 1  1 1 1 1] [1 1 1 1  1 1 1 1  1 0 1 0  0 0 0 0] [1 1 1 1  1 1 1 1  1 0 1 0  0 0 0 1] [1 1 1 1  1 1 1 1  1 0 1 0  0 0 1 0] [1 1 1 1  1 1 1 1  1 0 1 0  0 0 1 1] [1 1 1 1  1 1 1 1  1 0 1 0  0 1 0 0] [1 1 1 1  1 1 1 1  1 0 1 0  0 1 0 1];
    [1 1 1 1  0 1 1] [1 1 1 1  1 1 1 1  0 1 1 0] [1 1 1 1  1 1 1 1  1 0 1 0  0 1 1 0] [1 1 1 1  1 1 1 1  1 0 1 0  0 1 1 1] [1 1 1 1  1 1 1 1  1 0 1 0  1 0 0 0] [1 1 1 1  1 1 1 1  1 0 1 0  1 0 0 1] [1 1 1 1  1 1 1 1  1 0 1 0  1 0 1 0] [1 1 1 1  1 1 1 1  1 0 1 0  1 0 1 1] [1 1 1 1  1 1 1 1  1 0 1 0  1 1 0 0] [1 1 1 1  1 1 1 1  1 0 1 0  1 1 0 1];
    [1 1 1 1  1 0 1 0] [1 1 1 1  1 1 1 1  0 1 1 1] [1 1 1 1  1 1 1 1  1 0 1 0  1 1 1 0] [1 1 1 1  1 1 1 1  1 0 1 0  1 1 1 1] [1 1 1 1  1 1 1 1  1 0 1 1  0 0 0 0] [1 1 1 1  1 1 1 1  1 0 1 1  0 0 0 1] [1 1 1 1  1 1 1 1  1 0 1 1  0 0 1 0] [1 1 1 1  1 1 1 1  1 0 1 1  0 0 1 1] [1 1 1 1  1 1 1 1  1 0 1 1  0 1 0 0] [1 1 1 1  1 1 1 1  1 0 1 1  0 1 0 1];
    [1 1 1 1  1 1 0 0  0] [1 1 1 1  1 1 1 1  1 0 0 0  0 0 0] [1 1 1 1  1 1 1 1  1 0 1 1  0 1 1 0] [1 1 1 1  1 1 1 1  1 0 1 1  0 1 1 1] [1 1 1 1  1 1 1 1  1 0 1 1  1 0 0 0] [1 1 1 1  1 1 1 1  1 0 1 1  1 0 0 1] [1 1 1 1  1 1 1 1  1 0 1 1  1 0 1 0] [1 1 1 1  1 1 1 1  1 0 1 1  1 0 1 1] [1 1 1 1  1 1 1 1  1 0 1 1  1 1 0 0] [1 1 1 1  1 1 1 1  1 0 1 1  1 1 0 1];
    [1 1 1 1  1 1 0 0  1] [1 1 1 1  1 1 1 1  1 0 1 1  1 1 1 0] [1 1 1 1  1 1 1 1  1 0 1 1  1 1 1 1] [1 1 1 1  1 1 1 1  1 1 0 0  0 0 0 0] [1 1 1 1  1 1 1 1  1 1 0 0  0 0 0 1] [1 1 1 1  1 1 1 1  1 1 0 0  0 0 1 0] [1 1 1 1  1 1 1 1  1 1 0 0  0 0 1 1] [1 1 1 1  1 1 1 1  1 1 0 0  0 1 0 0] [1 1 1 1  1 1 1 1  1 1 0 0  0 1 0 1] [1 1 1 1  1 1 1 1  1 1 0 0  0 1 1 0];
    [1 1 1 1  1 1 0 1  0] [1 1 1 1  1 1 1 1  1 1 0 0  0 1 1 1] [1 1 1 1  1 1 1 1  1 1 0 0  1 0 0 0] [1 1 1 1  1 1 1 1  1 1 0 0  1 0 0 1] [1 1 1 1  1 1 1 1  1 1 0 0  1 0 1 0] [1 1 1 1  1 1 1 1  1 1 0 0  1 0 1 1] [1 1 1 1  1 1 1 1  1 1 0 0  1 1 0 0] [1 1 1 1  1 1 1 1  1 1 0 0  1 1 0 1] [1 1 1 1  1 1 1 1  1 1 0 0  1 1 1 0] [1 1 1 1  1 1 1 1  1 1 0 0  1 1 1 1];
    [1 1 1 1  1 1 1 0  0 1] [1 1 1 1  1 1 1 1  1 1 0 1  0 0 0 0] [1 1 1 1  1 1 1 1  1 1 0 1  0 0 0 1] [1 1 1 1  1 1 1 1  1 1 0 1  0 0 1 0] [1 1 1 1  1 1 1 1  1 1 0 1  0 0 1 1] [1 1 1 1  1 1 1 1  1 1 0 1  0 1 0 0] [1 1 1 1  1 1 1 1  1 1 0 1  0 1 0 1] [1 1 1 1  1 1 1 1  1 1 0 1  0 1 1 0] [1 1 1 1  1 1 1 1  1 1 0 1  0 1 1 1] [1 1 1 1  1 1 1 1  1 1 0 1  1 0 0 0];
    [1 1 1 1  1 1 1 0  1 0] [1 1 1 1  1 1 1 1  1 1 0 1  1 0 0 1] [1 1 1 1  1 1 1 1  1 1 0 1  1 0 1 0] [1 1 1 1  1 1 1 1  1 1 0 1  1 0 1 1] [1 1 1 1  1 1 1 1  1 1 0 1  1 1 0 0] [1 1 1 1  1 1 1 1  1 1 0 1  1 1 0 1] [1 1 1 1  1 1 1 1  1 1 0 1  1 1 1 0] [1 1 1 1  1 1 1 1  1 1 0 1  1 1 1 1] [1 1 1 1  1 1 1 1  1 1 1 0  0 0 0 0] [1 1 1 1  1 1 1 1  1 1 1 0  0 0 0 1];
    [1 1 1 1  1 1 1 1  0 0 0] [1 1 1 1  1 1 1 1  1 1 1 0  0 0 1 0] [1 1 1 1  1 1 1 1  1 1 1 0  0 0 1 1] [1 1 1 1  1 1 1 1  1 1 1 0  0 1 0 0] [1 1 1 1  1 1 1 1  1 1 1 0  0 1 0 1] [1 1 1 1  1 1 1 1  1 1 1 0  0 1 1 0] [1 1 1 1  1 1 1 1  1 1 1 0  0 1 1 1] [1 1 1 1  1 1 1 1  1 1 1 0  1 0 0 0] [1 1 1 1  1 1 1 1  1 1 1 0  1 0 0 1] [1 1 1 1  1 1 1 1  1 1 1 0  1 0 1 0];
    [1 1 1 1  1 1 1 1  1 1 1 0  1 0 1 1] [1 1 1 1  1 1 1 1  1 1 1 0  1 1 0 0] [1 1 1 1  1 1 1 1  1 1 1 0  1 1 0 1] [1 1 1 1  1 1 1 1  1 1 1 0  1 1 1 0] [1 1 1 1  1 1 1 1  1 1 1 0  1 1 1 1] [1 1 1 1  1 1 1 1  1 1 1 1  0 0 0 0] [1 1 1 1  1 1 1 1  1 1 1 1  0 0 0 1] [1 1 1 1  1 1 1 1  1 1 1 1  0 0 1 0] [1 1 1 1  1 1 1 1  1 1 1 1  0 0 1 1] [1 1 1 1  1 1 1 1  1 1 1 1  0 1 0 0];
    [1 1 1 1  1 1 1 1  1 1 1 1  0 1 0 1] [1 1 1 1  1 1 1 1  1 1 1 1  0 1 1 0] [1 1 1 1  1 1 1 1  1 1 1 1  0 1 1 1] [1 1 1 1  1 1 1 1  1 1 1 1  1 0 0 0] [1 1 1 1  1 1 1 1  1 1 1 1  1 0 0 1] [1 1 1 1  1 1 1 1  1 1 1 1  1 0 1 0] [1 1 1 1  1 1 1 1  1 1 1 1  1 0 1 1] [1 1 1 1  1 1 1 1  1 1 1 1  1 1 0 0] [1 1 1 1  1 1 1 1  1 1 1 1  1 1 0 1] [1 1 1 1  1 1 1 1  1 1 1 1  1 1 1 0]};


%總共需要讀入64x64個block, 一個block是8x8
%ACBeforeHufNum 會紀錄解碼出了幾個AC code, 等一下會用EOB判斷解出幾個block了
ACBeforeHufNum=0;

%紀錄輸出的ACcode, 會是直接紀錄在原本8x8矩陣的值
ACBeforeRunLen=zeros(64, 64, 8);

%先會讀到AC Huffman table的encode解出<run, size>
%接著藉由run得到category, 就可以知道接下來要讀幾個bit
%得到一堆0後面接著的數字了, 而之前求的run代表前面有幾個0
while ACBeforeHufNum<64*64
    %紀錄完整的一個block的code
    One8x8=zeros(8, 8);
    %每讀一個bit就掃瞄一次有沒有等於hufman table裡面任何一個entry
    inputBuf=[];
    FindRun=0;
    FindSize=0;
    %讀一個bit, 直到找到<run, size>為止
    while 1==1
        %讀進一個bit
        inputBuf=[inputBuf inputNumSeq(inputIndexTemp)];
        inputIndexTemp=inputIndexTemp+1;
        isFinded=0;
        %檢查當前input buffer有無等於任何hufman table裡面任何一個entry
        for i=1:16
            for j=1:10
                tempCheckingArray=cell2mat(codewordTable(i, j));
                tempBoolArray=  inputBuf==tempCheckingArray;
                %有完全相等的entry代表tempBoolArray全為1
                %若是我找0, 就會回傳一個empty的array
                tempFindArray=find(tempBoolArray==0);
                %是empty代表找到<run, size>了
                %並且把兩層for迴圈break
                if isempty(tempFindArray)
                    FindRun=i-1;
                    FindSize=j;
                    isFinded=1;
                    break;
                end
            end
            if isFinded==1
                break;
            end
        end
        %兩種例外要特別處理, EOB, 16個0
        isEOB= inputBuf==[1 0 1 0];
        is16Zero= inputBuf==[1 1 1 1  1 1 1 1  0 0 1]
        if isempty(find(EOB))
            FindRun=0;
            FindSize=0;
            isFinded=1;
        end
        if isempty(find(is16Zero))
            FindRun=15;
            FindSize=0;
            isFinded=1;
        end
        if isFinded==1
            break;
        end
    end
    
    %找到<run, size>後利用size求後面的那個數(一堆0後面的)
    %用size可以知道接下來要讀幾個bit
    
    
    
    ACBeforeHufNum=ACBeforeHufNum+1;
end






