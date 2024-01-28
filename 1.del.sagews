︠a825b7ad-0ac5-4cbd-b851-982d5b1f6983o︠
from sage.graphs.graph_plot import GraphPlot
from sage.numerical.mip import MixedIntegerLinearProgram
import itertools
from sage.graphs.graph import Graph

###################################################################################
#CLP, ki vrne normalno k-to dimenzijo
︡41daa530-2646-416d-b470-179189231f5e︡
︠d64145f6-aeaf-4c00-8466-289f77fc5955s︠
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
︡b471a119-d698-4c78-b3d3-c1f7ae042b77︡{"done":true}
︠ea3a85a7-63f6-40a9-9a2f-fe4dc0b0e267s︠
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
︡ddd992e2-c0d1-42cb-9faf-ce9a0027683e︡{"done":true}
︠84adfdab-068b-4c5a-8de3-301c705253baso︠

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



︡95e3489e-c60d-4683-aa42-d4d316708a90︡{"stdout":"Lokalna 1-metrična dimenzija s 2 vozlišči: 1.0\nLokalna 2-metrična dimenzija s 2 vozlišči: 2.0\nLokalna 3-metrična dimenzija s 2 vozlišči: 2.0\nLokalna 4-metrična dimenzija s 2 vozlišči: (inf, None)\nLokalna 5-metrična dimenzija s 2 vozlišči: (inf, None)\nLokalna 6-metrična dimenzija s 2 vozlišči: (inf, None)\nLokalna 7-metrična dimenzija s 2 vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s 2 vozlišči: (inf, None)\nLokalna 9-metrična dimenzija s 2 vozlišči: (inf, None)\nLokalna 1-metrična dimenzija s 3 vozlišči: 1.0\nLokalna 2-metrična dimenzija s 3 vozlišči: 2.0\nLokalna 3-metrična dimenzija s 3 vozlišči: 3.0\nLokalna 4-metrična dimenzija s 3 vozlišči: (inf, None)\nLokalna 5-metrična dimenzija s 3 vozlišči: (inf, None)\nLokalna 6-metrična dimenzija s 3 vozlišči: (inf, None)\nLokalna 7-metrična dimenzija s 3 vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s 3 vozlišči: (inf, None)\nLokalna 9-metrična dimenzija s 3 vozlišči: (inf, None)\nLokalna 1-metrična dimenzija s 4 vozlišči: 2.0\nLokalna 2-metrična dimenzija s 4 vozlišči: 3.0\nLokalna 3-metrična dimenzija s 4 vozlišči: 4.0\nLokalna 4-metrična dimenzija s 4 vozlišči: (inf, None)\nLokalna 5-metrična dimenzija s 4 vozlišči: (inf, None)\nLokalna 6-metrična dimenzija s 4 vozlišči: (inf, None)\nLokalna 7-metrična dimenzija s 4 vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s 4 vozlišči: (inf, None)\nLokalna 9-metrična dimenzija s 4 vozlišči: (inf, None)\nLokalna 1-metrična dimenzija s 5 vozlišči: 2.0\nLokalna 2-metrična dimenzija s 5 vozlišči: 3.0\nLokalna 3-metrična dimenzija s 5 vozlišči: 5.0\nLokalna 4-metrična dimenzija s 5 vozlišči: (inf, None)\nLokalna 5-metrična dimenzija s 5 vozlišči: (inf, None)\nLokalna 6-metrična dimenzija s 5 vozlišči: (inf, None)\nLokalna 7-metrična dimenzija s 5 vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s 5 vozlišči: (inf, None)\nLokalna 9-metrična dimenzija s 5 vozlišči: (inf, None)\nLokalna 1-metrična dimenzija s 6 vozlišči: 2.0\nLokalna 2-metrična dimenzija s 6 vozlišči: 4.0\nLokalna 3-metrična dimenzija s 6 vozlišči: 6.0\nLokalna 4-metrična dimenzija s 6 vozlišči: (inf, None)\nLokalna 5-metrična dimenzija s 6 vozlišči: (inf, None)\nLokalna 6-metrična dimenzija s 6 vozlišči: (inf, None)\nLokalna 7-metrična dimenzija s 6 vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s 6 vozlišči: (inf, None)\nLokalna 9-metrična dimenzija s 6 vozlišči: (inf, None)\nLokalna 1-metrična dimenzija s 7 vozlišči: 3.0\nLokalna 2-metrična dimenzija s 7 vozlišči: 4.0\nLokalna 3-metrična dimenzija s 7 vozlišči: 7.0\nLokalna 4-metrična dimenzija s 7 vozlišči: (inf, None)\nLokalna 5-metrična dimenzija s 7 vozlišči: (inf, None)\nLokalna 6-metrična dimenzija s 7 vozlišči: (inf, None)\nLokalna 7-metrična dimenzija s 7 vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s 7 vozlišči: (inf, None)\nLokalna 9-metrična dimenzija s 7 vozlišči: (inf, None)\nLokalna 1-metrična dimenzija s 8 vozlišči: 3.0\nLokalna 2-metrična dimenzija s 8 vozlišči: 5.0"}︡{"stdout":"\nLokalna 3-metrična dimenzija s 8 vozlišči: 8.0\nLokalna 4-metrična dimenzija s 8 vozlišči: (inf, None)\nLokalna 5-metrična dimenzija s 8 vozlišči: (inf, None)\nLokalna 6-metrična dimenzija s 8 vozlišči: (inf, None)\nLokalna 7-metrična dimenzija s 8 vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s 8 vozlišči: (inf, None)\nLokalna 9-metrična dimenzija s 8 vozlišči: (inf, None)\nLokalna 1-metrična dimenzija s 9 vozlišči: 3.0\nLokalna 2-metrična dimenzija s 9 vozlišči: 5.0\nLokalna 3-metrična dimenzija s 9 vozlišči: 9.0\nLokalna 4-metrična dimenzija s 9 vozlišči: (inf, None)\nLokalna 5-metrična dimenzija s 9 vozlišči: (inf, None)\nLokalna 6-metrična dimenzija s 9 vozlišči: (inf, None)\nLokalna 7-metrična dimenzija s 9 vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s 9 vozlišči: (inf, None)\nLokalna 9-metrična dimenzija s 9 vozlišči: (inf, None)\n"}︡{"done":true}
︠29a25dac-07f5-4b74-a3dc-cbc0bf258fc3︠

︡981ceea3-49ef-497e-85b2-f4d89e6c4e44︡
︠133f929e-dd77-43e4-a89f-f6b8f76805a9s︠
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
︡18afc6c6-2211-4fc9-a75d-13a15656c777︡{"stdout":"Lokalna 8-metrična dimenzija s (2, 5) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (2, 6) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (2, 7) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (2, 8) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (2, 9) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (2, 10) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (2, 11) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (3, 5) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (3, 6) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (3, 7) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (3, 8) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (3, 9) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (3, 10) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (3, 11) vozlišči: (inf, None)\nLokalna 8-metrična dimenzija s (4, 5) vozlišči: 9.0\nLokalna 8-metrična dimenzija s (4, 6) vozlišči: 10.0\nLokalna 8-metrična dimenzija s (4, 7) vozlišči: 11.0\nLokalna 8-metrična dimenzija s (4, 8) vozlišči: 11.0\nLokalna 8-metrična dimenzija s (4, 9) vozlišči: 12.0\nLokalna 8-metrična dimenzija s (4, 10) vozlišči: 13.0\nLokalna 8-metrična dimenzija s (4, 11) vozlišči: 14.0\n"}︡{"done":true}
︠3ee3c83f-dd34-401e-b6c6-8bc4eb739ad9︠
H = graphs.CubeConnectedCycle(4)
plot(H)
︡4ff043f0-0bed-4441-9766-348d8fb8b6cc︡
︠7af6326f-c529-491f-bdd8-c52485bcb222︠
#DRUGI DEL NALOGE:

#funkcija, pri kateri za posamezno družino grafov preverimo ujemanja dimenzij


# Preveri za posamezno družino grafov če se dimenziji ujemata
︡3f5bd17a-0403-4787-ac0e-6f652ff1498e︡
︠bcfc1b21-78a7-4c05-a7b2-fbb3e76b8cda︠
︡3de7514a-bc17-4395-8ea1-dc2147409610︡
︠436f465e-6ee8-4f28-a687-eb9245b0fdbd︠
︡d4ced548-b260-4434-b617-49d829a35e1c︡
︠bf492807-deef-47df-af13-d37ee5326ffa︠
︡a0d810cf-d599-4747-9ced-69deeb0bc7ad︡
︠39813294-c723-4c89-9085-f874cdc99eba︠
︡e4f322fa-e680-4b06-bebc-f3a19be0ee6a︡
︠6e6b31c3-5628-4d25-9583-6621f449be0b︠
︡3c5a3142-5ec9-4b15-8b72-43a796e8f2b5︡
︠f3259d4a-aeec-493e-973f-db1ddc553b35︠
︡bd831d1c-9d8f-416d-b3d2-486dc7d7ba52︡
︠54c7d567-e255-4dfc-9988-686cd71fbf19︠
︡94e6c571-bfec-48e0-9fcd-2d165f58c7bf︡
︠aaaa89b6-b0d7-463f-8e71-e52465f80a18︠
︡81d71cc0-a031-4195-810f-256583b4a20f︡
︠bbfd03be-8c74-4106-ad0e-724abdca3a0e︠
︡fc2e7b6b-95fc-4a15-8474-c59069dcb3ac︡
︠d2c25889-c403-4c30-97af-c300b4203d29︠
︡131265e3-b4df-4263-b003-a55d483e9f09︡
︠b135f86c-d46c-43d1-be06-459a18e9e949︠
︡1c42a08b-6c5b-4df7-ba69-18ff3262787b︡
︠b29b3de1-c91d-4bf9-b53e-b12e21c345d7︠
︡ba1a1621-475f-467a-9f7b-6824976b1e47︡
︠af0821b6-14c4-4d1d-9917-c7355370bd25︠
︡93134006-e69c-496e-9c66-6d18ec2fb714︡
︠911dd8d3-d424-4fb8-8d72-16849c7fe362︠
︡33d17462-2427-487f-aed1-bff262f0ad38︡
︠4a4ed2d2-74f4-4f5f-88a9-bab37a9d0e32︠
︡96bc4636-9b2e-455a-987f-ca59ae654fa5︡
︠9c065ff8-70aa-4531-a4d6-0e031b54199e︠
︡dc44c09a-f3e3-45a2-91ba-112c786c05f5︡
︠c6680681-52dc-4ccc-803c-8c7ce943f991︠
︡bb54f723-04c7-4728-b91a-94252ffa8acf︡
︠f8022f00-ec9c-457b-a686-23ef20d305d9︠
︡2eaff1f2-83a3-47c3-b997-464878f8deed︡
︠5c57f047-b049-451c-b9a6-c3e47312f454︠
︡c4c7e0ed-93c5-45ed-9f84-c5189d0e43c9︡
︠719f4c58-8f66-4a77-8c0d-95f7ccab3408s︠
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
   
            
            
            

︡c197d353-f056-4fd1-b677-370025c75da6︡{"stdout":"Ujemanje za graf s 2 vozlišči, k = 1: k-dim = k-ldim = 1.0\nUjemanje za graf s 2 vozlišči, k = 2: k-dim = k-ldim = 2.0\nUjemanje za graf s 4 vozlišči, k = 1: k-dim = k-ldim = 2.0\nUjemanje za graf s 5 vozlišči, k = 1: k-dim = k-ldim = 2.0\nUjemanje za graf s 5 vozlišči, k = 2: k-dim = k-ldim = 3.0\nUjemanje za graf s 5 vozlišči, k = 4: k-dim = k-ldim = 5.0\nUjemanje za graf s 6 vozlišči, k = 1: k-dim = k-ldim = 2.0\nUjemanje za graf s 6 vozlišči, k = 2: k-dim = k-ldim = 3.0\nUjemanje za graf s 6 vozlišči, k = 4: k-dim = k-ldim = 6.0\n"}︡{"done":true}
︠278805ff-2780-423d-8282-8bcf17fde2c7︠









