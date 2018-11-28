%ACCodeWord function
%傳AC值進來, 傳進來的DC值為一個decimal
%回傳對應的ACCodeword(AC編碼)值是一個bit的array, 裡面只有0跟1
%AC code word =Run/Size code word + AC coefficient code word
%注意: AC是一組數字傳進來, 前面的數字表示: 有幾個0在前面
%後面的數字表示: 這些0後面接了哪一個非0的數
%這裡預設傳入的input是一個1x2的array

function output=ACCodeWord(input)

%紀錄傳進來的AC值的category(SSSS)
category=0
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


