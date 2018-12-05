% �NDC code��^��, �Qhuffman table�ഫ���e��differential DC

function [inputIndex, output]=DCHufReverse(input)
%����Xcategory codeword�O�h��, �N�i�H���D�᭱��bit�|���h���F

%�{�b�ˬd��ĴX��input bit�F
inputIndex=1;
%�`�@�ѥX�F�X��DC
DCNum=0;
%SSSS=1~11��codeWord
HuffmanCodeWords={[0 0] [0 1 0] [0 1 1] [1 0 0] [1 0 1] [1 1 0] [1 1 1 0] [1 1 1 1 0] [1 1 1 1 1 0] [1 1 1 1 1 1 0] [1 1 1 1 1 1 1 0] [1 1 1 1 1 1 1 1 0]};

%�ѽX�X���Ҧ�DC��, �`�@��64��
outputDCValue=[];

%�@��Ū�i�@��bit
%�@����i�H�ѥX64��DIFF DC����
checkingBuf=[];
while DCNum<64
    %���ѫe����category, �@��Ū�@��bit�i���ˬd
    %, �����ˬd��O����category����
    
    % �ثe�ˬd�쪺category���X(SSSS)
    curCategory=-1;
    checkingBufCate=[];
    while true
        %�hŪ�i�Ӥ@��bit
        checkingBufCate=[checkingBufCate input(inputIndex)];
        inputIndex=inputIndex+1;
        %�ˬd�O�_�ŦX����@��Codeword
        isFindCategory=0;
        for i=1:length(HuffmanCodeWords)
            cell2mat(HuffmanCodeWords(i));
            %�p�G���array��length���P����, �N�@�w���@��
            if length(checkingBufCate)~=length(cell2mat(HuffmanCodeWords(i)))
                continue;
            end
            tempBoolArray=(checkingBufCate==cell2mat(HuffmanCodeWords(i)));
            %�t�d�O�_�ŦX�Y�@��Codeword, �����ŦX����
            %tempBoolArray�|��������1, �ҥHfind(==0)�|�O�Ŧr��
            %�ҥH��find(==0)�O�Ŧr���, �N��Buf�����F�觹���ŦX�Y��Codeword�F
            if isempty(find(tempBoolArray==0))
                isFindCategory=1;
                curCategory=i;
                break;
            end
        end
        %���Category�F
        if isFindCategory==1
            a=1;
            break;
        end
    end
    
    %��category�P�_���U�ӭnŪ�X��bit��@DIFF value code word
    
    %�Ψ��x�sŪ�쪺bits
    DIFFBuf=[];
    %Ū�iBits��Buffer�̭�
    for i=1:(curCategory-1)
        DIFFBuf=[DIFFBuf input(inputIndex)];
        inputIndex=inputIndex+1;
    end
    %�B�zcategory���i�ର0�����p
    if curCategory-1==0
        DIFFBuf=[0];
    end
    %�NBuffer�̭���bits�ন��ڪ��Ʀr, �]�N�O���Ldifferential�᪺DC��
    %�Ψ��x�s�o�쪺bits, �Ostring �����A
    strBits='';
    for i=1:length(DIFFBuf)
        if DIFFBuf(i)~=' '
            strBits=[strBits DIFFBuf(i)+48];
        end
    end
    %�n�T�{string���Ĥ@��char�O���O1, �p�G���O1���L�N�O�t��
    %�L�N�n1��0, 0��1
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
    %�A��string���A��bits�নdecimal
    %�Y���e�T�{�䬰�t��, �N�b�ରdecimal�ɭ��W�t��
    oneDIFF=bin2dec(strBits)
    if isNegetive==1
        oneDIFF=oneDIFF*(-1);
    end
    %�̫�⥦�[��output array�̭�
    outputDCValue=[outputDCValue oneDIFF];
    
    curCategory=curCategory
    DCNum =DCNum+1;
end
output=outputDCValue;