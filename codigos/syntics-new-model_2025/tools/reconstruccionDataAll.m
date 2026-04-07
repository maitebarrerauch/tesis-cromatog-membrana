function x = reconstruccionDataAll(input,xSize)
n = size(input,2)
for i=1:n
x = [input(1:xSize,i),input(xSize+1:end,i)];
hold on;
plot(x); 
end
end