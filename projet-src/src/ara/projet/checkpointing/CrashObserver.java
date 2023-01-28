package ara.projet.checkpointing;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.HashMap;
import java.util.Map;

import ara.projet.checkpointing.NodeState;
import ara.projet.mutex.NaimiTrehelAlgoCheckpointable;
import peersim.core.CommonState;
import peersim.core.Network;

public class CrashObserver extends NaimiTrehelAlgoCheckpointable{

	// calcul du temps necessaire
	public static Map<Integer, Long> startingCrashDates = new HashMap<>();
	public static Map<Integer, Long> endingCrashDates = new HashMap<>();
	
	// calcul du nombre de messages
	public static Map<Integer, Integer> msgCountPerCrash = new HashMap<>();
	public static long msgAppCount = 0;
	
	// affiner l'age avec d'autre metrique, comme le nombre de message rejoué ...etc
	public static Map<Integer, Double> rollbackPerCrash = new HashMap<>();
	public static Map<Integer, Double> agePerCrash = new HashMap<>();
	public static Map<Long, Integer> initialCheckpointForNode = new HashMap<>();
	public static Map<Long, Integer> lastCheckpointForNode = new HashMap<>();
	public static Map<Long, Integer> initialGlobalCounterForNode = new HashMap<>();
	public static Map<Long, Integer> lastGlobalCounterForNode = new HashMap<>();
	public static Map<Integer, Integer> replayedMsgPerCrash = new HashMap<>();
	
	
	// Map(id_crash, size of all checkpoints of all nodes)
	public static Map<Integer, Integer> sizeOfCheckpointBeforeCrash = new HashMap<>();
	//public static Map<Integer, Integer> sizeOfCheckpointStackBeforeCrash = new HashMap<>();
	
	public static int current_crash = 0;
	public static int node_recovered = 0;
	
	
	public CrashObserver(String prefix) {
		super(prefix);
	}
	
	@Override
	public void suspend() {
		// init des msgCount
		msgCountPerCrash.put(current_crash, 0);
		// calcul du temps
		if(!startingCrashDates.containsKey(current_crash)) {
			node_recovered = 0; // first node to suspend
			startingCrashDates.put(current_crash,CommonState.getTime());
		}
		else {
			if(CommonState.getTime()<startingCrashDates.get(current_crash))
				startingCrashDates.put(current_crash, CommonState.getTime());
		}
		super.suspend();
	}
	
	@Override
	public void restoreState(NodeState restore_state) {
		
		// calcul du temps
		node_recovered++;
		if(!endingCrashDates.containsKey(current_crash))
			endingCrashDates.put(current_crash,CommonState.getTime());
		else {
			if(CommonState.getTime()>endingCrashDates.get(current_crash))
				endingCrashDates.put(current_crash, CommonState.getTime());
		}
		if(node_recovered==Network.size()) {
			// calculating average oldness of recovering point
			int totalCheckpointDiff = 0, totalGlobalCounterDiff = 0;
			//System.out.println(initialGlobalCounterForNode+"\n"+lastGlobalCounterForNode+"\n");
			for(long key:initialCheckpointForNode.keySet()) {
				totalCheckpointDiff+=initialCheckpointForNode.get(key)-lastCheckpointForNode.get(key);
				totalGlobalCounterDiff+=initialGlobalCounterForNode.get(key)-lastGlobalCounterForNode.get(key);
			}
			rollbackPerCrash.put(current_crash, ((double)totalCheckpointDiff));//Network.size());
			agePerCrash.put(current_crash, ((double)totalGlobalCounterDiff));//Network.size());
			current_crash++; // last node recorevered
		}
		
		super.restoreState(restore_state);
	}
	
	// Méthodes Utilitaires
	public static byte[] objectToByte(Object o)
	{
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try(ObjectOutputStream out = new ObjectOutputStream(baos)) {
			out.writeObject(o);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Error with object: "+o.getClass());
		}
		
		return baos.toByteArray();
	}
	
}
