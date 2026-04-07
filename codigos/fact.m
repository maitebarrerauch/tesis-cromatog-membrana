function f=fact(n)
%i=find(n~=0);
%f=ones(size(n));
if n>0
    f=n*fact(n-1);
else
    f=1;
end