package ara.projet.mutex;

import static ara.util.Constantes.log;

import java.util.ArrayDeque;

import ara.projet.mutex.NaimiTrehelAlgo.RequestMessage;
import ara.projet.mutex.NaimiTrehelAlgo.State;
import ara.projet.mutex.NaimiTrehelAlgo.TokenMessage;
import peersim.config.Configuration;
import peersim.core.CommonState;
import peersim.core.Network;
import peersim.core.Node;
import peersim.transport.Transport;

public class NaimiTrehelAlgoInfo extends NaimiTrehelAlgo{

	protected int req_counter = 0;
	protected int tok_counter = 0;
	
	public NaimiTrehelAlgoInfo(String prefix) {
		super(prefix);
	}
	
	
	public String getNodeInfo() {
		String messagesCounter = "RequestMsg :"+this.req_counter+", TokenMsg:"+this.nb_cs;
		//String alphaInfo = "Nombre de CS entrées: "+this.nb_cs+", pour un total de: "+alphaTotal+".";
		//String betaInfo = "Temps passé à attendre de mon plein grés (attention, au max un beta n'est pas inclus): "+betaPseudoTotal+".";
		String waitInfo = "Temps passé en requestion (approx à cause de beta et du temps total): "+(this.getWaitingTime())+".";
		
		//return messagesCounter+"\n\t\t"+alphaInfo+"\n\t\t"+betaInfo+"\n\t\t"+waitInfo;
		return messagesCounter+"\n\t\t"+waitInfo;
	}
	
	public int getReqCount() {
		return this.req_counter;
	}
	
	public static String getPerStateTimeInfo(long nb_cs_total, long totalTime) {
		Double[] info = NaimiTrehelAlgoInfo.getPerStateTime(nb_cs_total, totalTime);
		return "U: "+info[0]+"%, "+"T: "+info[1]+"%, "+"N: "+info[2]+"%.";
	}
	
	public Long getWaitingTime() {
		long betaPseudoTotal = this.nb_cs*this.timeBetweenCS;
		long alphaTotal = this.nb_cs*this.timeCS;
		long totalTime = CommonState.getTime(); // je n'appelle cette méthode qu'à la fin, ainsi j'ai ici le vrai endtime
		return totalTime-alphaTotal-betaPseudoTotal;
	}
	
	/*
	 * [0]: temps passé dans l'état U (jeton utilisé) = Total(nb_cs) * alpha
	 * [1]: temps passé dans l'état T (jeton en transit) = total_token_msg * gamma
	 * [2]: temps passé dans l'état N (possede le jeton mais ne l'utilise pas) = le reste
	 */
	public static Double[] getPerStateTime(long nb_cs_total, long totalTime) {
		Double U = nb_cs_total * Configuration.getLong("protocol.naimitrehel.timeCS") + 0.0;
		Double T = nb_cs_total * Configuration.getLong("protocol.transport.mindelay") + 0.0;
		// log.info("EndTime: "+totalTime+" U: "+U+", T: "+T+", N: "+(totalTime-(T+U)));
		return new Double[] {(U/totalTime)*100, (T/totalTime)*100, ( (totalTime-(T+U))/totalTime )*100};
	}
	
	public int getNbCs() {
		return this.nb_cs;
	}
	

}
