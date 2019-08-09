
n = importfile("E:\matlab\tsp\tsp22\ulysses22.tsp", [8, 29]);
d = squareform(pdist(n));
[tour_climb,eva_climb]=hill_climb(n);
[tour_stochastic_climb,eva_stochastic_climb]=stochastic_hill_climb(n);
[tour_ox,eva_ox]=evolution_path_ox(n);
[tour_annealing,eva_annealing]=stimulated_annealing(n);
[tour_tabu,eva_tabu]=tabu_search(n);

