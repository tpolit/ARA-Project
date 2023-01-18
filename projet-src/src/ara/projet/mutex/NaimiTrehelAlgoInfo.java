package ara.projet.mutex;

import java.util.ArrayList;
import java.util.List;

import ara.util.Message;
import peersim.config.Configuration;
import peersim.core.CommonState;
import peersim.core.Node;

public class NaimiTrehelAlgoInfo extends NaimiTrehelAlgo {

	protected int req_counter = 0; // calcule toutes les requetes recus recus
	protected int req_inter_counter = 0; // calcule les requetes intermediaires
	protected int tok_counter = 0; // calcules que les tokens arrivé à destination
	// protected int beta_counter = 0;
	protected List<Long> req_dates = null;
	protected List<Long> cs_dates = null;

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
				if(((RequestMessage) m).getRequester()!=m.getIdSrc())
					req_inter_counter++;
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
				if(cs_dates == null) cs_dates = new ArrayList<>();
				cs_dates.add(CommonState.getTime());
				break;
			case requesting :
				if(req_dates == null) req_dates = new ArrayList<>();
				req_dates.add(CommonState.getTime());
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
		return messagesCounter + "\n\t\t" + waitInfo + "\n\t\t Beta_Starting: "+this.getWaitingTime()[0]+"+/-"+this.getWaitingTime()[1];
	}

	public int getTokenCount() {
		return this.tok_counter;
	}

	public int getReqCount() {
		return this.req_counter;
	}

	public int getReqInterCount() {
		return this.req_inter_counter;
	}
	public static String getPerStateTimeInfo(long nb_cs_total, long tok_msg_total, long totalTime) {
		Double[] info = NaimiTrehelAlgoInfo.getPerStateTime(nb_cs_total, tok_msg_total, totalTime);
		return "U: " + info[0] + "%, " + "T: " + info[1] + "%, " + "N: " + info[2] + "%.";
	}

	/*
	 * [0]: average waiting time per cs
	 * [1]: ecart type
	 */
	public double[] getWaitingTime() {
		//List<Double> ecarts = new ArrayList<>();
		List<Long> waiting_times = new ArrayList<>();
		long total = 0;
		double avg = 0.0, err = 0.0, total_ecart = 0.0;
		for(int i=0; i<this.nb_cs; i++) {
			waiting_times.add(cs_dates.get(i)-req_dates.get(i));
			total += (cs_dates.get(i)-req_dates.get(i));
		}
		avg = ((double)total)/this.nb_cs;
		for(long w:waiting_times) {
			//ecarts.add((w-avg)*(w-avg));
			total_ecart += (w-avg)*(w-avg);
		}
		err = Math.sqrt(total_ecart/nb_cs);
		return new double[]{avg,err};
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
