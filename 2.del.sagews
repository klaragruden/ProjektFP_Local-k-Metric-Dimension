from sage.graphs.graph import Graph
from sage.numerical.mip import MixedIntegerLinearProgram, MIPSolverException
from sage.graphs.graph_plot import GraphPlot
import itertools

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

    try:
        # Poskusimo rešiti ILP
        optimalna_resitev = p.solve()
        vrednosti_za_S = p.get_values(x)
        # Oblikovanje rešitve
        niz_z_rezultatom = f"{k_value} dimension: {optimalna_resitev}"
        # Print tega niza
        # print(niz_z_rezultatom)
        return optimalna_resitev, vrednosti_za_S
    except MIPSolverException as e:
        # If an error occurs (e.g., infeasible), return a special value to indicate infinite dimension
        return float('inf'), None

    
    

def CLP_local_k_dim_sage(g, k_value):
    # Ustvari CLP
    p = MixedIntegerLinearProgram(maximization=False)

    # Spremenljivke x_i za vsako vozlišče v grafu
    x = p.new_variable(binary=True)

    # Pogoji za lokalno k-dimenzijo
    for vi in g.vertices():
        neighbors = g.neighbors(vi)
        expr = sum(x[vi] for vi in neighbors) + x[vi]
        p.add_constraint(expr >= k_value)

    # Ciljna funkcija (minimizacija števila vozlišč v množici)
    p.set_objective(sum(x[vi] for vi in g))

    try:
        # Rešimo problem
        optimal_solution = p.solve()

        # Pridobimo vrednosti za spremenljivke
        values_for_x = p.get_values(x)

        # Vrnemo optimalno rešitev
        return int(optimal_solution), values_for_x

    except MIPSolverException as e:
        # If an error occurs (no feasible solution), return a special value
        return float('inf'), None
#################################################################################################
#funcija, ki za grafe v graphs.nauty_geng najde grafe, kjer se lokalna in navadna dimenzija ujemata

def naloga2_1(graph, k_value):
    lokalne_dimenzije = {}
    navadne_dimenzije = {}
    
    for i in range(1, k_value + 1):
        lokalna = CLP_local_k_dim_sage(graph, i)
        navadna = CLP_k_dim(graph, i)
        lokalne_dimenzije[i] = lokalna
        navadne_dimenzije[i] = navadna
        
    if all(v == (float('inf'), None) for v in lokalne_dimenzije.values()) and all(v == (float('inf'), None) for v in navadne_dimenzije.values()):
        return False

    ujemanja = {}
    for kljuc in lokalne_dimenzije.keys():
        if kljuc in navadne_dimenzije and lokalne_dimenzije[kljuc] == navadne_dimenzije[kljuc]:
            if lokalne_dimenzije[kljuc] == navadne_dimenzije[kljuc] == (float('inf'), None):
                ujemanja[kljuc] = False
            else:
                ujemanja[kljuc] = lokalne_dimenzije[kljuc]
        else:
            ujemanja[kljuc] = False

    return ujemanja



def testiranje_naloga2_1(m, n, max_k):
    for i in range(m, n + 1):
        for graph in graphs.nauty_geng(f"{i} -c"):
            g = naloga2_1(graph, max_k)
            if any(v for v in g.values() if v is not False and len(v) >= 1):
                print(g)
                show(graph)


                     









