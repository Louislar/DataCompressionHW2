%zig-zag function
%傳一個8X8的矩陣進來
%回傳一長條的數字是以zig-zag order排列
function output=zig_zag(input)

output=zeros(1, 63);
outputJindex=1;

%第一格AC_01
output(1, outputJindex)=input(1, 2);
outputJindex=outputJindex+1;
%第二格AC_02
output(1, outputJindex)=input(2, 1);
outputJindex=outputJindex+1;
%第三格AC_03
output(1, outputJindex)=input(3, 1);
outputJindex=outputJindex+1;
%第四/五格AC_04 AC_05
for i=1:2
    output(1, outputJindex)=input(3-i, 1+i);
    outputJindex=outputJindex+1;
end
%第六格AC_06
output(1, outputJindex)=input(1, 4);
outputJindex=outputJindex+1;
%第七八九格AC_07 AC_08 AC_09
for i=1:3
    output(1, outputJindex)=input(1+i, 4-i);
    outputJindex=outputJindex+1;
end
%第十格AC_10
output(1, outputJindex)=input(5, 1);
outputJindex=outputJindex+1;
%第11 12 13 14格AC_11 AC_12  AC_14
for i=1:4
    output(1, outputJindex)=input(5-i, 1+i);
    outputJindex=outputJindex+1;
end
%第15格AC_15
output(1, outputJindex)=input(1, 6);
outputJindex=outputJindex+1;
%第16 17 18 19 20格
for i=1:5
    output(1, outputJindex)=input(1+i, 6-i);
    outputJindex=outputJindex+1;
end
%第21格
output(1, outputJindex)=input(7, 1);
outputJindex=outputJindex+1;
%第22 23 24 25 26 27格
for i=1:6
    output(1, outputJindex)=input(7-i, 1+i);
    outputJindex=outputJindex+1;
end
%第28格
output(1, outputJindex)=input(1, 8);
outputJindex=outputJindex+1;
%第29 30 31 32 33 34 35格
for i=1:7
    output(1, outputJindex)=input(1+i, 8-i);
    outputJindex=outputJindex+1;
end
%第36格
output(1, outputJindex)=input(8, 2);
outputJindex=outputJindex+1;
%第37 38 39 40 41 42格
for i=1:6
    output(1, outputJindex)=input(8-i, 2+i);
    outputJindex=outputJindex+1;
end
%第43格
output(1, outputJindex)=input(3, 8);
outputJindex=outputJindex+1;
%第44 45 46 47 48格
for i=1:5
    output(1, outputJindex)=input(3+i, 8-i);
    outputJindex=outputJindex+1;
end
%第49格
output(1, outputJindex)=input(8, 4);
outputJindex=outputJindex+1;
%第50 51 52 53格
for i=1:4
    output(1, outputJindex)=input(8-i, 4+i);
    outputJindex=outputJindex+1;
end
%第54格
output(1, outputJindex)=input(5, 8);
outputJindex=outputJindex+1;
%第55 56 57格
for i=1:3
    output(1, outputJindex)=input(5+i, 8-i);
    outputJindex=outputJindex+1;
end
%第58格
output(1, outputJindex)=input(8, 6);
outputJindex=outputJindex+1;
%第59 60格
for i=1:2
    output(1, outputJindex)=input(8-i, 6+i);
    outputJindex=outputJindex+1;
end
%第61格
output(1, outputJindex)=input(7, 8);
outputJindex=outputJindex+1;
%第62格
output(1, outputJindex)=input(8, 7);
outputJindex=outputJindex+1;
%第63格
output(1, outputJindex)=input(8, 8);
outputJindex=outputJindex+1;
