/*
 * Copyright (c) 2005-2012 Dirk Aporius <dirk.aporius@gmail.com>
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */



	
	/**
	 * level besteht aus
	 * 1 = x-Wert Uhr
	 * 2 = y-Wert Uhr
	 * 3 = Radius
	 * 4 = startangle
	 * 5 = rotationsgeschwindigkeit
	 * 6 = sichtbar = default is 0
	 * 7 = Startgrad = default is -1
	 * 8 = curTime = default is 0
	 * und dann eine neue Uhr ;)
	 */
  String[] levelsString = new String[] {
			"90, 262, 50, -50, 15, 250, 100, 50, 270, 10, 410, 262, 50, -230, 15, 250, 405, 50, 90, 10",
			"130, 230, 25, -50, 10, 130, 285, 25, 75, 12, 185, 230, 25, 129, 9, 155, 400, 50, -345, 11, 310, 255, 50, 64, 12, 335, 375, 25, 65, 7, 335, 430, 25, -302, 8, 280, 430, 25, 260, 9",
			"296,114,40,-50,8,186,438,40,140,8,200,200,30,210,10,200,347,30,320,7,290,347,30,-270,10,290,200,30,-270,7,200,272,30,0,11,290,272,30,90,10",
			"250, 260, 50, 67, 15, 170, 235, 20, -270, 12, 170, 285, 20, 130, 10, 215, 185, 20, 310, 5, 275, 185, 20, -245, 8, 325, 235, 20, 169, 7, 325, 285, 20, 237, 11, 215, 335, 20, -349, 7, 275, 335, 20, 198, 9",
			"169,155,40,180,7,337,158,40,179,7,253,262,30,-345,9,157,360,35,-182,13,247,428,35,-357,10,337,360,36,354,12",
			"100,258,40,-224,8,182,355,40,193,11,133,93,50,-76,11,337,165,60,60,6,384,347,50,-245,11,39,365,30,-191,6",
			"100,454,40,-5,12,100,351,40,-142,10,100,246,40,339,7,159,138,40,-164,10,250,71,40,130,11,332,138,40,142,9,393,246,40,41,8,393,351,40,249,13,393,455,40,-11,8,251,351,60,-229,7",
//			"150, 260, 20, 123, 8, 150, 315, 20, -275, 7, 205, 205, 20, -354, 6, 205, 260, 20, -15, 9, 205, 315, 20, 10, 8, 205, 370, 20, 219, 7, 260, 205, 20, 123, 5, 260, 260, 20, -310, 6, 260, 315, 20, 20, 9, 260, 370, 20, 270, 8, 315, 260, 20, 195, 5, 315, 315, 20, 54, 7",
			"90, 262, 40, 120, 10,400, 100, 30, 160, 12, 410, 400, 20, 320, 8",
			"95,260,20,-53,8,95,320,20,244,4,399,260,20,-259,6,399,320,20,350,6,210,150,20,-40,9,280,150,20,-121,11,210,430,20,-65,13,280,430,20,19,11",
			"121,179,30,-46,4,78,244,30,38,4,63,319,30,207,4,146,319,30,145,13,226,319,30,-125,6,226,243,30,-348,13,226,396,30,135,6,226,470,30,-79,6,302,319,30,-26,10,172,117,30,-209,6",
			"240, 262, 20, 256, 10, 25, 50, 20, 121, 6, 30, 100, 25, 15, 9, 85, 55, 25, -312, 10, 435, 525, 20, 301, 7, 430, 475, 25, 15, 9, 375, 520, 25, -312, 10",
			"95,100,40,270,7,183,195,40,-130,10,280,284,40,-310,6,370,373,40,90,8,100,195,20,-48,8,183,100,20,-140,9,185,289,20,-180,7,282,369,20,17,4,371,273,20,-140,9,294,182,20,280,7",
//			"60,239,30,204,13,61,329,30,72,5,119,435,30,64,12,220,439,30,-308,13,320,440,30,-319,12,404,335,30,169,8,399,242,30,7,5,320,136,30,-348,7,221,136,30,-263,11,119,136,30,243,4,145,289,20,-164,5,232,215,20,-206,4,315,298,20,218,5,233,365,20,-273,7,232,286,12,214,10",
			"241,463,20,117,7,289,410,20,159,6,329,353,20,82,4,363,297,20,124,7,398,243,20,246,5,438,196,20,-142,9,192,413,20,199,8,153,357,20,-124,5",
			"86,261,35,-124,4,86,345,35,96,9,422,345,35,-17,12,422,261,35,247,6,196,95,35,58,10,298,95,35,-137,12,196,504,35,-274,7,298,504,35,-295,11,200,419,18,336,4,332,344,18,166,11,302,173,18,178,11,179,259,18,45,13",
//			"90,100,40,192,11,420,100,40,-112,8,90,500,40,-260,6,420,500,40,-341,7,180,260,20,141,10,180,310,20,-198,8,240,206,20,191,4,290,205,20,273,9,240,370,20,178,11,291,370,20,-123,13,344,260,20,-134,8,344,310,20,-41,5",
			"89,265,60,168,13,151,380,55,-43,12,235,468,50,273,7,341,416,45,-120,12,403,334,40,352,7,405,241,35,323,7,363,166,30,30,4,300,115,25,-254,4,236,102,20,267,5,180,121,15,-146,9,145,156,12,-252,9",
//			"254,435,30,-222,11,170,434,30,207,8,333,435,30,-179,11,170,151,30,56,9,254,151,30,-230,7,333,151,30,123,8,106,263,20,-338,8,155,263,20,-323,13,106,313,20,-203,4,156,313,20,349,6,345,263,20,-278,11,345,313,20,51,9,399,263,20,-36,9,399,313,20,157,9,215,526,35,47,8,299,526,35,304,13,206,75,35,-171,10,300,75,35,-227,4",
//			"80,250,30,357,6,80,330,30,144,11,170,422,30,-243,5,250,422,30,-53,12,170,154,30,350,13,250,154,30,284,8,346,250,30,128,4,346,330,30,-122,6,114,98,20,-16,10,174,62,20,85,6,235,62,20,-244,13,292,98,20,272,9,109,477,20,-50,11,174,523,20,-177,10,235,523,20,-243,10,293,481,20,-270,12",
			"240,94,20,-356,6,240,165,30,184,12,240,354,30,-178,9,240,430,20,232,7,332,260,30,165,4,405,260,20,-152,6,150,260,30,-335,4,82,260,20,170,9,240,260,40,-162,3",
//			"254,85,40,72,5,148,86,40,-157,9,145,183,40,-292,6,53,182,40,-92,11,59,280,40,23,10,418,336,40,58,4,419,432,40,268,6,328,432,40,244,9,329,525,40,-82,10,238,525,40,-45,10,71,472,25,-242,9,131,417,25,95,8,194,357,25,214,10,403,135,25,341,10,354,194,25,33,7,300,246,25,-10,7,246,305,25,36,13",
//			"349,164,30,-227,11,280,105,30,-128,10,198,78,30,33,7,119,105,30,-19,10,60,161,30,-223,5,55,237,30,326,4,122,290,30,-80,9,203,321,30,223,4,288,348,30,-282,10,341,413,30,-228,4,306,486,30,-243,4,229,516,30,293,13,150,513,30,107,8,79,481,30,339,5",
			"114,127,33,-215,5,115,213,23,104,11,116,316,46,262,9,213,69,31,136,12,204,422,39,215,5,325,402,40,-209,10,369,309,27,267,11,336,112,55,227,4,368,224,22,-135,4,240,260,36,269,4",
//			"50, 130, 30, -123, 10, 120, 130, 30, 234, 8, 190, 200, 30, -310, 9, 120, 270, 30, 310, 7, 190, 340, 30, 10, 8, 120, 410, 30, -219, 9, 50, 410, 30, 141, 8, 370, 130, 30, 265, 7, 300, 200, 30, -345, 8, 440, 200, 30, -50, 5, 300, 270, 30, 123, 6, 440, 270, 30, 321, 7, 300, 340, 30, -298, 9, 440, 340, 30, 245, 8, 370, 410, 30, -300, 4",
			"94,261,20,253,8,136,123,20,71,11,308,123,20,-40,13,136,453,20,37,8,308,453,20,-76,9,376,308,20,-213,7",
			"90, 262, 50, 90, 9, 245, 150, 12, 210, 5, 400, 262, 50, -270, 8, 245, 380, 12, -170, 11",
//			"151,78,35,-309,8,236,64,20,-228,9,220,121,20,-190,8,153,148,20,-216,8,321,249,40,-320,10,216,356,40,107,10,368,539,35,39,7,368,463,20,-32,9,308,488,20,-315,7,288,550,20,-329,13,202,247,20,191,8,329,360,20,210,11,267,304,20,239,12",
//			"93,154,20,28,11,49,203,20,266,5,41,264,20,109,6,57,321,20,142,13,101,373,20,17,7,145,154,20,153,11,145,208,20,335,8,145,267,20,-164,12,147,325,20,-163,10,148,373,20,-173,9,194,374,20,-33,6,457,168,20,5,7,431,212,20,3,10,387,267,20,163,7,387,212,20,142,6,387,162,20,-256,4,387,324,20,-248,13,387,374,20,-282,5,460,374,20,-17,12,432,324,20,12,13,341,162,20,26,6,314,213,20,-215,7,296,267,20,10,13,314,323,20,-109,4,341,374,20,-140,4,269,213,20,-14,12,254,163,20,-86,13,213,197,20,107,13,251,374,20,-204,10,208,262,20,-78,6,221,324,20,99,9,272,322,20,-201,11",
			"80, 135, 15, 123, 4, 80, 180, 15, -215, 6, 80, 225, 15, 50, 7, 80, 270, 15, -310, 3, 125, 110, 15, 256, 5, 175, 135, 15, -295, 4, 175, 180, 15, 65, 7, 175, 225, 15, -140, 8, 175, 270, 15, 250, 9, 125, 210, 15, -345, 3, 235, 110, 15, 123, 4, 235, 155, 15, -123, 5, 235, 200, 15, -45, 3, 235, 245, 15, 198, 6, 270, 110, 15, 345, 4, 270, 200, 15, -270, 5, 305, 155, 15, -156, 3, 365, 155, 15, 265, 3, 365, 200, 15, -189, 4, 400, 110, 15, -54, 7, 400, 245, 15, 320, 3, 435, 155, 15, -305, 3, 435, 200, 15, 145, 5",
//			{100, 260, 17, 245, 7, /**/115, 215, 17, 310, 8, /**/145, 170, 17, 123, 6, /**/180, 140, 17, 154, 6}
	};
	
	color C = color(255, 120, 120);
	
	/**
	 * p[0] == Maus losgelassen
	 * p[1] == aktuelles Level
	 * p[2] == Spiel gestartet
	 * p[3] == Level geschafft Klick
	 * p[4] == Maus X-Wert
	 * p[5] == Maus Y-Wert
	 * 
	 */
	private final int[] p = new int[6];
	long lastTime = System.nanoTime();
        long think = 10000000L;
        int[] level = new int[1];
        float[] ball = new float[5];
        
        void setup(){
          
        size(480,600);
        level[0] = -1;
        }

	
	public void draw() {
			
		
			long now = System.nanoTime();
			long delta = now - lastTime;
			think += delta;
			
			// Update / think
			// Wenn 10 ms vergangen sind, dann denke nach
			while (think >= 10000000L) {
				think -= 10000000L;
				
				if (level[0] == -1) {
					if (p[1] < 0) {
						p[1] = levelsString.length - 1;
					}
					if (p[1] >= levelsString.length) {
						p[1] = 0;
					}
					String[] l = levelsString[p[1]].split(",");
					
					level = new int[l.length/5*9];
					for (int y = 0; y < l.length; y += 5) {
						for (int i = 0; i < 5; i++) {
							level[y/5*9 + i] = Math.abs(Integer.valueOf(l[y + i].replaceAll(" ", "")));
						}
						level[y/5*9 + 6] = -1;
						level[y/5*9 + 8] = 1;
						if (Integer.valueOf(l[y + 3].replaceAll(" ", "")) < 0) {
							level[y/5*9 + 8] = -1;	
						}
					}
					ball = new float[5];
					ball[0] = 5;
					ball[1] = 260;
					ball[2] = 90;
					ball[3] = 0.2f;
					
					p[0] = 0;
					p[3] = 0;
					p[2] = 0;
				} else {
					if (p[0] > 0) {
						if ((p[4] > 70) && (p[4] < 130) &&
							(p[5] > 560) && (p[5] < 600)) {
							p[1] -= 1;
							level[0] = -1;
						} else if ((p[4] > 370) && (p[4] < 430) &&
								(p[5] > 560) && (p[5] < 600)) {
							p[1] += 1;
							level[0] = -1;
						} else if (p[3] > 0) {
							level[0] = -1;
							if (p[3] == 1) {
								p[1] += 1;
							}
						} else if (p[2] <= 0) {
							p[2] = 1;
						} else {
							for (int i = 0; i < level.length; i+=9) {
								if ((level[i+6] >= 0) && (level[i+5] <= 0)) {
									ball[4] = 0;
									level[i+5] = 1;
									ball[2] = level[i+3];
									ball[0] = level[i] + (int)((level[i+2]) * Math.sin(Math.toRadians(level[i+3])));
									ball[1] = level[i+1] - (int)((level[i+2]) * Math.cos(Math.toRadians(level[i+3])));
									break;
								}
							}
						}
					}
					if ((p[2] > 0) && (p[3] <= 0)) {
						for (int i = 0; i < level.length; i+=9) {
							if (level[i+5] <= 0) {
								level[i+7] += 10;
								while (level[i+7] >= level[i+4]) {
									level[i+3] += level[i+8] * 1;
									if (level[i+3] >= 360) {
										level[i+3] -= 360;
									}
									if (level[i+3] < 0) {
										level[i+3] += 360;
									}
									level[i+7] -= level[i+4];
									if ((level[i+6] >= 0) && (level[i+3] == level[i+6])) {
										p[3] = 2;
										break;
									}
								}
							}
						}
						if (ball[4] >= 0) {
							ball[0] += (ball[3] * 10) * Math.sin(Math.toRadians(ball[2]));
							ball[1] += (-ball[3] * 10) * Math.cos(Math.toRadians(ball[2]));
							
							if ((ball[0] < 0) || (ball[0] > 500)) {
								p[3] = 2;
							}
							if ((ball[1] < 25) || (ball[1] > 550)) {
								p[3] = 2;
							}
							
							for (int i = 0; i < level.length; i+=9) {
								if (level[i+5] <= 0) {
									float newX = (level[i] - ball[0]) * (level[i] - ball[0]);
									float newY = (level[i+1] - ball[1]) * (level[i+1] - ball[1]);
									float radius = (level[i+2] + 5) * (level[i+2] + 5);
									if (newX + newY <= radius) {
										ball[4] = -1;
										level[i+6] = level[i+3];
										break;
									}
								}
							}
						}
						boolean bBreak = true;
						for (int i = 0; i < level.length; i+=9) {
							if ((level[i+5] <= 0) && (level[i+6] < 0)) {
								bBreak = false;
								break;
							}
						}
						if (bBreak) {
							p[3] = 1;
						}
					}
				}
				
				p[0] = 0;
			}

			lastTime = now;
			
			fill(100,95,96);
			rect(0, 25, 500, 530);

			
			for (int i = 0; i < level.length; i+=9) {
				if (level[i+5] <= 0) {
					stroke(1);
					
					if (level[i+6] >= 0) {
						fill(255,255,255);
						ellipse(level[i] - level[i+2], level[i + 1] - level[i+2], level[i+2] * 2, level[i+2] * 2);
						
						int startAngle = level[i+6] - 90;
						if (startAngle < 0) {
							startAngle += 360;                                                      
						}
						   // fill(C);   
						int dif = level[i+6] - level[i+3];
                                                
						if (level[i+6] > level[i+3]) {
                                                        
							dif = dif - 360;
                                                             
                                                        
						}
						if (level[i+8] < 0) {
							dif = level[i+3] - level[i+6];
							if (level[i+6] < level[i+3]) {
								dif = dif - 360;
                                                                
                                                            
							}
							dif = -dif;                                                       
                                                        
						}
                                               
						arc(level[i] - level[i+2], level[i + 1] - level[i+2], level[i+2] * 2, level[i+2] * 2, -startAngle, dif);

					} else {
						fill(144,138,139);
						ellipse(level[i] - level[i+2], level[i + 1] - level[i+2], level[i+2] * 2, level[i+2] * 2);
					}
					
					
					ellipse(level[i] - level[i+2], level[i + 1] - level[i+2], level[i+2] * 2, level[i+2] * 2);
                                         fill(0);
					for (int j = 0; j < 12; j++) {
						line(level[i] + (int)((level[i+2] - 5) * Math.sin(Math.toRadians(j * 30))), level[i + 1] + (int)(-(level[i+2] - 5) * Math.cos(Math.toRadians(j * 30))), level[i] + (int)((level[i+2]) * Math.sin(Math.toRadians(j * 30))), level[i + 1] + (int)(-(level[i+2]) * Math.cos(Math.toRadians(j * 30))));
					}
					
					stroke(5);
					line(level[i], level[i + 1], level[i] + (int)((level[i+2] - 5) * Math.sin(Math.toRadians(level[i+3]))), level[i + 1] + (int)(-(level[i+2] - 5) * Math.cos(Math.toRadians(level[i+3]))));
				}
			}
			strokeWeight(3);
			if (ball[4] >= 0) {
				fill(C);
				ellipse((int)(ball[0] - 2), (int)(ball[1] - 2), (int)(5), (int)(5));				
				ellipse((int)(ball[0] - 2), (int)(ball[1] - 2), (int)(5), (int)(5));
                                fill(0);
			}
			
                        ellipseMode(CORNER);

			fill(95,93,93);				
			rect(0,0,500,25);
			rect(0, 555, 500, 45);
			textSize(18);
			fill(0);
			String s = "ApoClock4k";
			float w = textWidth(s);
			text(s, 240 - w/2 + 1, 20);
			fill(255,255,255);
			text(s, 240 - w/2, 18);

			textSize(15);
			s = "Level "+(p[1] + 1)+" / "+levelsString.length;
			fill(0);
			text(s, 5 + 1, 19);
			fill(255,255,255);
			text(s, 5, 17);
			fill(75,73,73);
			
			if (p[3] > 0) {
				textSize(25);
				
				if (p[3] == 1) {
					s = "Congratulation";
					w = textWidth(s);
					fill(118,110,111);
					rect(250 - w/2 - 5, 277, w + 10, 36);					
					rect(250 - w/2 - 5, 277, w + 10, 36);
                                        fill(0);
					text(s, 250 - w/2 + 1, 305 + 2);
					fill(255,255,255);
					text(s, 250 - w/2, 305);
					
					fill(0);
					s = "Click to start the next level";
					w = textWidth(s);
					text(s, 250 - w/2 + 1, 587 + 2);
					fill(255,255,255);
					text(s, 250 - w/2, 587);
				} else if (p[3] > 1) {
					s = " Please try again ";
					w = textWidth(s);
					fill(118,110,111);
					rect(250 - w/2 - 5, 277, w + 10, 36);					
					rect(250 - w/2 - 5, 277, w + 10, 36);
                                        fill(0);
					text(s, 250 - w/2 + 1, 305 + 2);
					fill(255,255,255);
					text(s, 250 - w/2, 305);
					
					fill(0);
					s = "Click to restart the level";
					w = textWidth(s);
					text(s, 250 - w/2 + 1, 587 + 2);
					fill(255,255,255);
					text(s, 250 - w/2, 587);
					
				}
			} else {
				if (p[2] <= 0) {
					s = "Click to start the level";
					w = textWidth(s);
					fill(0);
					text(s, 250 - w/2 + 1, 585 + 1);
					fill(255,255,255);
					text(s, 250 - w/2, 585);
					
					if (p[1] == 0) {
						fill(118,110,111);	
						rect(0, 500, 500, 55);
							
						s = "Your goal is to reach all the clocks";
						w = textWidth(s);
						fill(0);
						text(s, 250 - w/2 + 1, 515 + 1);
						fill(255,255,255);
						text(s, 250 - w/2, 515);
						
						s = "When the ball hits a clock the countdown starts";
						w = textWidth(s);
						fill(0);
						text(s, 250 - w/2 + 1, 535 + 1);
						fill(255,255,255);
						text(s, 250 - w/2, 535);
						
						s = "Click the mouse to fire the ball with the current clockwise direction";
						w = textWidth(s);
						fill(0);
						text(s, 250 - w/2 + 1, 555 + 1);
						fill(255,255,255);
						text(s, 250 - w/2, 555);
					}
				}
				try {
					textSize(30);
					fill(90,88,89);
					rect(70, 560, 60, 39);
					rect(370, 560, 60, 39);
					if ((p[4] > 70) && (p[4] < 130) &&
						(p[5] > 560) && (p[5] < 600)) {
						fill(246,255,3);
					}
					line(90, 580, 110, 570);
					line(90, 580, 110, 590);
					fill(90,88,89);
					if ((p[4] > 370) && (p[4] < 430) &&
						(p[5] > 560) && (p[5] < 600)) {
						fill(246,255,3);
					}
                                        
					line(410, 580, 390, 570);
					line(410, 580, 390, 590);
				} catch (Exception ex) {}
			}
			
			
			
		}

	
	

void mouseReleased(){
p[0] = 1;

}

void mouseMoved(){
p[4] = mouseX;
p[5] = mouseY;
  
}

void mouseDragged(){

p[4] = mouseX;
p[5] = mouseY;


}

