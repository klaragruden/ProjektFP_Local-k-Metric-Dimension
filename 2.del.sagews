︠42e2bbb6-fe4e-42a2-99a5-3a8ebb8639e8s︠
︡480b2ee1-3db1-4f81-b144-302a7628b7d5︡
︠b84c168b-2aab-4f1d-b04f-a05bfb814955s︠
︡91472d84-c8a1-4871-909c-9d378f3c71c5︡
︠6f11d4c5-b536-44bb-a786-6e0e1b91f451s︠
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


                


︡773d0a4a-4844-4fe4-81b4-8da2f5f3cfc5︡{"done":true}
︠83150379-e0e9-4e06-a53f-cf0835a51599︠
           
                
︡e9de9b98-4dfb-4c5e-893c-833f48809f6f︡
︠5017f7bb-4728-4304-9ba0-1365fb8b2c00s︠
testiranje_naloga2_1(2,7,2)                             
︡1117f516-14d4-49f7-9375-53128383268b︡{"stdout":"{1: False, 2: (2, {1: 1.0, 0: 1.0})}\n"}︡{"d3":{"data":{"charge":-120,"directed":false,"edge_labels":false,"edge_thickness":2,"gravity":0.04,"height":null,"link_distance":50,"link_strength":1,"links":[{"color":"#aaa","curve":0,"name":"","source":0,"strength":0,"target":1}],"loops":[],"nodes":[{"group":"0","name":"0"},{"group":"0","name":"1"}],"pos":[],"vertex_labels":true,"vertex_size":7,"width":null},"viewer":"graph"}}︡{"stdout":"{1: False, 2: (4, {3: 0.0, 4: 1.0, 0: 1.0, 5: 1.0, 6: 1.0, 1: 0.0, 2: 0.0})}"}︡{"stdout":"\n"}︡{"d3":{"data":{"charge":-120,"directed":false,"edge_labels":false,"edge_thickness":2,"gravity":0.04,"height":null,"link_distance":50,"link_strength":1,"links":[{"color":"#aaa","curve":0,"name":"","source":0,"strength":0,"target":3},{"color":"#aaa","curve":0,"name":"","source":0,"strength":0,"target":4},{"color":"#aaa","curve":0,"name":"","source":1,"strength":0,"target":4},{"color":"#aaa","curve":0,"name":"","source":1,"strength":0,"target":5},{"color":"#aaa","curve":0,"name":"","source":1,"strength":0,"target":6},{"color":"#aaa","curve":0,"name":"","source":2,"strength":0,"target":5},{"color":"#aaa","curve":0,"name":"","source":2,"strength":0,"target":6},{"color":"#aaa","curve":0,"name":"","source":3,"strength":0,"target":5},{"color":"#aaa","curve":0,"name":"","source":3,"strength":0,"target":6},{"color":"#aaa","curve":0,"name":"","source":5,"strength":0,"target":6}],"loops":[],"nodes":[{"group":"0","name":"0"},{"group":"0","name":"1"},{"group":"0","name":"2"},{"group":"0","name":"3"},{"group":"0","name":"4"},{"group":"0","name":"5"},{"group":"0","name":"6"}],"pos":[],"vertex_labels":true,"vertex_size":7,"width":null},"viewer":"graph"}}︡{"stdout":"{1: False, 2: (4, {2: 1.0, 4: 0.0, 6: 0.0, 0: 1.0, 3: 1.0, 5: 1.0, 1: 0.0})}"}︡{"stdout":"\n"}︡{"d3":{"data":{"charge":-120,"directed":false,"edge_labels":false,"edge_thickness":2,"gravity":0.04,"height":null,"link_distance":50,"link_strength":1,"links":[{"color":"#aaa","curve":0,"name":"","source":0,"strength":0,"target":2},{"color":"#aaa","curve":0,"name":"","source":0,"strength":0,"target":4},{"color":"#aaa","curve":0,"name":"","source":0,"strength":0,"target":6},{"color":"#aaa","curve":0,"name":"","source":1,"strength":0,"target":3},{"color":"#aaa","curve":0,"name":"","source":1,"strength":0,"target":5},{"color":"#aaa","curve":0,"name":"","source":1,"strength":0,"target":6},{"color":"#aaa","curve":0,"name":"","source":2,"strength":0,"target":4},{"color":"#aaa","curve":0,"name":"","source":2,"strength":0,"target":6},{"color":"#aaa","curve":0,"name":"","source":3,"strength":0,"target":5}],"loops":[],"nodes":[{"group":"0","name":"0"},{"group":"0","name":"1"},{"group":"0","name":"2"},{"group":"0","name":"3"},{"group":"0","name":"4"},{"group":"0","name":"5"},{"group":"0","name":"6"}],"pos":[],"vertex_labels":true,"vertex_size":7,"width":null},"viewer":"graph"}}︡{"done":true}
︠acb3b668-d990-4d41-b920-3d24517f01f7︠
                
               









