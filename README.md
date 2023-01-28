# ARA-Project

Réalisation d'une étude expérimentale d'algorithmes répartis grâce au simulateur PeerSim.

## Execution

- Faites bien attention à bien modifier la ligne `65` dans `launch_script.sh` et la ligne `78` dans `launch_script_crash.sh` avec une commande qui va lancer votre simulation java.
- Lancez le script `launch_all.sh` dans le repertoire `projet-src` avec une durée de simulation définissable avec  l'option `-t`. Pour la simulation avec recouvrement utilisez le flag `-c`
    ```shell
    cd path_to_projet-src
    bash ./launch_all.sh -t 100000 # execution normal
    bash ./launch_all.sh -c -t 100000 # execution avec recouvrement
    ```
- Vous pourrez changer les differentes métriques en modifiant les scripts `launch_all.sh`, `launch_script.sh` et `launch_script_crash.sh`.
- Les données et figures des métriques seront sous le repértoire `projet-src/output/` ou `projet-src/output/` en fonction du mode d'exécution choisi.

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