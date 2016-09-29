package robol;

@SuppressWarnings("serial")
public class RobolError extends RuntimeException {
	public RobolError(String message) {
		super(message);
	}
}