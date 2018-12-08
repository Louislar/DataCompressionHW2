%input0: 傳入input數列, 全部都是0101的壓縮後資料
%input1: 傳入input數列現在已經被解開的Index數

function [output, inputIndexTemp]=ACHufReverse(input0, input1)
%測試用_此為壓縮時的結果_也就是正確答案
load('tempZigzag.mat');
%測試用END
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

%紀錄輸出的ACcode, 會是直接紀錄在原本1x63矩陣的值
ACBeforeRunLen=zeros(64, 64, 63);
ACBeforeRunLenRow=1;
ACBeforeRunLenColumn=1;

%這個buffer會用於紀錄每次解出<run, size>後得到的值
%直到讀到EOB才會將它寫入ACBeforeRunLen, 並且把自己清空
%紀錄完整的一個block的code
One8x8=zeros(1, 63);
One8x8Index=1;


%先會讀到AC Huffman table的encode解出<run, size>
%接著藉由run得到category, 就可以知道接下來要讀幾個bit
%得到一堆0後面接著的數字了, 而之前求的run代表前面有幾個0
while ACBeforeHufNum<64*64
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
        
        
        %兩種例外要特別處理, EOB, 16個0
        if length(inputBuf)==length([1 0 1 0])
            isEOB= inputBuf==[1 0 1 0];
            if isempty(find(isEOB==0))
            FindRun=0;
            FindSize=0;
            isFinded=1;
            end
        end
        %當初在壓縮的時候遇到16個0, 會放runsizeCodeWord在加上一個0
        if length(inputBuf)==length([1 1 1 1  1 1 1 1  0 0 1 0])
            is16Zero= inputBuf==[1 1 1 1  1 1 1 1  0 0 1 0];
            if isempty(find(is16Zero==0))
                FindRun=15;
                FindSize=0;
                isFinded=1;
            end
        end
        
        
        %如果是EOB或是16個0就不用再找了
        if isFinded==0
        %檢查當前input buffer有無等於任何hufman table裡面任何一個entry
        for i=1:16
            for j=1:10
                tempCheckingArray=cell2mat(codewordTable(i, j));
                if length(inputBuf)~=length(tempCheckingArray)
                    continue;
                end
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
        end
        
        if isFinded==1
            break;
        end
    end
    
    %找到<run, size>後利用size求後面的那個數(一堆0後面的)
    %用size可以知道接下來要讀幾個bit
    % FindRun = run ; FindSize = size
    strBitsBuf=[];
    for i=1:FindSize
        strBitsBuf=[strBitsBuf inputNumSeq(inputIndexTemp)];
        inputIndexTemp=inputIndexTemp+1;
    end
    strBits='';
    for i=1:length(strBitsBuf)
        strBits=[strBits strBitsBuf(i)+48];
    end
    
    %要確認string的第一個char是不是1, 如果不是1那他就是負的
    %他就要1轉0, 0轉1
    isNegetive=0;
    if ~isempty(strBits)
    if strBits(1)=='0'
        isNegetive=1;
        for i=1:length(strBits)
            if strBits(i)=='0'
                strBits(i)='1';
            else
                strBits(i)='0';
            end
        end
    end
    end
    %再把string型態的bits轉成decimal
    %若之前確認其為負數, 就在轉為decimal時乘上負號
    tempSizeCodeWord=bin2dec(strBits);
    if isNegetive==1
        tempSizeCodeWord=tempSizeCodeWord*(-1);
    end
    %將解出來的一堆0與後面的數值放到One8x8
    %先放0, 再放非0數值
    for i=1:FindRun
        One8x8(One8x8Index)=0;
        One8x8Index=One8x8Index+1;
    end
    %處理size為0的情況, 並且要排除掉EOB的情況
    if ~(FindRun==0&FindSize==0)
    if ~isempty(tempSizeCodeWord)
        One8x8(One8x8Index)=tempSizeCodeWord;
        One8x8Index=One8x8Index+1;
    else
        One8x8(One8x8Index)=0;
        One8x8Index=One8x8Index+1;
    end
    end
    
    
    %讀到EOB了, 要把8x8寫入了
    %要把ACBeforeRunLenColumn加一, 如果Column等於64,
    %就把Row加一, Column變成一
    if FindRun==0 & FindSize==0
        
        %One8x8=transpose(One8x8);
        fprintf('Row: %i, Column: %i\n', ACBeforeRunLenRow, ACBeforeRunLenColumn);
        ACBeforeRunLen(ACBeforeRunLenRow, ACBeforeRunLenColumn, :)=One8x8;
        
        %測試用_用標準答案測試
        temptemp=reshape(ACBeforeRunLen(ACBeforeRunLenRow, ACBeforeRunLenColumn, :), [1 63]);
        temptemp002=reshape(zigzagScan(ACBeforeRunLenRow, ACBeforeRunLenColumn, :), [1 63]);
        isempty(find((temptemp==temptemp002)==0))
        %測試用END
        
        
        if ACBeforeRunLenColumn==64
            ACBeforeRunLenRow=ACBeforeRunLenRow+1;
            ACBeforeRunLenColumn=1;
        else
            ACBeforeRunLenColumn=ACBeforeRunLenColumn+1;
        end
        
        One8x8=zeros(1, 63);
        One8x8Index=1;
        ACBeforeHufNum=ACBeforeHufNum+1;
    end
    
end

output=ACBeforeRunLen;







