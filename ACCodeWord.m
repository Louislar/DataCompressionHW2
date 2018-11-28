%ACCodeWord function
%��AC�ȶi��, �Ƕi�Ӫ�DC�Ȭ��@��decimal
%�^�ǹ�����ACCodeword(AC�s�X)�ȬO�@��bit��array, �̭��u��0��1
%AC code word =Run/Size code word + AC coefficient code word
%�`�N: AC�O�@�ռƦr�Ƕi��, �e�����Ʀr���: ���X��0�b�e��
%�᭱���Ʀr���: �o��0�᭱���F���@�ӫD0����
%�o�̹w�]�ǤJ��input�O�@��1x2��array

function output=ACCodeWord(input)

%�����Ƕi�Ӫ�AC�Ȫ�category(SSSS)
category=0
category_codeword=0;

%�P�_category, AC�O�βĤG�ӼƦr�P�_category
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

%���۰�AC Huffman Table, �βĤ@�ӼƦr��@run, �ĤG�ӼƦr��@size
size=category;
run=input(1);
runsizeCodeWord=[];

%��huffman table��Xcode word
runsizeCodeWord=ACHuffmanTable([run size]);


