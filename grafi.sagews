︠ca8747fd-4c86-4936-9b05-e7be843bd72cso︠
from sage.graphs.graph import Graph

import matplotlib.pyplot as plt
import networkx as nx




#poti

n = 8
G1 = graphs.PathGraph(n)
plot(G1)


︡7278d333-a442-4284-8b7b-3014f4b993e5︡{"file":{"filename":"/tmp/tmpt6e5bm9f/tmp_c887sixe.svg","show":true,"text":null,"uuid":"4135d1df-abe6-40dd-8959-64944659b0dd"},"once":false}︡{"done":true}
︠492e294c-ba3e-4a97-813c-681e0228c5daso︠
#cikli
n = 12
C1 = graphs.CycleGraph(n)
plot(C1)
︡571e4eb6-7b59-432d-a0d6-4ab36843b370︡{"file":{"filename":"/tmp/tmpt6e5bm9f/tmp_ip5tvlwk.svg","show":true,"text":null,"uuid":"39e029aa-a3df-46fb-8960-f0584cb01280"},"once":false}︡{"done":true}
︠b19b9da3-a30c-4a86-a5f9-0bb481a739a3so︠
#polni grafi

n= 5
K1 = graphs.CompleteGraph(n)
plot(K1)
︡ca10705e-80dd-4e68-aa39-7a846621b078︡{"file":{"filename":"/tmp/tmpt6e5bm9f/tmp_qf52vly0.svg","show":true,"text":null,"uuid":"ca264f05-daf3-4c25-be99-490712b6db03"},"once":false}︡{"done":true}
︠cd1e50b3-89fb-4c8f-becc-43aafff92f52so︠
# polni dvodelni graf

m = 5
n = 6
B1 = graphs.CompleteBipartiteGraph(n, m)
plot(B1)

︡6fe84881-267a-4908-9797-2e983994e344︡{"file":{"filename":"/tmp/tmpt6e5bm9f/tmp_1kvrs9nb.svg","show":true,"text":null,"uuid":"c120bed6-56f0-4e3c-9642-b8e0da54fa84"},"once":false}︡{"done":true}
︠13fb5ea0-401a-43a3-96c6-c6009cc5af0cso︠



#hiperkocka
n = 3
H = graphs.CubeConnectedCycle(n)
plot(H)
︡b98145cf-bdbc-49b3-9dae-faf7ab7ba7d5︡{"file":{"filename":"/tmp/tmpt6e5bm9f/tmp_hzdvrcy9.svg","show":true,"text":null,"uuid":"641aba52-2656-4334-87a3-8ea5c6b81146"},"once":false}︡{"done":true}
︠4bbfaa26-13e4-4720-832f-df678cd612f0︠









