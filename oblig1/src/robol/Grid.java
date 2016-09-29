package robol;

/* <grid> ::= size(<number> <number>) */

class Grid {
	static int count = 0; 
	private int idNum;
	private int width;
	private int height;
	
	public Grid(int width, int height) {
		this.idNum = ++count;
		this.width = width;
		this.height = height;
	}
	
	public boolean isOutOfBound(int x, int y) {
		return x >= width || y >= height;
	}
	
	public String toString() {
		return "Grid " + idNum + " (" + width + "," + height + ")";
	}
}