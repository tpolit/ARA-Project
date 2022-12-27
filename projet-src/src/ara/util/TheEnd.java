package ara.util;

import static ara.util.Constantes.log;
import ara.projet.mutex.NaimiTrehelAlgo;
import peersim.config.Configuration;
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
		for(int i=0; i < Network.getCapacity() ; i++) {
			Node node = Network.get(i);
			NaimiTrehelAlgo algo = (NaimiTrehelAlgo)node.getProtocol(algoPid);
			log.info("Node #"+node.getID()+" : "+algo.getInfoEnd());
		}
		return false;
	}
}
