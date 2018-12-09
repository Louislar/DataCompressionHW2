%壓縮RGB用
%RGB每個都要1個byte, 所以一列變成512*3個bytes
file_path_home='E:\作業吧\資料壓縮\HW2\TestImage\ColorImage\LenaRGB.raw';

rowRGB=512*3;
colRGB=512;

%img = (512*3, 512), 因為matlab是一行一行填入矩陣的, 所以其實要把矩陣transpose才對
fid=fopen(file_path_home, 'r');
img=fread(fid, [rowRGB, colRGB], 'uint8');

%每個pixel 3個bytes
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

%換成 Y Cb Cr
%轉換公式還要問一下助教
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

%做subsampling

