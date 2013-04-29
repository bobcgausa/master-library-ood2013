public class aichess4k implements Runnable {

	private static final int EMPTY = 0;
	private static final int PAWN = 1;
	private static final int BISHOP = 2;
	private static final int KNIGHT = 3;
	private static final int ROOK = 4;
	private static final int QUEEN = 5;
	private static final int KING = 6;
	private static final int FIGURE = 15;

	private static final int BLACK = 16;
	private static final int WHITE = 32;
	private static final int COLOR = 32 + 16;

	private static final int MAX = 100000;

	private static final int KING_VALUE = 10000;
	// use magic to calculate the figure value, using:
	// (type == KING ? KING_VALUE : (MAGIC >> (4*type)) & 0xf)
	private static final int MAGIC = 0x953310;

	// board:
	// 0-7 board
	// 8 0-3 lastmove source x,y & dest x,y
	// 4 activeplayer 5 leftrookmoved 6 kingmoved 7 rightrookmoved
	// 9 0 movenum 1 movessincetake 2 check

	// ply:
	// 0-1 source position x,y
	// 2-3 dest position x,y
	// 4 target figure (only used for transformation moves)

	// current board
	private int[][] myboard;

	// my move including transformation target if pawn ends up on final row
	private int[] myply;

	// all previous board configurations
	private int[][][] undo;

	// ai result
	private int[] resply;

	// ai difficulty (modifies search depth)
	private int difficulty;

	public aichess4k() {
		init();
	}

	private void init() {
		myply = new int[5];
		myply[0] = -1;
		myply[4] = QUEEN;

		undo = new int[1000][][];
		myboard = new int[10][8];
		myboard[8][4] = WHITE;

		// White
		myboard[0][0] = WHITE | ROOK;
		myboard[1][0] = WHITE | KNIGHT;
		myboard[2][0] = WHITE | BISHOP;
		myboard[3][0] = WHITE | QUEEN;
		myboard[4][0] = WHITE | KING;
		myboard[5][0] = WHITE | BISHOP;
		myboard[6][0] = WHITE | KNIGHT;
		myboard[7][0] = WHITE | ROOK;
		for (int i = 0; i < 8; i++)
			myboard[i][1] = WHITE | PAWN;

		// Black
		for (int i = 0; i < 8; i++)
			myboard[i][6] = BLACK | PAWN;
		myboard[0][7] = BLACK | ROOK;
		myboard[1][7] = BLACK | KNIGHT;
		myboard[2][7] = BLACK | BISHOP;
		myboard[3][7] = BLACK | QUEEN;
		myboard[4][7] = BLACK | KING;
		myboard[5][7] = BLACK | BISHOP;
		myboard[6][7] = BLACK | KNIGHT;
		myboard[7][7] = BLACK | ROOK;

		myboard[8][2] = -1;
	}

	private boolean isCastleing(final int[][] board, final int sx, final int sy,
			final int dx, final int dy) {
		final int side = board[8][4];
		final int mustY = (side == WHITE) ? 0 : 7;
		final int rookX = (dx == 2) ? 0 : 7;

		if (sy != dy)
			return false;
		if (sy != mustY)
			return false;
		if (sx != 4)
			return false;
		if ((dx != 2) && (dx != 6))
			return false;

		// not strictly necessary to check
		// if the pieces are unmoved, they got to be the right ones
		// if ((board[4][sy] & FIGURE) != KING) return false;
		// if ((board[rookX][sy] & FIGURE) != ROOK) return false;

		// check if path is empty
		int min, max;
		min = dx - 1; // dx == 2 ? 1 : 5; EVIL HACK
		max = dx == 2 ? 3 : 6;
		for (int i = min; i <= max; i++) {
			if (board[i][sy] != EMPTY)
				return false;
		}

		// check if any of the king traversed fields is under attack
		min = dx == 2 ? 2 : 4;
		max = min + 2;
		for (int i = min; i <= max; i++) {
			for (int x = 0; x < 8; x++)
				for (int y = 0; y < 8; y++) {
					final int figure = board[x][y];
					if ((figure != EMPTY) && ((figure & COLOR) != side)) {
						if ((figure & FIGURE) == PAWN) {
							if (sy == y + (side == BLACK ? 1 : -1)) {
								if (Math.abs(x - i) == 1)
									return false;
							}
						} else {
							if (isNormal(board, x, y, i, sy))
								return false;
						}
					}
				}
		}

		// check if pieces have been moved
		if ((board[8][6] & side) != 0)
			return false;
		if ((board[8][dx == 2 ? 5 : 7] & side) != 0)
			return false;

		return true;
	}

	private boolean isEnPassant(int[][] board, int sx, int sy, int dx, int dy) {
		final int side = board[8][4];
		final int mustDir = side == WHITE ? 1 : -1;
		final int mustSY = side == WHITE ? 4 : 3;

		// check if current move fits
		if (sy != mustSY)
			return false;
		if (dy != sy + mustDir)
			return false;
		if (Math.abs(sx - dx) != 1)
			return false;

		// check if the previous move fits
		// if (lastSX != dx) return false;
		// if (lastSY != mustSY+2*mustDir) return false;
		// if (lastDX != dx) return false;
		// if (lastDY != mustSY) return false;
		if (board[8][0] != dx)
			return false;
		if (board[8][1] != dy + mustDir)
			return false;
		if (board[8][2] != dx)
			return false;
		if (board[8][3] != sy)
			return false;

		// check if the pieces are correct
		if ((board[sx][sy] & FIGURE) != PAWN)
			return false;
		if ((board[dx][sy] & FIGURE) != PAWN)
			return false;
		return true;
	}

	// all normal moves (not en-passant or castleing)
	// Does not check colors!
	private boolean isNormal(int[][] board, int sx, int sy, int dx, int dy) {
		final int f = board[sx][sy];
		final int g = board[dx][dy];

		// if no movement, it's not a move
		if ((dx == sx) && (dy == sy))
			return false;

		// if the field is empty, it's not a move
		if (f == EMPTY)
			return false;

		// special handling of pawns when they take a figure
		if ((g != EMPTY) && ((f & FIGURE) == PAWN)) {
			if (Math.abs(sx - dx) != 1)
				return false;
			if (dy != sy + ((f & COLOR) == WHITE ? 1 : -1))
				return false;
		} else {
			switch (f & FIGURE) {
			case PAWN:
				if (sx == dx) {
					if ((f & COLOR) == WHITE) {
						if (dy == sy + 1)
							break;
						if ((sy == 1) && (dy == 3))
							break;
					} else {
						if (dy == sy - 1)
							break;
						if ((sy == 6) && (dy == 4))
							break;
					}
				}
				return false;
			case ROOK:
				if ((sx == dx) || (sy == dy))
					break;
				return false;
			case KNIGHT:
				if ((Math.abs(sx - dx) == 1) && (Math.abs(sy - dy) == 2))
					return true;
				if ((Math.abs(sx - dx) == 2) && (Math.abs(sy - dy) == 1))
					return true;
				return false;
			case BISHOP:
				if (sx - sy == dx - dy)
					break;
				if (sx + sy == dx + dy)
					break;
				return false;
			case QUEEN:
				if (sx - sy == dx - dy)
					break;
				if (sx + sy == dx + dy)
					break;
				if ((sx == dx) || (sy == dy))
					break;
				return false;
			case KING:
				if ((Math.abs(sx - dx) <= 1) && (Math.abs(sy - dy) <= 1))
					break;
				return false;
			}
		}

		// check if path is empty
		// knight already returned earlier
		while ((sx != dx) || (sy != dy)) {
			if (sx < dx)
				sx++;
			if (sx > dx)
				sx--;
			if (sy < dy)
				sy++;
			if (sy > dy)
				sy--;
			if (((sx != dx) || (sy != dy)) && (board[sx][sy] != EMPTY))
				return false;
		}
		return true;
	}

	private void copy(int[][] from, int[][] to) {
		for (int i = 0; i < 10; i++)
			for (int j = 0; j < 8; j++)
				to[i][j] = from[i][j];
	}

	private boolean move(int[][] board, int[] ply) {
		final int sx = ply[0];
		final int sy = ply[1];
		final int dx = ply[2];
		final int dy = ply[3];
		final int side = board[8][4];

		//System.out.println("MOVE "+sx+","+sy+" -> "+dx+","+dy);

		final int f = board[sx][sy];
		if ((f & COLOR) != side)
			return false;
		if ((board[dx][dy] & COLOR) == side)
			return false;

		// make a copy for the undo history
		final int move = board[9][0];
		undo[move] = new int[10][8];
		copy(board, undo[move]);

		if (isCastleing(board, sx, sy, dx, dy)) {
			final int rookSrcX = (dx == 2) ? 0 : 7;
			// final int rookDestX = (dx == 2) ? 3 : 5;
			final int g = board[rookSrcX][sy];

			// Modify Board
			board[rookSrcX][sy] = 0;
			board[sx][sy] = 0;
			board[dx][sy] = f;
			board[(dx == 2) ? 3 : 5][sy] = g;
			// set king moved flag
			// board[8][6] |= side;
		} else if (isEnPassant(board, sx, sy, dx, dy)) {
			board[sx][sy] = EMPTY;
			board[dx][dy] = f;
			board[dx][sy] = EMPTY;
			board[9][1] = 0;
		} else if (isNormal(board, sx, sy, dx, dy)) {
			if (board[dx][dy] != EMPTY)
				board[9][1] = 0;
			board[sx][sy] = EMPTY;
			board[dx][dy] = f;
			if ((f & FIGURE) == PAWN) {
				if ((dy == 0) || (dy == 7))
					board[dx][dy] = ply[4] | side;
			}
			if ((f & FIGURE) == KING)
				board[8][6] |= side;
			if ((f & FIGURE) == ROOK) {
				if (((sx == 0) || (sx == 7)) && ((sy == 0) || (sy == 7)))
					board[8][sx == 0 ? 5 : 7] |= sy == 0 ? WHITE : BLACK;
			}
		} else // none of the above
		{
			// board wasn't modified, so no need to undo
			return false;
		}

		board[8][0] = sx;
		board[8][1] = sy;
		board[8][2] = dx;
		board[8][3] = dy;
		board[8][4] = COLOR - side;
		board[9][0]++;
		board[9][1]++;

		// check for check
		int inCheck = 0;
		for (int x = 0; x < 8; x++)
			for (int y = 0; y < 8; y++) {
				if (board[x][y] != EMPTY) {
					for (int tx = 0; tx < 8; tx++)
						for (int ty = 0; ty < 8; ty++) {
							int g = board[tx][ty];
							if (((g & FIGURE) == KING)
									&& ((g & COLOR) != (board[x][y] & COLOR))) {
								if (isNormal(board, x, y, tx, ty))
									inCheck |= g & COLOR;
							}
						}
				}
			}
		board[9][2] = inCheck;

		// if current player is in check, move is invalid
		if ((inCheck & side) != 0) {
			// undo changes to board
			copy(undo[move], board);
			return false;
		}

		return true;
	}

	// ai search, also used for checkmate detection
	// uses alpha-beta-search
	// the return value is the value of the best possible move
	// the move is actually returned in the field resply
	private int search(int[][] board, final int steps, final int maxsteps, int alpha,
			int beta) {
		resply = null;

		// draw after 50 non-taking moves
		if (board[9][1] > 50)
			return 0;

		// draw after three back-and-forth moves
		final int move = board[9][0];
		if (move > 15) {
			boolean argh = true;
			for (int i = 0; argh & (i < 8); i++) {
				final int b0 = move - 1 - i;
				final int b1 = b0 - 4;
				for (int x = 0; x < 8; x++)
					for (int y = 0; y < 8; y++)
						if (undo[b0][x][y] != undo[b1][x][y])
							argh = false;
			}
			if (argh)
				return 0;
		}

		final int side = board[8][4];

		// evaluate board if search depth is reached
		if (steps <= 0) {
			int whiteValue = 0;
			for (int dx = 0; dx < 8; dx++)
				for (int dy = 0; dy < 8; dy++) {
					// add value of piece found at dx,dy
					if (board[dx][dy] != EMPTY) {
						int figure = board[dx][dy];
						int type = figure & FIGURE;
						int value = 40 * (type == KING ? KING_VALUE
								: (MAGIC >> (4 * type)) & 0xf);
						if ((figure & COLOR) == WHITE)
							whiteValue += value;
						else
							whiteValue -= value;
					}

					// calculate superiority at dx,dy by finding
					// all pieces that can attack dx,dy
					float sup = 0;
					for (int x = 0; x < 8; x++)
						for (int y = 0; y < 8; y++) {
							int figure = board[x][y];
							if (figure != EMPTY) {
								int type = figure & FIGURE;
								int color = figure & COLOR;
								float attack = 1.0f / (type == KING ? KING_VALUE
										: (MAGIC >> (4 * type)) & 0xf);
								if (color == BLACK)
									attack = -attack;
								if (type == PAWN) {
									if (dy == y + (color == WHITE ? 1 : -1)) {
										if (Math.abs(x - dx) == 1)
											sup += attack;
									}
								} else {
									if (isNormal(board, x, y, dx, dy))
										sup += attack;
								}
							}
						}

					// calculate value of field (dx,dy)
					int value;
					if (dx < dy)
						value = dx - dy;
					else
						value = dy - dx;
					if (dx < 7 - dy)
						value += dx + dy;
					else
						value += 14 - (dx + dy);

					// depending on the superiority, distribute the field's
					// value
					if (sup != 0) {
						if (sup > 0)
							whiteValue += value;
						else
							whiteValue -= value;
					}
				}

			return side == WHITE ? whiteValue : -whiteValue;
		}

		int[] bestply = null;
		int[][] save = new int[10][8];

		for (int x = 0; x < 8; x++)
			for (int y = 0; y < 8; y++) {
				int figure = board[x][y];
				int type = figure & FIGURE;
				if ((figure & COLOR) == side) {
					for (int dx = 0; dx < 8; dx++) {
						for (int dy = 0; dy < 8; dy++) {
							if (((board[dx][dy] & COLOR) != side)
									&& (isEnPassant(board, x, y, dx, dy)
											|| isCastleing(board, x, y, dx, dy) || isNormal(
												board, x, y, dx, dy))) {
								// System.out.println("CONSIDERING: "+x+" "+y+" -> "+dx+" "+dy);
								int newsteps = steps;
								if ((board[dx][dy] != EMPTY)
										&& (steps < maxsteps))
									newsteps++;

								int min = QUEEN;
								if ((type == PAWN) && ((dy == 0) || (dy == 7)))
									min = BISHOP;
								for (int k = min; k <= QUEEN; k++) {
									int[] p = new int[] { x, y, dx, dy, k };
									copy(board, save);
									if (move(save, p)) {
										int val = -search(save, newsteps - 1,
												maxsteps - 1, -beta, -alpha);
										if (val >= beta)
											return beta;
										if (val > alpha) {
											alpha = val;
											bestply = p;
										}
									}
								}
							}
						}
					}
				}
			}

		// resply must be set here
		resply = bestply;

		// if no move was found at all, the current side has lost
		return bestply == null ? -KING_VALUE : alpha;
	}

	public void run() {
		// for (int level = 0; level < 3; level++)
		// System.out.println(((level+4)/2)+" "+(4*level+2));

		// maximum depth, and maximum extended depth
		// the ai may increase the search depth if a piece is taken,
		// but only up to the maximum extended depth
		search(myboard, (difficulty + 4) / 2, 4 * difficulty + 2, -MAX, MAX);
		if (resply != null) {
			move(myboard, resply);
			// check if player can make any move at all
			search(myboard, 1, 0, -MAX, MAX);
		}

		// if either computer or player can't make a move
		if (resply == null) {
			if (myboard[9][2] == 0)
				myboard[8][4] = 0; // draw
			else
				// check-mate
				myboard[8][4] = -myboard[8][4];
		}
	}
	
	public void movePiece(char sx, int sy, char dx, int dy){
		myply[0]=transCord(sx);
		myply[1]=sy-1;
		myply[2]=transCord(dx);
		myply[3]=dy-1;
		if (move(myboard, myply)) {
			myply[0]=-1;
			new Thread(this).start();
		}
	}
	
	private int transCord(char a){
		switch (a){
		case 'a': return 0;
		case 'b': return 1;
		case 'c': return 2;
		case 'd': return 3;
		case 'e': return 4;
		case 'f': return 5;
		case 'g': return 6;
		case 'h': return 7;
		default: return -1;
		}
	}
	
	public void setDifficulty(int d){
		difficulty=d;
	}
	
	public int getDifficulty(){
		return difficulty;
	}
	
	public void undo(){
		int move = myboard[9][0];
		if (move > 0) {
			move = (move - 1) & ~1;
			copy(undo[move], myboard);
		}
	}
	
	public void restart(){
		init();
	}
	
	public void setTransformation(int a){
		myply[4] = a;
	}
	
	public int getTransformation(){
		return myply[4];
	}
	
	public int[][] getBoard(){
		int[][] a= new int[8][8];
		for(int i=0; i<8; i++)
			for(int k=0; k<8; k++)
				a[i][k]=myboard[i][k];
		return a;
	}
	
	public String toString(){
		String out="";
		for(int i=0; i<8; i++){
			for(int k=0; k<8; k++){
				out=out+" "+myboard[i][k];
			}
			out=out+"\n";
		}
		return out;
	}
}
