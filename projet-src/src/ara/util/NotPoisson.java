package ara.util;

import peersim.core.CommonState;

public class NotPoisson {

	private static long interval;
	public static long nextNotPoisson(long mean) {
		interval = (long) 0.3*mean; // interval entre min et max
		long toret = (interval<=1)?mean-interval:mean-interval + CommonState.r.nextLong(interval-1);
		return toret;
	}
}
