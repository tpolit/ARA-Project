# ARA-Project

Réalisation d'une étude expérimentale d'algorithmes répartis grâce au simulateur PeerSim.

- Lancez le script `launch_all.sh` dans le repertoire `projet-src` avec comme argument la durée de la simulation.
    ```shell
    cd path_to_projet-src
    bash ./launch_all.sh 100000
    ```
- Les données et figures des métriques seront sous le repértoire `projet-src/output/`.

## Objectifs : 

Le but de ce projet est de faire une étude expérimentale à travers le simulateur Peer-
Sim. Dans un premier temps, nous étudierons dans un environnement fiable une applica-
tion fictive qui se base sur un protocole de verrouillage distribué. Dans un second temps,
nous exécuterons cette application dans un environnement non fiable (un nœud peut tom-
ber en panne). Dans ce cas, l’application se basera sur un protocole distribué de points
de reprise (checkpointing) permettant de sauvegarder l’état des nœuds régulièrement et
de reprendre l’exécution à un état stable en cas d’erreur ou de panne.

## Notes :

Faire bien attention à lancer le script avec un terminal placé sur le repertoire, sinon 
les chemin de fichiers de sorties ne seront pas atteignables par le write vu qu'ils sont 
relatifs.