
% matrix data normalizada local
normalizedDataAll = [nb1m, nb2m, nb11m, nb1r, nb2r, nb11r, nb1n, nb2n, nb11n];
figure;
mesh(normalizedDataAll(:,:));

% Es necesario formular unas preguntas de investogacioón
%en relación a laseleccion de datos sinteticos y sus grupos


figure;
waterfall(normalizedDataAll(:,:)');
% matrix data normalizada local
normalizedData = [nb1m, nb2m, nb11m];
figure;
waterfall(normalizedData(:,:)');
normalizedData = [nb1r, nb2r, nb11r];
figure;
waterfall(normalizedData(:,:)');
normalizedData = [nb1n, nb2n, nb11n];
figure;
waterfall(normalizedData(:,:)');

normalizedData = [nb1m, nb1r, nb1n];
figure;
waterfall(normalizedData(:,:)');

Datab1 = [b1m, b1r, b1n]; % mismo contexto?
figure;
waterfall(Datab1(:,:)');

Datab11 = [b11m, b11r, b11n]; % mismo contexto - mejor?
figure;
waterfall(Datab11(:,:)');

Datab2 = [b2m, b2r, b2n]; % mismo contexto - mejor?
figure;
waterfall(Datab2(:,:)');


X = normalizedData;
suma = sum(X)
X_tmp = [X;suma]

% Sort the matrix X by the values of a specific row, for example, the first row
rowToSortBy = N+1; % Specify the row number to sort by
[~, sortedIndices] = sort(X_tmp(rowToSortBy, :)); % Get sorted indices based on the specified row
X_sorted = X_tmp(:, sortedIndices); % Sort the entire matrix based on the sorted indices
X_sorted(rowToSortBy,:) = [];
figure;
waterfall(X_sorted(:,:)');




% normalizedData = [b11m, b11r, b11n]; % mismo contexto - mejor?
% figure;
% waterfall(normalizedData(:,:)');

% matrix data normalizada local
DataAll = [b1m, b2m, b11m, b1r, b2r, b11r, b1n, b2n, b11n];
figure;
mesh(DataAll(:,:));
figure;
waterfall(DataAll(:,:)');



% Plot normalized data for each set
% figure;
% plot(nb1m, 'DisplayName', 'Normalized B1m'); hold on;
% plot(nb2m, 'DisplayName', 'Normalized B2m');
% plot(nb11m, 'DisplayName', 'Normalized B11m');
% legend show;
% xlabel('Sample Index');
% ylabel('Normalized Value');
% title('Normalized Curves');
% figure
% plot(b1m)
% hold on
% plot(b2m)
% plot(b11m)
% 
% figure
% plot(nb1m)
% hold on
% plot(nb2m)
% plot(nb11m)



