%Ū�Jencode���ɮ�
fileID=fopen('jpegEncode.txt');
readIN=fread(fileID);
inStream=transpose(readIN);

%��Ū�J���ɮ��নbinary��array
bitStream=[];
for i=1:length(inStream)
    temp=dec2bin(inStream(i));  %inStream='1010'
    %����8��bit�n�b�e����0
    if length(temp)<8
        for j=1:8-length(temp)
            temp=['0' temp];
        end
    end
    %�C�@�ӼƦr�᭱���n�[�W�Ů�, �o�ˤ~��bcall str2num��, �����}��
    temp_blank='';
    for j=1:length(temp)
        temp_blank=[temp_blank temp(j) ' '];
    end
    temp_blank=str2num(temp_blank);
    bitStream=[bitStream temp_blank];
end

% AC�n���huffman table�ন<run, size>
% DC�n���huffman table�ন����differential�᪺�ˤl
% Encode���ɭԬODC(1, 1)~DC(64, 64)���ۤ~�OAC(1, 1)~AC(64, 64)





