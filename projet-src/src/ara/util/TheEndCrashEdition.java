package ara.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

import ara.projet.checkpointing.CrashObserver;
import peersim.config.Configuration;
import peersim.core.Control;
import peersim.core.Network;
import peersim.core.Node;

public class TheEndCrashEdition implements Control{

	private long beta, checkpointFreq;

	private File recoveryTimeFile, msgCountFile, checkpointSizeFile, ageFile;
	private Writer recoveryTimeWriter, msgCountWriter, checkpointSizeWriter, ageWriter;
	private boolean fileCreated = false;

	public TheEndCrashEdition(String prefix) throws IOException{

		beta = Configuration.getLong("protocol.naimitrehel.timeBetweenCS");
		checkpointFreq = Configuration.getLong("protocol.juang.timecheckpointing");

		recoveryTimeFile = new File("./output_crash/recoveryTime"+checkpointFreq+".csv");
		msgCountFile = new File("./output_crash/msgCount"+checkpointFreq+".csv");
		checkpointSizeFile = new File("./output_crash/checkpointSize"+checkpointFreq+".csv");
		ageFile = new File("./output_crash/age"+checkpointFreq+".csv");

		fileCreated = recoveryTimeFile.createNewFile()&msgCountFile.createNewFile()&checkpointSizeFile.createNewFile()&ageFile.createNewFile();

		recoveryTimeWriter = new FileWriter(recoveryTimeFile, true);
		msgCountWriter = new FileWriter(msgCountFile, true);
		checkpointSizeWriter = new FileWriter(checkpointSizeFile, true);
		ageWriter = new FileWriter(ageFile, true);
	}

	@Override
	public boolean execute()
	{
		Double avgRecoveryTime, avgMsgCount, avgAge, maxAge = 0.0, avgRollback, maxRollback = 0.0, avgReplayedMsg, avgCheckpointSize ;
		long totalRecoveryTime = 0, totalMsgCount = 0, totalAge = 0, totalRollback = 0, totalReplayedMsg = 0, maxReplayedMsg = 0, totalCheckpointSize = 0, maxCheckpointSize = 0;
		//List<Double> avgCheckpointSizeList = new ArrayList<>();

		//System.out.println("The END: Crash Nbr = "+CrashObserver.current_crash+ "\n\t-Starting dates: "+CrashObserver.startingCrashDates+"\n\t-Ending Dates: "+CrashObserver.endingCrashDates+"\n\t-Messages per Crash: "+CrashObserver.msgCountPerCrash+"\n\t-Size of checkpoints before crash: "+CrashObserver.sizeOfCheckpointBeforeCrash+"\n\t-Age per crash: "+CrashObserver.agePerCrash+"\n\t-Rollback per crash:"+CrashObserver.rollbackPerCrash+"\n\t-Replayed messages per crash: "+CrashObserver.replayedMsgPerCrash);

		for(int key:CrashObserver.endingCrashDates.keySet()) {
			totalRecoveryTime+=CrashObserver.endingCrashDates.get(key)-CrashObserver.startingCrashDates.get(key);
			totalMsgCount+=CrashObserver.msgCountPerCrash.get(key);
			totalAge+=CrashObserver.agePerCrash.get(key);
			totalRollback+=CrashObserver.rollbackPerCrash.get(key);
			totalReplayedMsg+=CrashObserver.replayedMsgPerCrash.get(key);
			totalCheckpointSize+=CrashObserver.sizeOfCheckpointBeforeCrash.get(key);
			//avgCheckpointSizeList.add(((double)CrashObserver.sizeOfCheckpointBeforeCrash.get(key))/CrashObserver.sizeOfCheckpointStackBeforeCrash.get(key));
			if(maxAge < CrashObserver.agePerCrash.get(key))
				maxAge = CrashObserver.agePerCrash.get(key);
			if(maxRollback < CrashObserver.rollbackPerCrash.get(key))
				maxRollback = CrashObserver.rollbackPerCrash.get(key);
			if(maxReplayedMsg < CrashObserver.replayedMsgPerCrash.get(key))
				maxReplayedMsg = CrashObserver.replayedMsgPerCrash.get(key);
			if(maxCheckpointSize < CrashObserver.sizeOfCheckpointBeforeCrash.get(key))
				maxCheckpointSize = CrashObserver.sizeOfCheckpointBeforeCrash.get(key);

		}
		
		/*calculating size of all checkpoints
		for(int i=0; i<Network.getCapacity(); i++) {
			Node node = Network.get(i);
			JuangVenkatesanAlgo algo = (JuangVenkatesanAlgo)node.getProtocol(algoPid);
			
		}*/

		avgRecoveryTime = ((double)totalRecoveryTime)/(CrashObserver.current_crash);
		avgMsgCount = ((double)totalMsgCount)/(CrashObserver.current_crash);
		avgAge = ((double)totalAge)/(CrashObserver.current_crash);
		avgRollback = ((double)totalRollback)/(CrashObserver.current_crash);
		avgReplayedMsg = ((double)totalReplayedMsg)/(CrashObserver.current_crash);
		avgCheckpointSize = ((double)totalCheckpointSize)/(CrashObserver.current_crash);
		
		System.out.println("Average recovery time = "+avgRecoveryTime);
		System.out.println("Average message count = "+avgMsgCount);
		System.out.println("Average replayed message per crash = "+avgReplayedMsg);
		System.out.println("Average oldness(Global Counter) = "+avgAge+" -- Max oldness = "+maxAge);
		System.out.println("Average rollbacks = "+avgRollback+" -- Max rollbacks = "+maxRollback);
		System.out.println("Final chekpoints size = "+CrashObserver.sizeOfCheckpointBeforeCrash.get(CrashObserver.current_crash-1)+" bytes");
		System.out.println("Average checkpoint size per crash: "+avgCheckpointSize+" -- Max = "+maxCheckpointSize);
		
		
		try {
			if(Configuration.getLong("random.seed") == 20) {
				// beta, msgAppCount, metrique
				recoveryTimeWriter.append(beta+","+CrashObserver.msgAppCount+","+avgRecoveryTime+"\n");
				msgCountWriter.append(beta+","+CrashObserver.msgAppCount+","+avgMsgCount+"\n");
				checkpointSizeWriter.append(beta+","+CrashObserver.msgAppCount+","+avgCheckpointSize+"\n");
				// beta, msgAppCount, rollbackCount, globalCounterDiff, 
				//ageWriter.append(beta+","+CrashObserver.msgAppCount+","+avgRollback+","+avgAge+","+avgReplayedMsg+"\n");
				ageWriter.append(beta+","+CrashObserver.msgAppCount+","+avgAge+"\n");
			}
			else {
				addInfoToLine(recoveryTimeFile, beta, String.valueOf(CrashObserver.msgAppCount)+","+String.valueOf(avgRecoveryTime));
				addInfoToLine(msgCountFile, beta, String.valueOf(CrashObserver.msgAppCount)+","+String.valueOf(avgMsgCount));
				addInfoToLine(checkpointSizeFile, beta, String.valueOf(CrashObserver.msgAppCount)+","+String.valueOf(avgCheckpointSize));
				addInfoToLine(ageFile, beta, String.valueOf(CrashObserver.msgAppCount)+","+String.valueOf(avgAge));
			}
		} catch (IOException e) {
			System.err.println("Error in writing!!");
		} finally {
			try {
				recoveryTimeWriter.close();
				msgCountWriter.close();
				checkpointSizeWriter.close();
				ageWriter.close();
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
