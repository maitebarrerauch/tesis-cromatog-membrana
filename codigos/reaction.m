function R = reaction(x,c,cs, flag)
%% Términos de reacción para la ec. de c (flag=0), y de cs (flag=1)
m=x(1);
n=x(2);
r=x(3);
if flag==0
    R=n*cs.*( 1/(r-1) + c );
else
    R=(n/m)*c.*(1-cs);
end