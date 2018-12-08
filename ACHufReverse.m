%input0: �ǤJinput�ƦC, �������O0101�����Y����
%input1: �ǤJinput�ƦC�{�b�w�g�Q�Ѷ}��Index��

function [output, inputIndexTemp]=ACHufReverse(input0, input1)
%���ե�_�������Y�ɪ����G_�]�N�O���T����
load('tempZigzag.mat');
%���ե�END
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


%�`�@�ݭnŪ�J64x64��block, �@��block�O8x8
%ACBeforeHufNum �|�����ѽX�X�F�X��AC code, ���@�U�|��EOB�P�_�ѥX�X��block�F
ACBeforeHufNum=0;

%������X��ACcode, �|�O���������b�쥻1x63�x�}����
ACBeforeRunLen=zeros(64, 64, 63);
ACBeforeRunLenRow=1;
ACBeforeRunLenColumn=1;

%�o��buffer�|�Ω�����C���ѥX<run, size>��o�쪺��
%����Ū��EOB�~�|�N���g�JACBeforeRunLen, �åB��ۤv�M��
%�������㪺�@��block��code
One8x8=zeros(1, 63);
One8x8Index=1;


%���|Ū��AC Huffman table��encode�ѥX<run, size>
%�����ǥ�run�o��category, �N�i�H���D���U�ӭnŪ�X��bit
%�o��@��0�᭱���۪��Ʀr�F, �Ӥ��e�D��run�N��e�����X��0
while ACBeforeHufNum<64*64
    %�CŪ�@��bit�N���ˤ@�����S������hufman table�̭�����@��entry
    inputBuf=[];
    FindRun=0;
    FindSize=0;
    %Ū�@��bit, ������<run, size>����
    while 1==1
        %Ū�i�@��bit
        inputBuf=[inputBuf inputNumSeq(inputIndexTemp)];
        inputIndexTemp=inputIndexTemp+1;
        isFinded=0;
        
        
        %��بҥ~�n�S�O�B�z, EOB, 16��0
        if length(inputBuf)==length([1 0 1 0])
            isEOB= inputBuf==[1 0 1 0];
            if isempty(find(isEOB==0))
            FindRun=0;
            FindSize=0;
            isFinded=1;
            end
        end
        %���b���Y���ɭԹJ��16��0, �|��runsizeCodeWord�b�[�W�@��0
        if length(inputBuf)==length([1 1 1 1  1 1 1 1  0 0 1 0])
            is16Zero= inputBuf==[1 1 1 1  1 1 1 1  0 0 1 0];
            if isempty(find(is16Zero==0))
                FindRun=15;
                FindSize=0;
                isFinded=1;
            end
        end
        
        
        %�p�G�OEOB�άO16��0�N���ΦA��F
        if isFinded==0
        %�ˬd��einput buffer���L�������hufman table�̭�����@��entry
        for i=1:16
            for j=1:10
                tempCheckingArray=cell2mat(codewordTable(i, j));
                if length(inputBuf)~=length(tempCheckingArray)
                    continue;
                end
                tempBoolArray=  inputBuf==tempCheckingArray;
                %�������۵���entry�N��tempBoolArray����1
                %�Y�O�ڧ�0, �N�|�^�Ǥ@��empty��array
                tempFindArray=find(tempBoolArray==0);
                %�Oempty�N����<run, size>�F
                %�åB���hfor�j��break
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
    
    %���<run, size>��Q��size�D�᭱�����Ӽ�(�@��0�᭱��)
    %��size�i�H���D���U�ӭnŪ�X��bit
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
    
    %�n�T�{string���Ĥ@��char�O���O1, �p�G���O1���L�N�O�t��
    %�L�N�n1��0, 0��1
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
    %�A��string���A��bits�নdecimal
    %�Y���e�T�{�䬰�t��, �N�b�ରdecimal�ɭ��W�t��
    tempSizeCodeWord=bin2dec(strBits);
    if isNegetive==1
        tempSizeCodeWord=tempSizeCodeWord*(-1);
    end
    %�N�ѥX�Ӫ��@��0�P�᭱���ƭȩ��One8x8
    %����0, �A��D0�ƭ�
    for i=1:FindRun
        One8x8(One8x8Index)=0;
        One8x8Index=One8x8Index+1;
    end
    %�B�zsize��0�����p, �åB�n�ư���EOB�����p
    if ~(FindRun==0&FindSize==0)
    if ~isempty(tempSizeCodeWord)
        One8x8(One8x8Index)=tempSizeCodeWord;
        One8x8Index=One8x8Index+1;
    else
        One8x8(One8x8Index)=0;
        One8x8Index=One8x8Index+1;
    end
    end
    
    
    %Ū��EOB�F, �n��8x8�g�J�F
    %�n��ACBeforeRunLenColumn�[�@, �p�GColumn����64,
    %�N��Row�[�@, Column�ܦ��@
    if FindRun==0 & FindSize==0
        
        %One8x8=transpose(One8x8);
        fprintf('Row: %i, Column: %i\n', ACBeforeRunLenRow, ACBeforeRunLenColumn);
        ACBeforeRunLen(ACBeforeRunLenRow, ACBeforeRunLenColumn, :)=One8x8;
        
        %���ե�_�μзǵ��״���
        temptemp=reshape(ACBeforeRunLen(ACBeforeRunLenRow, ACBeforeRunLenColumn, :), [1 63]);
        temptemp002=reshape(zigzagScan(ACBeforeRunLenRow, ACBeforeRunLenColumn, :), [1 63]);
        isempty(find((temptemp==temptemp002)==0))
        %���ե�END
        
        
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







