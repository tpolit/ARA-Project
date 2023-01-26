package ara.util;

import java.io.Serializable;

/**
 * @author jonathan.lejeune@lip6.fr
 *
 */
public abstract class Message implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2042265531217034655L;
	private final long idsrc;
	private final long iddest;
	private final int pid;

	public long getIdSrc() {
		return idsrc;
	}

	public long getIdDest() {
		return iddest;
	}

	public int getPid() {
		return pid;
	}

	public Message(long idsrc, long iddest, int pid) {
		this.iddest = iddest;
		this.idsrc = idsrc;
		this.pid = pid;
	}
}
