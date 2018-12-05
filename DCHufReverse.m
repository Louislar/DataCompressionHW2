% 將DC code轉回成, 被huffman table轉換之前的differential DC

function [inputIndex, output]=DCHufReverse(input)
%先找出category codeword是多少, 就可以知道後面的bit會有多長了

%現在檢查到第幾個input bit了
inputIndex=1;
%總共解出了幾個DC
DCNum=0;
%SSSS=1~11的codeWord
HuffmanCodeWords={[0 0] [0 1 0] [0 1 1] [1 0 0] [1 0 1] [1 1 0] [1 1 1 0] [1 1 1 1 0] [1 1 1 1 1 0] [1 1 1 1 1 1 0] [1 1 1 1 1 1 1 0] [1 1 1 1 1 1 1 1 0]};

%解碼出的所有DC值, 總共有64個
outputDCValue=[];

%一次讀進一個bit
%一直到可以解出64個DIFF DC為止
checkingBuf=[];
while DCNum<64
    %先解前面的category, 一次讀一個bit進來檢查
    %, 直到檢查到是哪個category為止
    
    % 目前檢查到的category號碼(SSSS)
    curCategory=-1;
    checkingBufCate=[];
    while true
        %多讀進來一個bit
        checkingBufCate=[checkingBufCate input(inputIndex)];
        inputIndex=inputIndex+1;
        %檢查是否符合任何一個Codeword
        isFindCategory=0;
        for i=1:length(HuffmanCodeWords)
            cell2mat(HuffmanCodeWords(i));
            %如果兩個array的length不同的話, 就一定不一樣
            if length(checkingBufCate)~=length(cell2mat(HuffmanCodeWords(i)))
                continue;
            end
            tempBoolArray=(checkingBufCate==cell2mat(HuffmanCodeWords(i)));
            %演查是否符合某一個Codeword, 完全符合的話
            %tempBoolArray會全部等於1, 所以find(==0)會是空字串
            %所以當find(==0)是空字串時, 代表Buf內的東西完全符合某個Codeword了
            if isempty(find(tempBoolArray==0))
                isFindCategory=1;
                curCategory=i;
                break;
            end
        end
        %找到Category了
        if isFindCategory==1
            a=1;
            break;
        end
    end
    
    %用category判斷接下來要讀幾個bit當作DIFF value code word
    
    %用來儲存讀到的bits
    DIFFBuf=[];
    %讀進Bits到Buffer裡面
    for i=1:(curCategory-1)
        DIFFBuf=[DIFFBuf input(inputIndex)];
        inputIndex=inputIndex+1;
    end
    %處理category有可能為0的情況
    if curCategory-1==0
        DIFFBuf=[0];
    end
    %將Buffer裡面的bits轉成實際的數字, 也就是做過differential後的DC值
    %用來儲存得到的bits, 是string 的型態
    strBits='';
    for i=1:length(DIFFBuf)
        if DIFFBuf(i)~=' '
            strBits=[strBits DIFFBuf(i)+48];
        end
    end
    %要確認string的第一個char是不是1, 如果不是1那他就是負的
    %他就要1轉0, 0轉1
    isNegetive=0;
    if strBits(1)==0
        isNegetive=1;
        for i=1:length(strBits)
            if strBits(i)==0
                strBits(i)=1;
            else
                strBits(i)=0;
            end
        end
    end
    %再把string型態的bits轉成decimal
    %若之前確認其為負數, 就在轉為decimal時乘上負號
    oneDIFF=bin2dec(strBits)
    if isNegetive==1
        oneDIFF=oneDIFF*(-1);
    end
    %最後把它加到output array裡面
    outputDCValue=[outputDCValue oneDIFF];
    
    curCategory=curCategory
    DCNum =DCNum+1;
end
output=outputDCValue;