%DCCodeWord function
%��DC�ȶi��, �Ƕi�Ӫ�DC�Ȭ��@��decimal
%�^�ǹ�����DC�ȬO�@��bit��array, �̭��u��0��1
%DC code word = category code word + DIFF value code word
%�ثegray-level�O��Luminance��table�Ӱ�(�����D�藍��)

function output=DCCodeWord(input)

%�����Ƕi�Ӫ�DC�Ȫ�category(SSSS)
category=0
category_codeword=0;

%�P�_category
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

%���ۺ�diffential value code word
%category��0�N���|��codeword, �]��codeword length==0
DIFFValueCodeWord=[0];
if (category==0)
end
if (category>0)
    DIFFValueCodeWord=dec2bin(abs(input))-'0';
    DIFFValueCodeWordSize=size(DIFFValueCodeWord);
    %�p�Ginput value(diff value)�O�t��, �N�n0��1, 1��0
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
