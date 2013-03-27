package reuze.app;

import processing.core.PGraphics;
import processing.core.PImage;
import reuze.app.appGUI.ButtonCallback;

public class PropertyButtonImage extends PropertyButton
{
	/**
	 * 
	 */
	private final appGUI appGUI;
	PImage img;
	PropertyButtonImage(appGUI appGUI, String name, ButtonCallback callback)
	{ 
		super(appGUI, name, callback);
		this.appGUI = appGUI;
		img=this.appGUI.loadImage(name);
	}

	Rect getBox()
	{ return new Rect(this.appGUI, (int)(_x+_w*0.2), _y+1, (int)(_w*0.6), 18); }


	public void display(PGraphics pg, int y)
	{
		pg.stroke(_parent.fg);
		Rect b = getBox();
		pg.image(img,b.x,b.y,b.w,b.h);
		b.x-=_x; b.y += y-_y;
		if(_pressed && this.appGUI.overRect(getBox()))
			pg.strokeWeight(4);
		pg.noFill();
		this.appGUI.rect(pg, b);
		pg.strokeWeight(1);
	}
}