interface RobolSyntax {
	void interpret();
}


class Program implements Robol {

}


class Grid {
	private int width;
	private int height;
	
	public Grid(int width, int height) {
		this.width = width;
		this.height = height;
	}
}


class Robot 