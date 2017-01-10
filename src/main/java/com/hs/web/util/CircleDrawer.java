package com.hs.web.util;

import org.jfree.ui.Drawable;

import java.awt.*;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Rectangle2D;

public class CircleDrawer implements Drawable {
	private final Paint outlinePaint;
	private final Stroke outlineStroke;
	private final Paint fillPaint;

	public CircleDrawer(Paint paramPaint1, Stroke paramStroke, Paint paramPaint2) {
		this.outlinePaint = paramPaint1;
		this.outlineStroke = paramStroke;
		this.fillPaint = paramPaint2;
	}

	public void draw(Graphics2D paramGraphics2D, Rectangle2D paramRectangle2D) {
		Ellipse2D.Double localDouble = new Ellipse2D.Double(
				paramRectangle2D.getX(), paramRectangle2D.getY(),
				paramRectangle2D.getWidth(), paramRectangle2D.getHeight());
		if (this.fillPaint != null) {
			paramGraphics2D.setPaint(this.fillPaint);
			paramGraphics2D.fill(localDouble);
		}
		if ((this.outlinePaint != null) && (this.outlineStroke != null)) {
			paramGraphics2D.setPaint(this.outlinePaint);
			paramGraphics2D.setStroke(this.outlineStroke);
			paramGraphics2D.draw(localDouble);
		}
		paramGraphics2D.setPaint(Color.black);
		paramGraphics2D.setStroke(new BasicStroke(1.0F));
		
//////////////////////////////////////////////////////////////////////////
//		-> draw cross hair
//		
//		Line2D.Double localDouble1 = new Line2D.Double(
//				paramRectangle2D.getCenterX(), paramRectangle2D.getMinY(),
//				paramRectangle2D.getCenterX(), paramRectangle2D.getMaxY());
//		Line2D.Double localDouble2 = new Line2D.Double(
//				paramRectangle2D.getMinX(), paramRectangle2D.getCenterY(),
//				paramRectangle2D.getMaxX(), paramRectangle2D.getCenterY());
//		paramGraphics2D.draw(localDouble1);
//		paramGraphics2D.draw(localDouble2);
//////////////////////////////////////////////////////////////////////////
	}
}