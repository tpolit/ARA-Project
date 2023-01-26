package ara.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

import ara.projet.mutex.NaimiTrehelAlgoInfo;
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
	private boolean fileCreated = false; 
	
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
		
		fileCreated = msgPerCsFile.createNewFile()&reqCountFile.createNewFile()&waitingTimeFile.createNewFile()&statePercentagesFile.createNewFile();
		
		// System.out.println(fileCreated);
		// instantiating writers
		msgPerCsWriter = new FileWriter(msgPerCsFile, true);
		reqCountWriter = new FileWriter(reqCountFile, true);
		waitingTimeWriter = new FileWriter(waitingTimeFile, true);
		statePercentagesWriter = new FileWriter(statePercentagesFile, true);
	}
	
	@Override
	public boolean execute()
	{
		//StringBuffer dataLine = new StringBuffer();
		long nb_cs_total = 0;
		int req_total=0;
		//int req_inter_total=0;
		int tok_total=0;// token_total != nb_cs_total
		double msgPerCs = 0.0;
		double waitingTimeTotal = 0;
		double waitingTimeEcartType = 0;
		double rho = 0.0;
		long beta = Configuration.getLong("protocol.naimitrehel.timeBetweenCS");
		long alpha = Configuration.getLong("protocol.naimitrehel.timeCS");
		long gamma = Configuration.getLong("protocol.transport.mindelay");
		
		for(int i=0; i < Network.getCapacity() ; i++) {
			Node node = Network.get(i);
			NaimiTrehelAlgoInfo algo = (NaimiTrehelAlgoInfo)node.getProtocol(algoPid);
			////log.info("Node #"+node.getID()+" : "+algo.getNodeInfo());
			nb_cs_total += algo.getNbCs();
			req_total += algo.getReqCount();
			//req_inter_total += algo.getReqInterCount();
			tok_total += algo.getTokenCount();
			
			double[] temp = algo.getWaitingTime();
			waitingTimeTotal += temp[0];
			waitingTimeEcartType += temp[1];
			////log.info(node.getID()+": "+algo.getNodeInfo());
		}
		//log.info("M1-Messages info: \n\t-Request: "+req_total+"\n\t-Token: "+nb_cs_total);
		msgPerCs = ((double)(tok_total+req_total))/nb_cs_total;
		//log.info("M1-Nombre de messages par section critique (approximation avec les sommes): ("+(req_total+tok_total)+")/"+nb_cs_total+"= "+msgPerCs);
		
		
		//log.info("-Nombre de messages requetes et temps d'attente par noeud: ");
		for(int i=0; i < Network.getCapacity() ; i++) {
			Node node = Network.get(i);
			NaimiTrehelAlgoInfo algo = (NaimiTrehelAlgoInfo)node.getProtocol(algoPid);
			//log.info("\t-Node #"+node.getID()+" : RequestCount = "+algo.getReqCount()+", RequestInterCount = "+algo.getReqInterCount()+" , WaitingTime = "+algo.getWaitingTime());
		}
		
		//log.info("M2-Moyenne de Timewaiting par Cs: "+((double)waitingTimeTotal/Network.getCapacity()));
	
		//log.info("M3-Moyenne de requestCount: "+((double)req_total/Network.getCapacity()));
		
		//log.info("M4-"+NaimiTrehelAlgoInfo.getPerStateTimeInfo(nb_cs_total, tok_total, CommonState.getTime()));
		Double[] statePercentages = NaimiTrehelAlgoInfo.getPerStateTime(nb_cs_total, tok_total, CommonState.getTime());
		rho = ((double)(alpha+gamma))/beta;
		//log.info("Rho- "+rho);
		
		try {
			if(Configuration.getLong("random.seed") == 20) {
				msgPerCsWriter.append(beta+","+msgPerCs+"\n");
				waitingTimeWriter.append(beta+","+((double)waitingTimeTotal/Network.getCapacity())+","+(waitingTimeEcartType/Network.getCapacity())+"\n");
				reqCountWriter.append(beta+","+((double)req_total/Network.getCapacity())+"\n");
				statePercentagesWriter.append(beta+","+statePercentages[0]+","+statePercentages[1]+","+statePercentages[2]+"\n");
				msgPerCsWriter.flush();
				reqCountWriter.flush();
				waitingTimeWriter.flush();
				statePercentagesWriter.flush();
			}
			else {
				addInfoToLine(msgPerCsFile, beta, String.valueOf(msgPerCs));
				addInfoToLine(reqCountFile, beta, String.valueOf(((double)req_total/Network.getCapacity())));
				addInfoToLine(waitingTimeFile, beta, String.valueOf((double)waitingTimeTotal/Network.getCapacity())+","+String.valueOf(waitingTimeEcartType/Network.getCapacity()));
				addInfoToLine(statePercentagesFile, beta, statePercentages[0]+","+statePercentages[1]+","+statePercentages[2]);
			}
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
	
	private void addInfoToLine(File f, long beta, String info) throws IOException{
		BufferedReader filein = new BufferedReader(new FileReader(f));
		StringBuffer inputBuffer = new StringBuffer();
		String line;
		while((line = filein.readLine())!=null) {
			if(line.startsWith(String.valueOf(beta)+",")) { // ajouter la virgule pour ne pas confendre 20 et 200 ...
				line = line+","+info;
			}
			inputBuffer.append(line);
			inputBuffer.append("\n");
		}
		filein.close();
		
		FileWriter fileout = new FileWriter(f);
		fileout.write(inputBuffer.toString()); // write to replace
		fileout.close();
		
	}
}
