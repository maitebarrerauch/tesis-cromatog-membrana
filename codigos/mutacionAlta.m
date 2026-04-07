function mutatedChildren = mutacionAlta(parents, options, nvars, ~, ~, ~, thisPopulation)
    mutationRate = 1.0;  % 100% de las variables se mutan
    mutationScale = 20.0; % Cambios grandes

    mutatedChildren = thisPopulation(parents,:);
    for i = 1:size(mutatedChildren, 1)
        for j = 1:nvars
            if rand < mutationRate
                mutatedChildren(i,j) = mutatedChildren(i,j) + mutationScale *randn();
            end
        end
    end

    % Restringe a los rangos definidos (opcional pero recomendado)
    lb = options.PopInitRange(1,:);
    ub = options.PopInitRange(2,:);
    mutatedChildren = max(min(mutatedChildren, ub), lb);
end