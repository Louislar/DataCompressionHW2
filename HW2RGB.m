%���YRGB��
%RGB�C�ӳ��n1��byte, �ҥH�@�C�ܦ�512*3��bytes
file_path_home='E:\�@�~�a\������Y\HW2\TestImage\ColorImage\LenaRGB.raw';

rowRGB=512*3;
colRGB=512;

%img = (512*3, 512), �]��matlab�O�@��@���J�x�}��, �ҥH���n��x�}transpose�~��
fid=fopen(file_path_home, 'r');
img=fread(fid, [rowRGB, colRGB], 'uint8');

%�C��pixel 3��bytes
imgRGB=zeros(512, 512, 3);

for i=1:512
    for j=1:3:1536
        for k=1:3
            imgRGB(i, fix(j/3)+1, k)=img(j+k-1, i);
        end
    end
end

imgR=imgRGB(:, :, 1);
imgG=imgRGB(:, :, 2);
imgB=imgRGB(:, :, 3);

%���� Y Cb Cr
%�ഫ�����٭n�ݤ@�U�U��
imgY=zeros(512, 512);
imgCb=zeros(512, 512);
imgCr=zeros(512, 512);
for i=1:512
    for j=1:512
        imgY(i, j)=imgR(i, j)*0.299 + 0.587*imgG(i, j) + 0.114*imgB(i, j);
        imgCb(i, j)=0.564*(imgB(i, j)-imgY(i, j));
        imgCr(i, j)=0.713*(imgR(i, j)-imgY(i, j));
    end
end

%��subsampling

