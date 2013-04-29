class SeedsGame {
  protected String[] levels = new String[] {
  	"00101"+
	"01010"+
	"00000"+
	"00100"+
	"10010"+
	"010011",
	
	"10101"+
	"20102"+
	"20102"+
	"20102"+
	"20102"+
	"101011",
	
	"01310"+
	"31013"+
	"00000"+
	"11011"+
	"11011"+
	"011101",
	
	"02320"+
	"01010"+
	"02120"+
	"02120"+
	"11011"+
	"011101",
	
	"00001"+
	"23130"+
	"21104"+
	"21104"+
	"23130"+
	"000012",
	
	"01221"+
	"40010"+
	"01121"+
	"21230"+
	"10332"+
	"001033",
	
	"40011"+
	"33301"+
	"41200"+
	"22142"+
	"11002"+
	"002102",
	
	"04010"+
	"13220"+
	"11221"+
	"24200"+
	"10332"+
	"010122",
	
	"12110"+
	"12040"+
	"00122"+
	"10000"+
	"01000"+
	"000203",
	
	"00200"+
	"10101"+
	"02320"+
	"13131"+
	"21012"+
	"100012",
	
	"23402"+
	"02211"+
	"21433"+
	"02100"+
	"12100"+
	"004132",
	
	"00000"+
	"20102"+
	"22422"+
	"12021"+
	"10001"+
	"000003",
	
	"20000"+
	"02212"+
	"10201"+
	"20011"+
	"32030"+
	"000032",
	
	"21220"+
	"24012"+
	"02140"+
	"11034"+
	"22212"+
	"001012",
	
	"14041"+
	"42024"+
	"12021"+
	"01010"+
	"02020"+
	"000003",
        
        /**************************
         New Levels Added To Game
        **************************/
        
	"00000"+
        "00300"+
	"03230"+
	"03230"+
	"00300"+
	"000009",

	"10101"+
        "00100"+
	"23032"+
	"41114"+
	"10001"+
	"111112",

	"11111"+
        "22222"+
	"11111"+
	"22222"+
	"11111"+
	"222222",

	"11111"+
        "10001"+
	"12221"+
	"12221"+
	"10001"+
	"111111",

	"11111"+
        "11111"+
	"11111"+
	"11111"+
	"11111"+
	"111111"
  };
  protected int titleWidth = 100;
  protected float[] seeds = new float[160];
  protected boolean bRun = false;
  protected String s = "";
  protected float w;
  protected int[][] level = new int[6][5];
  protected float control_Horiz, control_Vert, mouse_released, level_num, touches, game_lost, game_won;
  
  protected int changeX = 90;
  protected int changeY = 80;
  
  SeedsGame() {}
  
  int[][] convertLevels() {
    String curLevel = levels[(int)level_num];
    level = new int[6][5];
    touches = Integer.valueOf(curLevel.substring(30,31));
    for (int y = 0; y < level.length; y++) {
      for (int x = 0; x < level[0].length; x++) {
        level[y][x] = Integer.valueOf(curLevel.substring(x + y * level[0].length,1 + x + y * level[0].length));
      }
    }
    return level;
  }
  
  void levelDesign() {
    if (level_num < 0) {
      level_num = levels.length - 1;
    }
    if (level_num >= levels.length) {
      level_num = 0;
    }
    bRun = false;
    game_lost = 0;
    game_won  = 0;
    convertLevels();

  }
  
  void mouseButtonActivity() {
    if (game_lost > 0) {
      if (game_won > 0) {
        level_num += 1;
      }
      level[0][0] = -1;
    }
    else if ((control_Horiz >= 0) && (control_Vert >= 0) && (control_Horiz < 70) && (control_Vert < 30)) {
      level[0][0] = -1;
    }
    else if ((control_Horiz >= 125) && (control_Vert >= 38) && (control_Horiz < 170) && (control_Vert < 70)) {
      level_num -= 1;
      level[0][0] = -1;
    }
    else if ((control_Horiz >= 310) && (control_Vert >= 38) && (control_Horiz < 355)&& (control_Vert < 70)) {
      level_num += 1;
      level[0][0] = -1;
    }
    else if ((control_Horiz >= changeX) && (control_Vert >= changeY) && (control_Horiz < changeX + 60 * level[0].length) && (control_Vert < changeY + 60 * level.length) && (!bRun)) {
      int x = (int)(control_Horiz - changeX) / 60;
      int y = (int)(control_Vert - changeY) / 60;
      if (level[y][x] > 0) {
        level[y][x] -= 1;
        touches -= 1;
        bRun = true;
        seeds = new float[160];
        if (level[y][x] <= 0) {
          for (int i = 0; i < 4; i++) {
            seeds[i*2] = x * 60 + 30;
            seeds[i*2 + 1] = y * 60 + 30;
          }
          seeds[1] -= 2f;
          seeds[2] += 2f;
          seeds[5] += 2f;
          seeds[6] -= 2f;
        }
      }
    }
    mouse_released = 0;
  }
  
  void gameWinChk(){
    boolean bWin = true;
    for (int lY = 0; lY < level.length; lY++) {
      for (int lX = 0; lX < level[0].length; lX++) {
        if (level[lY][lX] > 0) {
          bWin = false;
          break;
        }
      }
    }
    if ((bWin) && (!bRun)) {
      game_lost = 1;
      game_won = 1;
    }
  }
  
  void seedMovement() {
    for (int i = 0; i < seeds.length; i += 8) {
      int p = 0;
      while (p < 8) {
        int chooseX = -1, chooseY = -1;
        if ((p == 0) && (seeds[i] != 0) && (seeds[i + 1] != 0)) {
          seeds[i + 1] -= 2f;
          int newY = (int)((seeds[i+1] - 30) % 60);
          if (seeds[i+1] <= 0) {
            seeds[i] = seeds[i+1] = 0;
          }
          else if (0 == newY) {
            int oldY = (int)((seeds[i+1] - 30) / 60);
            int oldX = (int)((seeds[i] - 30) / 60);
            if (level[oldY][oldX] > 0) {
              chooseX = oldX;
              chooseY = oldY;
            }
          }
        }
        if ((p == 2) && (seeds[i+2] != 0) && (seeds[i + 3] != 0)) {
          seeds[i + 2] += 2f;
          int newX = (int)((seeds[i+2] - 30) % 60);
          if (seeds[i+2] >= level[0].length * 60) {
            seeds[i+2] = seeds[i+3] = 0;
          }
          else if (0 == newX) {
            int oldY = (int)((seeds[i+3] - 30) / 60);
            int oldX = (int)((seeds[i+2] - 30) / 60);
            if ((oldX < level[0].length) && (level[oldY][oldX] > 0)) {
              chooseX = oldX;
              chooseY = oldY;
            }
          }
        }
        if ((p == 4) && (seeds[i+4] != 0) && (seeds[i + 5] != 0)) {
          seeds[i + 5] += 2f;
          int newY = (int)((seeds[i+5] - 30) % 60);
          if (seeds[i+5] >= level.length * 60) {
            seeds[i+5] = seeds[i+4] = 0;
          }
          else if (0 == newY) {
            int oldY = (int)((seeds[i+5] - 30) / 60);
            int oldX = (int)((seeds[i+4] - 30) / 60);
            if (level[oldY][oldX] > 0) {
              chooseX = oldX;
              chooseY = oldY;
            }
          }
        }				
        if ((p == 6) && (seeds[i+6] != 0) && (seeds[i + 7] != 0)) {
          seeds[i + 6] -= 2f;
          int newX = (int)((seeds[i+6] - 30) % 60);
          if (seeds[i+6] <= 0) {
            seeds[i+6] = seeds[i+7] = 0;
          }
          else if (0 == newX) {
            int oldY = (int)((seeds[i+7] - 30) / 60);
            int oldX = (int)((seeds[i+6] - 30) / 60);
            if (level[oldY][oldX] > 0) {
              chooseX = oldX;
              chooseY = oldY;
            }
          }
        }
        if (chooseX >= 0) {
          level[chooseY][chooseX] -= 1;
          seeds[i + p] = 0;
          seeds[i + p + 1] = 0;
          if (level[chooseY][chooseX] <= 0) {
            for (int k = 0; k < seeds.length; k += 8) {
              if ((seeds[k] <= 0) && (seeds[k+2] <= 0) && (seeds[k+4] <= 0) && (seeds[k+6] <= 0)) {
                for (int m = 0; m < 4; m++) {
                  seeds[k + m*2] = chooseX * 60 + 30;
                  seeds[k + m*2 + 1] = chooseY * 60 + 30;
                }
                seeds[k + 1] -= 2f;
                seeds[k + 2] += 2f;
                seeds[k + 5] += 2f;
                seeds[k + 6] -= 2f;
                break;
              }
            }
          }
        }
        p += 2;
      }
      bRun = false;
      for (int k = 0; k < seeds.length; k += 2) {
        if (seeds[k] > 0) {
          bRun = true;
          break;
        }
      }
      if (!bRun) {
        if (touches <= 0) {
          game_lost = 1;
        }
      }
    }
  }
  
  
  public float getControlHoriz() {
    return control_Horiz;
  }

  public void setControlHoriz(float control_Horiz) {
    this.control_Horiz = control_Horiz;
  }

  public float getControlVert() {
    return control_Vert;
  }

  public void setControlVert(float control_Vert) {
    this.control_Vert = control_Vert;
  }

  public float getMouse_released() {
    return mouse_released;
  }

  public void setMouse_released(float mouse_released) {
    this.mouse_released = mouse_released;
  }

  public float getLevel_num() {
    return level_num;
  }

  public void setLevel_num(float level_num) {
    this.level_num = level_num;
  }

  public float getTouches() {
    return touches;
  }

  public void setTouches(float touches) {
    this.touches = touches;
  }

  public float getGame_lost() {
    return game_lost;
  }

  public void setGame_lost(float game_lost) {
    this.game_lost = game_lost;
  }

  public float getGame_won() {
    return game_won;
  }

  public void setGame_won(float game_won) {
    this.game_won = game_won;
  }
  
  public void setbRun(boolean bRun) {
    this.bRun = bRun;
  }
  
  public boolean getbRun() {
    return bRun;
  }
  
  public int getLevel(int a, int b) {
    return level[a][b];
  }
  
  public void setLevel(int a, int b, int c) {
    level[a][b] = c;
  }
}