
from sage.graphs.graph import Graph

import matplotlib.pyplot as plt
import networkx as nx




#poti
n = 8
G1 = graphs.PathGraph(n)
plot(G1)

#cikli
n = 12
C1 = graphs.CycleGraph(n)
plot(C1)

n= 5
K1 = graphs.CompleteGraph(n)
plot(K1)

# polni dvodelni graf
m = 5
n = 6
B1 = graphs.CompleteBipartiteGraph(n, m)
plot(B1)

#hiperkocke
n = 5
N = graphs.CubeGraph(n)
plot(N)


#povezani cikel v hiperkocki
n = 3
H = graphs.CubeConnectedCycle(n)
plot(H)










