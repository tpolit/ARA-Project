package ara.util;

import static ara.util.Constantes.log;
import ara.projet.mutex.NaimiTrehelAlgo;
import peersim.config.Configuration;
import peersim.core.CommonState;
import peersim.core.Control;
import peersim.core.Network;
import peersim.core.Node;

public class TheEnd implements Control{

	private static final String PAR_ALGO = "algo";
	private final int algoPid;
	public TheEnd(String prefix) {
		algoPid = Configuration.getPid(prefix+"."+PAR_ALGO);
	}
	
	@Override
	public boolean execute() {
		long nb_cs_total = 0;
		for(int i=0; i < Network.getCapacity() ; i++) {
			Node node = Network.get(i);
			NaimiTrehelAlgo algo = (NaimiTrehelAlgo)node.getProtocol(algoPid);
			log.info("Node #"+node.getID()+" : "+algo.getInfoEnd());
			nb_cs_total += algo.getNbCs();
		}
		log.info(NaimiTrehelAlgo.getPerStateTimeInfo(nb_cs_total, CommonState.getTime()));
		return false;
	}
}
