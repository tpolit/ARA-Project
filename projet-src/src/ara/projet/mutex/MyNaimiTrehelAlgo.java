package ara.projet.mutex;

import static ara.util.Constantes.log;

import java.util.ArrayDeque;

import ara.projet.mutex.NaimiTrehelAlgo.RequestMessage;
import ara.projet.mutex.NaimiTrehelAlgo.State;
import ara.projet.mutex.NaimiTrehelAlgo.TokenMessage;
import peersim.core.Network;
import peersim.core.Node;
import peersim.transport.Transport;

public class MyNaimiTrehelAlgo extends NaimiTrehelAlgo{

	protected int req_counter = 0;
	protected int tok_counter = 0;
	
	public MyNaimiTrehelAlgo(String prefix) {
		super(prefix);
	}
	
	
	protected void changestate(Node host, State s) {
		super.changestate(host, s);
		switch(this.state) {
			
		}
	}
	

}
