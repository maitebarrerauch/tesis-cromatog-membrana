%original_vector = [1, 2, 3, 4, 5]; % Original vector
original_vector = load('datos/curva_sintetica_31_b2.txt');
%i=find(original_vector(:,2)==max(original_vector(:,2)));


shift_amount = 100; % Number of positions to shift
x=original_vector(:,2)';
% Shift the vector to the right
shifted_vector = circshift(x, shift_amount);
mx=movmean(shifted_vector,50);
al_value1 = trapz(x);
al_value2= trapz(mx);
e=abs(al_value1-al_value2)/al_value1

figure;
plot(mx);
%plot(x);
