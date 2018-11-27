%DCCodeWord function
%傳DC值進來, 傳進來的DC值為一個decimal
%回傳對應的DC值是一個bit的array, 裡面只有0跟1
%DC code word = category code word + DIFF value code word
%目前gray-level是用Luminance的table來做(不知道對不對)

function output=DCCodeWord(input)

%紀錄傳進來的DC值的category(SSSS)
category=0
category_codeword=0;

%判斷category
if input==0
    category=0;
    category_codeword=[0 0];
end
if input==-1 | input==1
    category=1;
    category_codeword=[0 1 0];
end
if (input>=-3 & input<=-2) | (input>=2 & input<=3)
    category=2;
    category_codeword=[0 1 1];
end
if (input>=-7 & input<=-4) | (input>=4 & input<=7)
    category=3;
    category_codeword=[1 0 0];
end
if (input>=-15 & input<=-8) | (input>=8 & input<=15)
    category=4;
    category_codeword=[1 0 1];
end
if (input>=-31 & input<=-16) | (input>=16 & input<=31)
    category=5;
    category_codeword=[1 1 0];
end
if (input>=-63 & input<=-32) | (input>=32 & input<=63)
    category=6;
    category_codeword=[1 1 1 0];
end
if (input>=-127 & input<=-64) | (input>=64 & input<=127)
    category=7;
    category_codeword=[1 1 1 1 0];
end
if (input>=-255 & input<=-128) | (input>=128& input<=255)
    category=8;
    category_codeword=[1 1 1 1 1 0];
end
if (input>=-511 & input<=-256) | (input>=256 & input<=511)
    category=9;
    category_codeword=[1 1 1 1 1 1 0];
end
if (input>=-1023 & input<=-512) | (input>=512 & input<=1023)
    category=10;
    category_codeword=[1 1 1 1 1 1 1 0];
end
if (input>=-2047 & input<=-1024) | (input>=1024 & input<=2047)
    category=11;
    category_codeword=[1 1 1 1 1 1 1 1 0];
end

%接著算diffential value code word
%category為0就不會有codeword, 因為codeword length==0
DIFFValueCodeWord=[0];
if (category==0)
end
if (category>0)
    DIFFValueCodeWord=dec2bin(abs(input))-'0';
    DIFFValueCodeWordSize=size(DIFFValueCodeWord);
    %如果input value(diff value)是負的, 就要0轉1, 1轉0
    if (input<0)
        for i=1:DIFFValueCodeWordSize
            if DIFFValueCodeWord(1, i)==1
                DIFFValueCodeWord(1, i)=0;
            end
            if DIFFValueCodeWord(1, i)==0
                DIFFValueCodeWord(1, i)=1;
            end
        end
    end
end

output=[category_codeword DIFFValueCodeWord];
