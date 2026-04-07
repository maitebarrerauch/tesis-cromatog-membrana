function [state,options,changed] = savePopulation(options,state,flag)
    if strcmp(flag,'iter')
        % Save the population data
        population = state.Population;
        save('population_data.mat', 'population', '-append');

        % Or save the best individual
        ibest = state.Best(end);
        ibest = find(state.Score == ibest, 1, 'last');
        best_individual = state.Population(ibest, :);
        save('best_individuals.mat', 'best_individual', '-append');

        changed = true; % Required to indicate changes
    end
end