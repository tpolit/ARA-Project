package ara.util;

import peersim.config.Configuration;
import peersim.core.Control;
import peersim.core.Network;
import peersim.core.Node;

public class Initialisateur implements Control{

	private static final String PAR_ALGO = "algo";
	private final int algoPid;
	public Initialisateur(String prefix) {
		algoPid = Configuration.getPid(prefix+"."+PAR_ALGO);
	}
	
	@Override
	public boolean execute() {
		for(int i=0; i < Network.getCapacity() ; i++) {
			Node node = Network.get(i);
			node.getProtocol(algoPid);
		}
		return false;
	}
}
