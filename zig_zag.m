%zig-zag function
%�Ǥ@��8X8���x�}�i��
%�^�Ǥ@�������Ʀr�O�Hzig-zag order�ƦC
function output=zig_zag(input)

output=zeros(1, 63);
outputJindex=1;

%�Ĥ@��AC_01
output(1, outputJindex)=input(1, 2);
outputJindex=outputJindex+1;
%�ĤG��AC_02
output(1, outputJindex)=input(2, 1);
outputJindex=outputJindex+1;
%�ĤT��AC_03
output(1, outputJindex)=input(3, 1);
outputJindex=outputJindex+1;
%�ĥ|/����AC_04 AC_05
for i=1:2
    output(1, outputJindex)=input(3-i, 1+i);
    outputJindex=outputJindex+1;
end
%�Ĥ���AC_06
output(1, outputJindex)=input(1, 4);
outputJindex=outputJindex+1;
%�ĤC�K�E��AC_07 AC_08 AC_09
for i=1:3
    output(1, outputJindex)=input(1+i, 4-i);
    outputJindex=outputJindex+1;
end
%�ĤQ��AC_10
output(1, outputJindex)=input(5, 1);
outputJindex=outputJindex+1;
%��11 12 13 14��AC_11 AC_12  AC_14
for i=1:4
    output(1, outputJindex)=input(5-i, 1+i);
    outputJindex=outputJindex+1;
end
%��15��AC_15
output(1, outputJindex)=input(1, 6);
outputJindex=outputJindex+1;
%��16 17 18 19 20��
for i=1:5
    output(1, outputJindex)=input(1+i, 6-i);
    outputJindex=outputJindex+1;
end
%��21��
output(1, outputJindex)=input(7, 1);
outputJindex=outputJindex+1;
%��22 23 24 25 26 27��
for i=1:6
    output(1, outputJindex)=input(7-i, 1+i);
    outputJindex=outputJindex+1;
end
%��28��
output(1, outputJindex)=input(1, 8);
outputJindex=outputJindex+1;
%��29 30 31 32 33 34 35��
for i=1:7
    output(1, outputJindex)=input(1+i, 8-i);
    outputJindex=outputJindex+1;
end
%��36��
output(1, outputJindex)=input(8, 2);
outputJindex=outputJindex+1;
%��37 38 39 40 41 42��
for i=1:6
    output(1, outputJindex)=input(8-i, 2+i);
    outputJindex=outputJindex+1;
end
%��43��
output(1, outputJindex)=input(3, 8);
outputJindex=outputJindex+1;
%��44 45 46 47 48��
for i=1:5
    output(1, outputJindex)=input(3+i, 8-i);
    outputJindex=outputJindex+1;
end
%��49��
output(1, outputJindex)=input(8, 4);
outputJindex=outputJindex+1;
%��50 51 52 53��
for i=1:4
    output(1, outputJindex)=input(8-i, 4+i);
    outputJindex=outputJindex+1;
end
%��54��
output(1, outputJindex)=input(5, 8);
outputJindex=outputJindex+1;
%��55 56 57��
for i=1:3
    output(1, outputJindex)=input(5+i, 8-i);
    outputJindex=outputJindex+1;
end
%��58��
output(1, outputJindex)=input(8, 6);
outputJindex=outputJindex+1;
%��59 60��
for i=1:2
    output(1, outputJindex)=input(8-i, 6+i);
    outputJindex=outputJindex+1;
end
%��61��
output(1, outputJindex)=input(7, 8);
outputJindex=outputJindex+1;
%��62��
output(1, outputJindex)=input(8, 7);
outputJindex=outputJindex+1;
%��63��
output(1, outputJindex)=input(8, 8);
outputJindex=outputJindex+1;
