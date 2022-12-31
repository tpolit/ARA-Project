package ara.util;

import static ara.util.Constantes.log;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

import ara.projet.mutex.NaimiTrehelAlgo;
import peersim.config.Configuration;
import peersim.core.CommonState;
import peersim.core.Control;
import peersim.core.Network;
import peersim.core.Node;

public class TheEnd implements Control{

	/* instancier 4 Files (un par métrique)
	 * écrire à chaque execution à la fin du fichier les nouvelles valeurs
	 * faire un script qui créer dynamiquement le config.txt avec alpha et gamma comme arguments du script et beta une variable local.
	 * à chaque config.txt le script va lancer la simulation.
	 * */
	private File msgPerCsFile, reqCountFile, waitingTimeFile, statePercentagesFile;
	private Writer msgPerCsWriter, reqCountWriter, waitingTimeWriter, statePercentagesWriter;
	
	private static final String PAR_ALGO = "algo";
	private final int algoPid;
	public TheEnd(String prefix) throws IOException {
		algoPid = Configuration.getPid(prefix+"."+PAR_ALGO);
		long alpha = Configuration.getLong("protocol.naimitrehel.timeCS");
		long gamma = Configuration.getLong("protocol.transport.mindelay");
		// creating files
		msgPerCsFile = new File("./output/msgPerCs_"+alpha+"_"+gamma+".csv");
		reqCountFile = new File("./output/reqCount_"+alpha+"_"+gamma+".csv");
		waitingTimeFile = new File("./output/waitingTime_"+alpha+"_"+gamma+".csv");
		statePercentagesFile = new File("./output/statePercentages_"+alpha+"_"+gamma+".csv");
		msgPerCsFile.createNewFile();
		reqCountFile.createNewFile();
		waitingTimeFile.createNewFile();
		statePercentagesFile.createNewFile();
		// System.out.println(msgPerCsFile.createNewFile()+" "+reqCountFile.createNewFile()+" "+waitingTimeFile.createNewFile()+" "+statePercentagesFile.createNewFile());
		// instantiating writers
		msgPerCsWriter = new FileWriter(msgPerCsFile, true);
		msgPerCsWriter.write("beta,msgPerCs\n");
		reqCountWriter = new FileWriter(reqCountFile, true);
		reqCountWriter.write("beta,reqCount\n");
		waitingTimeWriter = new FileWriter(waitingTimeFile, true);
		waitingTimeWriter.write("beta,waitingTime\n");
		statePercentagesWriter = new FileWriter(statePercentagesFile, true);
		statePercentagesWriter.write("beta,U,T,N\n");
	}
	
	@Override
	public boolean execute()
	{
		//StringBuffer dataLine = new StringBuffer();
		long nb_cs_total = 0;
		int req_total=0; // token_total == nb_cs_total
		double msgPerCs = 0.0;
		long waitingTimeTotal = 0;
		long beta = Configuration.getLong("protocol.naimitrehel.timeBetweenCS");
		
		for(int i=0; i < Network.getCapacity() ; i++) {
			Node node = Network.get(i);
			NaimiTrehelAlgo algo = (NaimiTrehelAlgo)node.getProtocol(algoPid);
			//log.info("Node #"+node.getID()+" : "+algo.getNodeInfo());
			nb_cs_total += algo.getNbCs();
			req_total += algo.getReqCount();
			waitingTimeTotal += algo.getWaitingTime();
		}
		
		log.info("M1-Messages info: \n\t-Request: "+req_total+"\n\t-Token: "+nb_cs_total);
		msgPerCs = ((double)(nb_cs_total+req_total))/nb_cs_total;
		log.info("M1-Nombre de messages par section critique (approximation avec les sommes): ("+(req_total+nb_cs_total)+")/"+nb_cs_total+"= "+msgPerCs);
		
		
		log.info("-Nombre de messages requetes et temps d'attente par noeud: ");
		for(int i=0; i < Network.getCapacity() ; i++) {
			Node node = Network.get(i);
			NaimiTrehelAlgo algo = (NaimiTrehelAlgo)node.getProtocol(algoPid);
			log.info("\t-Node #"+node.getID()+" : RequestCount = "+algo.getReqCount()+", WaitingTime = "+algo.getWaitingTime());
		}
		
		log.info("M2-Moyenne de Timewaiting: "+((double)waitingTimeTotal/Network.getCapacity()));
	
		log.info("M3-Moyenne de requestCount: "+((double)req_total/Network.getCapacity()));
		
		log.info("M4-"+NaimiTrehelAlgo.getPerStateTimeInfo(nb_cs_total, CommonState.getTime()));
		Double[] statePercentages = NaimiTrehelAlgo.getPerStateTime(nb_cs_total, CommonState.getTime());
		try {
			msgPerCsWriter.append(beta+","+msgPerCs+"\n");
			waitingTimeWriter.append(beta+","+((double)waitingTimeTotal/Network.getCapacity())+"\n");
			reqCountWriter.append(beta+","+((double)req_total/Network.getCapacity())+"\n");
			statePercentagesWriter.append(beta+","+statePercentages[0]+","+statePercentages[1]+","+statePercentages[2]+"\n");
			msgPerCsWriter.flush();
			reqCountWriter.flush();
			waitingTimeWriter.flush();
			statePercentagesWriter.flush();
		} catch (IOException e) {
			System.err.println("Error in writing!!");
		} finally {
			try {
				msgPerCsWriter.close();
				reqCountWriter.close();
				waitingTimeWriter.close();
				statePercentagesWriter.close();
			} catch (IOException e) {
				System.err.println("Error in closing");
			}
		}
		return false;
	}
}
