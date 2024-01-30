from sage.graphs.graph_plot import GraphPlot
from sage.numerical.mip import MixedIntegerLinearProgram
import itertools
from sage.graphs.graph import Graph

###################################################################################
#CLP, ki vrne normalno k-to dimenzijo
def CLP_k_dim(g, k_value):
    # Ustvarimo CLP
    p = MixedIntegerLinearProgram(maximization=False)
    # Nove spremenljivke
    x = p.new_variable(binary=True)
    # Ciljna funkcija
    p.set_objective(sum(x[v] for v in g))

    # Dodajanje p.p.
    for va in g:
        for vb in g:
            if va != vb:
                expr = sum(int(bool(g.distance(va, vi) - g.distance(vb, vi))) * x[vi] for vi in g)
                p.add_constraint(expr >= k_value)
            else:
                continue

    # Poskusimo rešiti ILP
    try:
        optimalna_resitev = p.solve()
        vrednosti_za_S = p.get_values(x)
        # Oblikovanje rešitve
        niz_z_rezultatom = f"{k_value} dimension: {optimalna_resitev}"
        # Print tega niza
        # print(niz_z_rezultatom)
        return optimalna_resitev#, vrednosti_za_S
    except:
        # If an error occurs (e.g., infeasible), return a special value to indicate infinite dimension
        return float('inf'), None
#########################################################
# CLP, ki vrne lokalno k-to dimenzijo grafa
def CLP_local_k_metric_dim(g, k_value):
    # Ustvari CLP
    p = MixedIntegerLinearProgram(maximization=False)

    # Spremenljivke x_i za vsako vozlišče v grafu
    x = p.new_variable(binary=True)

    # Pogoji za lokalno k-metrično dimenzijo
    for vi in g.vertices():
        neighbors = g.neighbors(vi)
        expr = sum(x[vi] + x[vj] for vj in neighbors) + x[vi]
        p.add_constraint(expr >= k_value)

    # Ciljna funkcija (minimizacija števila vozlišč v množici)
    p.set_objective(sum(x[vi] for vi in g))

    # Rešimo problem
    try:
        optimal_solution = p.solve()
        # Pridobimo vrednosti za spremenljivke
        values_for_x = p.get_values(x)
        # Vrnemo optimalno rešitev
        return optimal_solution
    except:
        # If an error occurs (e.g., infeasible), return a special value to indicate infinite dimension
        return float('inf'), None

# PRVI DEL NALOGE
#družine grafov:
#   poti = graphs.PathGraph(n)
#   cikli = graphs.CycleGraph(n)
#   polni grafi = graphs.CompleteGraph(n)
#   polni dvodelni grafi = graphs.CompleteBipartiteGraph(n,m)
#   hiperkocke = graphs.CubeConnectedCycle(n)

from sage.numerical.mip import MIPSolverException

# funkcija, ki izpiše ldim_k za grafe
# n = število vozlišč grafa
for n in range(2, 10):                       # spreminjamo glede na kako velike grafe gledamo 
    for k_value in range(1, 10):              # prilagajamo k
        G = graphs.PathGraph(n)              # spreminjamo družine grafov
        try:
            ldim_k = CLP_local_k_metric_dim(G, k_value)
            print(f"Lokalna {k_value}-metrična dimenzija s {n} vozlišči: {ldim_k}")
        except MIPSolverException as e:
            print(f"Error: {e}")



# za dvodelne grafe:

for n in range(2,5):
    for m in range(5, 12):
        for k_value in range(8, 9):
            C = graphs.CompleteBipartiteGraph(n,m)
            try:
                ldim_k = CLP_local_k_metric_dim(C, k_value)
                print(f"Lokalna {k_value}-metrična dimenzija s {n,m} vozlišči: {ldim_k}")
            except MIPSolverException as e:
                print(f"Error: {e}")

#DRUGI DEL NALOGE:

#funkcija, pri kateri za posamezno družino grafov preverimo ujemanja dimenzij


# Preveri za posamezno družino grafov če se dimenziji ujemata

for n in range(1, 25):
    for k_value in range(1, 10):
        # Ustvari ciklični graf
        G = graphs.CycleGraph(n)                      # lahko spreminjamo družine grafov
        
        # Izračunaj k-metrično dimenzijo
        dim_k = CLP_k_dim(G, k_value)
        
        # Izračunaj lokalno k-metrično dimenzijo
        ldim_k = CLP_local_k_metric_dim(G, k_value)
        
        # Preveri, ali se dimenziji ujemata in nista (inf, None)
        if dim_k == ldim_k and dim_k != (float('inf'), None):
            print(f"Ujemanje za graf s {n} vozlišči, k = {k_value}: k-dim = k-ldim = {ldim_k}")
   
            
            
    

