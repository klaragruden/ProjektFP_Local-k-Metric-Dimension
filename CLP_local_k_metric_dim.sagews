︠8f9c2661-54f6-4cab-bd76-f368ab01bf38s︠

from sage.graphs.graph_plot import GraphPlot
from sage.numerical.mip import MixedIntegerLinearProgram

###################################################################################

#CLP, ki vrne lokalno k-to dimenzijo grafa
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
    optimal_solution = p.solve()

    # Pridobimo vrednosti za spremenljivke
    values_for_x = p.get_values(x)

    # Vrnemo optimalno rešitev
    #return int(optimal_solution), values_for_x
    return optimal_solution




###################################################################################


#CLP, ki vrne k-to dimenzijo grafa
def CLP_k_dim(g, k_value):
    # Ustvarimo CLP
    p = MixedIntegerLinearProgram(maximization=False)
    #nove spremenljivke
    x = p.new_variable(binary = True)
    #ciljna funkcija
    p.set_objective(sum(x[v] for v in g))

    #p.p.
    for va in g:
        for vb in g:
            if va != vb:
                expr = sum(int(bool(g.distance(va, vi) - g.distance(vb, vi))) * x[vi] for vi in g)
                p.add_constraint(expr >= k_value)
            else:
                continue


    optimalna_resitev = p.solve()
    vrednosti_za_S = p.get_values(x)

    #oblikovanje rešitve
    niz_z_rezultatom = f"{k_value} dimension: {optimalna_resitev}"
    # Print tega niza
    #print(niz_z_rezultatom)
    return optimalna_resitev#, vrednosti_za_S
   

######################################################################
︡20bf43c1-f15f-4887-8e3c-a97d9776e659︡{"done":true}









