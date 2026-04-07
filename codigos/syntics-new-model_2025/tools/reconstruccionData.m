function x = reconstruccionData(input,pos,xSize,opcion)
x = [input(1:xSize,pos),input(xSize+1:end,pos)];
    if opcion==1
    plot(x);
    end
    if opcion==0
    plot(log(x));
    end
end