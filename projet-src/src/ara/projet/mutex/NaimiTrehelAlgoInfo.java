package ara.projet.mutex;

import java.util.ArrayList;
import java.util.List;

import ara.util.Message;
import peersim.config.Configuration;
import peersim.core.CommonState;
import peersim.core.Node;

public class NaimiTrehelAlgoInfo extends NaimiTrehelAlgo {

	protected int req_counter = 0; // calcule que les messages recus
	protected int tok_counter = 0; // calcules que les tokens arrivé à destination
	// protected int beta_counter = 0;
	protected List<Long> beta_starting = null;

	public NaimiTrehelAlgoInfo(String prefix) {
		super(prefix);
	}

	public Object clone() {
		NaimiTrehelAlgoInfo res = null;
		res = (NaimiTrehelAlgoInfo) super.clone();
		return res;
	}
	// Getting info from class methods
	@Override
	public void processEvent(Node node, int pid, Object event) {

		// count only received messages
		// pour calculer les messages à l'envoi faudrait verifier les conditions verifiés dans les méthodes privées
		if (event instanceof Message) {
			Message m = (Message) event;
			if (m instanceof RequestMessage) {
				req_counter++;
			} else if (m instanceof TokenMessage) {
				tok_counter++;
			} else {
				throw new RuntimeException("Receive unknown type Message");
			}
		}
		// call super
		super.processEvent(node, pid, event);
	}
	
	@Override
	protected void changestate(Node host, State s) {
		this.state = s;
		switch (this.state) {
			case inCS :
				break;
			case tranquil :
				// beta_counter++;
				if(beta_starting == null) beta_starting = new ArrayList<>();
				beta_starting.add(CommonState.getTime());
				break;
			default :
		}
		super.changestate(host, s);
	}
	
	// Calcul des metriques

	public String getNodeInfo() {
		String messagesCounter = "RequestMsg :" + this.req_counter + ", TokenMsg:" + this.tok_counter; // tok_counter peut être inferieur à nb_cs 
		// String alphaInfo = "Nombre de CS entrées: "+this.nb_cs+", pour un total de:"+alphaTotal+".";
		// String betaInfo = "Temps passé à attendre de mon plein grés (attention, au max un beta n'est pas inclus): "+betaPseudoTotal+".";
		String waitInfo = "Temps passé en requestion (approx à cause de beta et du temps total): "+ (this.getWaitingTime()) + ".";
		// return messagesCounter+"\n\t\t"+alphaInfo+"\n\t\t"+betaInfo+"\n\t\t"+waitInfo;
		return messagesCounter + "\n\t\t" + waitInfo + "\n\t\t Beta_Starting: "+beta_starting;
	}

	public int getTokenCount() {
		return this.tok_counter;
	}

	public int getReqCount() {
		return this.req_counter;
	}

	public static String getPerStateTimeInfo(long nb_cs_total, long tok_msg_total, long totalTime) {
		Double[] info = NaimiTrehelAlgoInfo.getPerStateTime(nb_cs_total, tok_msg_total, totalTime);
		return "U: " + info[0] + "%, " + "T: " + info[1] + "%, " + "N: " + info[2] + "%.";
	}

	public Long getWaitingTime() {
		long totalTime = CommonState.getTime(); // je n'appelle cette méthode qu'à la fin, ainsi j'ai ici le vrai endtime
		long betaPseudoTotal = (this.beta_starting.size()-1) * this.timeBetweenCS; // omettre le dernier beta au cas où il causerait un overflow apres la fin de la simu
		long lastBetaStart = this.beta_starting.get(beta_starting.size()-1); // savoir si le beta peut s'ecouler d'ici la fin de la simu
		if( (lastBetaStart + this.timeBetweenCS) > totalTime) // faudrait ajouter moins que beta
			betaPseudoTotal += (totalTime - lastBetaStart);
		else // egal ou inferieur: beta dans les deux cas
			betaPseudoTotal += this.timeBetweenCS;
		long alphaTotal = this.nb_cs * this.timeCS; // si la simu se termine alors qu'un noeud etait encore en CS, ce temps n'est inclus.
		return totalTime - alphaTotal - betaPseudoTotal;
	}

	/*
	 * [0]: temps passé dans l'état U (jeton utilisé) = Total(nb_cs) * alpha 
	 * [1]: temps passé dans l'état T (jeton en transit) = total_token_msg * gamma 
	 * [2]: temps passé dans l'état N (possede le jeton mais ne l'utilise pas) = le reste
	 */
	public static Double[] getPerStateTime(long nb_cs_total, long tok_msg_total, long totalTime) {
		Double U = nb_cs_total * Configuration.getLong("protocol.naimitrehel.timeCS") + 0.0; // une perte si la simu se termine alors qu'un noeud etait toujours en CS
		Double T = tok_msg_total * Configuration.getLong("protocol.transport.mindelay") + 0.0;
		// log.info("EndTime: "+totalTime+" U: "+U+", T: "+T+", N: "+(totalTime-(T+U)));
		return new Double[] { (U / totalTime) * 100, (T / totalTime) * 100, ((totalTime - (T + U)) / totalTime) * 100 };
	}

	public int getNbCs() {
		return this.nb_cs;
	}

}
