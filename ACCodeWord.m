%ACCodeWord function
%傳AC值進來, 傳進來的AC值為一個decimal
%回傳對應的ACCodeword(AC編碼)值是一個bit的array, 裡面只有0跟1
%AC code word =Run/Size code word + AC coefficient code word
%注意: AC是一組數字傳進來, 前面的數字表示: 有幾個0在前面
%後面的數字表示: 這些0後面接了哪一個非0的數
%這裡預設傳入的input是一個1x63的array

function output=ACCodeWord(input)

%處理AC zigzag完的63個數字組成的數列
%需要把他們整理成兩個數一組的形式: <run, size>
%1. 尋找最後一個非零值
k=find(input, 1, 'last');
if (isempty(k))
    Run_lengthCoding=[1 0 1 0];
    output=Run_lengthCoding;
    return;
end
%若k不為0, 就開始按照順序走訪63個數字
ZeroNum=0;
outcode=[];
for i=1:k
    if input(i)~=0
        outcode=[outcode ACRunSizeFunc([ZeroNum input(i)])];
        ZeroNum=0;
    elseif input(i)==0
        if ZeroNum==15
            outcode=[outcode ACRunSizeFunc([15 0])];
            ZeroNum=0;
        else
            ZeroNum=ZeroNum+1;
        end
    end
end
%加上EOB
outcode=[outcode [1 0 1 0]];
output=outcode;




function output=ACRunSizeFunc(input)


%紀錄傳進來的AC值的category(SSSS)
category=0;
category_codeword=0;

%判斷category, AC是用第二個數字判斷category
if input(2)==0
    category=0;
    category_codeword=[0 0];
end
if input(2)==-1 | input(2)==1
    category=1;
    category_codeword=[0 1 0];
end
if (input(2)>=-3 & input(2)<=-2) | (input(2)>=2 & input(2)<=3)
    category=2;
    category_codeword=[0 1 1];
end
if (input(2)>=-7 & input(2)<=-4) | (input(2)>=4 & input(2)<=7)
    category=3;
    category_codeword=[1 0 0];
end
if (input(2)>=-15 & input(2)<=-8) | (input(2)>=8 & input(2)<=15)
    category=4;
    category_codeword=[1 0 1];
end
if (input(2)>=-31 & input(2)<=-16) | (input(2)>=16 & input(2)<=31)
    category=5;
    category_codeword=[1 1 0];
end
if (input(2)>=-63 & input(2)<=-32) | (input(2)>=32 & input(2)<=63)
    category=6;
    category_codeword=[1 1 1 0];
end
if (input(2)>=-127 & input(2)<=-64) | (input(2)>=64 & input(2)<=127)
    category=7;
    category_codeword=[1 1 1 1 0];
end
if (input(2)>=-255 & input(2)<=-128) | (input(2)>=128& input(2)<=255)
    category=8;
    category_codeword=[1 1 1 1 1 0];
end
if (input(2)>=-511 & input(2)<=-256) | (input(2)>=256 & input(2)<=511)
    category=9;
    category_codeword=[1 1 1 1 1 1 0];
end
if (input(2)>=-1023 & input(2)<=-512) | (input(2)>=512 & input(2)<=1023)
    category=10;
    category_codeword=[1 1 1 1 1 1 1 0];
end

%接著做AC Huffman Table, 用第一個數字當作run, 第二個數字當作size
size=category;
run=input(1);
runsizeCodeWord=[];

%用huffman table找出code word
runsizeCodeWord=ACHuffmanTable([run size]);

%前面是Run/Size code word, 後面是AC coefficient code word
%Run/Size code word可由上一個式子藉由huffman table得到
%AC coefficient code word則需要透過把非0的那個數換算成二進位得出
%所以現在要計算AC coefficient code word
%先轉成binary(取絕對值)的array
ACCoefCodeWord=dec2bin(abs(input(2)))-'0';
%依據正負決定要不要0轉1, 1轉0
if input(2)<0
    for i=1:length(ACCoefCodeWord)
        if ACCoefCodeWord(i)==1
            ACCoefCodeWord(i)=0;
        else
            ACCoefCodeWord(i)=1;
        end
    end
end


output=[runsizeCodeWord ACCoefCodeWord];

