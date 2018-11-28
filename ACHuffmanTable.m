%��run��size, output AC coefficient code word
%�w�]��J�O1x2��array => [Run, Size]
%��X�O1xn��array

function output=ACHuffmanTable(input)
run=input(1);
size=input(2);
runsizeCodeWord=[];

if (run==0)
    if (size==0)    %EOB end of block
        runsizeCodeWord=[1 0 1 0];
    end
    if (size==1)  
        runsizeCodeWord=[0 0];
    end
    if (size==2)
        runsizeCodeWord=[0 1];
    end
    if (size==3)  
        runsizeCodeWord=[1 0 0];
    end
    if (size==4)  
        runsizeCodeWord=[1 0 1 1];
    end
    if (size==5)
        runsizeCodeWord=[1 1 0 1 0];
    end
    if (size==6)
        runsizeCodeWord=[1 1 1 1 0 0 0];
    end
    if (size==7)
        runsizeCodeWord=[1 1 1 1 1 0 0 0];
    end
    if (size==8)
        runsizeCodeWord=[1 1 1 1 1 1 0 1 1 0];
    end
    if (size==9)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 0 0 1 0];
    end
    if (size==10)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 0 0 1 1];
    end
end

if (run==1)
    if (size==1)    %EOB end of block
        runsizeCodeWord=[1 1 0 0];
    end
    if (size==2)
        runsizeCodeWord=[1 1 0 1 1];
    end
    if (size==3)  
        runsizeCodeWord=[1 1 1 1 0 0 1];
    end
    if (size==4)  
        runsizeCodeWord=[1 1 1 1 1 0 1 1 0];
    end
    if (size==5)
        runsizeCodeWord=[1 1 1 1 1 1 1 0 1 1 0];
    end
    if (size==6)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 0 1 0 0];
    end
    if (size==7)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 0 1 0 1];
    end
    if (size==8)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 0];
    end
    if (size==9)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 1];
    end
    if (size==10)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 1 0 0 0];
    end
end

if (run==2)
    if (size==1)    %EOB end of block
        runsizeCodeWord=[1 1 1 0 0];
    end
    if (size==2)
        runsizeCodeWord=[1 1 1 1 1 0 0 1];
    end
    if (size==3)  
        runsizeCodeWord=[1 1 1 1 1 1 0 1 1 1];
    end
    if (size==4)  
        runsizeCodeWord=[1 1 1 1 1 1 1 1 0 1 0 0];
    end
    if (size==5)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 1 0 0 1];
    end
    if (size==6)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 1 0 1 0];
    end
    if (size==7)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 1 0 1 1];
    end
    if (size==8)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 1 1 0 0];
    end
    if (size==9)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 1 1 0 1];
    end
    if (size==10)
        runsizeCodeWord=[1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 0];
    end
end

if (run==3)
    if (size==1)    %EOB end of block
        runsizeCodeWord=[1 1 1 0 1 0];
    end
    if (size==2)
        runsizeCodeWord=[1 1 1 1  1 0 1 1  1];
    end
    if (size==3)  
        runsizeCodeWord=[1 1 1 1  1 1 1 1  0 1 0 1];
    end
    if (size==4)  
        runsizeCodeWord=[1 1 1 1  1 1 1 1  1 0 0 0  1 1 1 1];
    end
    if (size==5)
        runsizeCodeWord=[1 1 1 1  1 1 1 1  1 0 0 1  0 0 0 0];
    end
    if (size==6)
        runsizeCodeWord=[1 1 1 1  1 1 1 1  1 0 0 1  0 0 0 1];
    end
    if (size==7)
        runsizeCodeWord=[1 1 1 1  1 1 1 1  1 0 0 1  0 0 1 0];
    end
    if (size==8)
        runsizeCodeWord=[1 1 1 1  1 1 1 1  1 0 0 1  0 0 1 1];
    end
    if (size==9)
        runsizeCodeWord=[1 1 1 1  1 1 1 1  1 0 0 1  0 1 0 0];
    end
    if (size==10)
        runsizeCodeWord=[1 1 1 1  1 1 1 1  1 0 0 1  0 1 0 1];
    end
end


output=runsizeCodeWord;