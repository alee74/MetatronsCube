
// RoundButton class for help menu toggle button

class RoundButton {
  
  // text
  private String txt = "Hi!";
  private float textSize = 15;
  private String fontName = "Arial Bold";
  private PFont font;
  private float xTextPadding = 0;
  private float yTextPadding = 0;
  
  // position & size
  private float x = 50;
  private float y = 50;
  private float r = 50;
  private float borderWidth = 2.0;
  
  // colors
  private color textColor = color(255);
  private color textHoverColor = color(0);
  private color borderColor = color(200,0,0);
  private color borderHoverColor = color(255,0,0);
  private color backgroundColor = color(0,0,200);
  private color backgroundHoverColor = color(0,0,255);

  // visibility
  private boolean hidden = false;
  
  // indicate "mode" of button
  //   true:
  //     no fill
  //     border(Hover)Color = text(Hover)Color
  //   false:
  //     fill with background(Hover)Color
  //     border(Hover)Color independent of text(Hover)Color
  private boolean hollow = false;
  
  
  RoundButton() {
    font = createFont(fontName, textSize);
  }
  
  
  RoundButton(float posX, float posY, float radius, String t) {
    x = posX;
    y = posY;
    r = radius;
    txt = t;
    font = createFont(fontName, textSize);
  }
  
  
  void display() {
    if (!hidden) {
      ellipseMode(RADIUS);
      
      // draw circle
      strokeWeight(borderWidth);
      if (mouseOver()) {
        if (hollow) {
          stroke(textHoverColor);
          noFill();
        } else {
          stroke(borderHoverColor);
          fill(backgroundHoverColor);
        }
      } else {
        if (hollow) {
          stroke(textColor);
          noFill();
        } else {
          stroke(borderColor);
          fill(backgroundColor);
        }
      }
      if (borderWidth <= 0) noStroke();
      ellipse(x,y, r,r);
      
      // draw text
      if (mouseOver())
        fill(textHoverColor);
      else
        fill(textColor);
      textFont(font);
      textAlign(CENTER);
      text(txt, x+xTextPadding, y+yTextPadding);
    }
  }
  
  
  boolean mouseOver() {
    float dx = mouseX - x;
    float dy = mouseY - y;
    if (!hidden && r*r >= dx*dx + dy*dy)
      return true;
    return false;
  }
  
  
  // visibility access/manipulation
  boolean hidden() { return hidden; }
  void hide() { hidden = true; }
  void show() { hidden = false; }
  
  
  // allow external manipulation
  void setText(String t) { txt = t; }
  void setTextSize(float ts) { textSize = ts; font = createFont(fontName, textSize); }
  void setFontName(String fn) { fontName = fn; font = createFont(fontName, textSize); }
  void setFont(PFont f) { font = f; }
  void setXTextPadding(float xtp) { xTextPadding = xtp; }
  void setYTextPadding(float ytp) { yTextPadding = ytp; }
  
  void setPosition(float xx, float yy) { x = xx; y = yy; }
  void setRadius(float rad) { r = rad; }
  void setBorderWidth(float bw) { borderWidth = bw; }
  
  void setTextColor(color tc) { textColor = tc; }
  void setTextHoverColor(color thc) { textHoverColor = thc; }
  void setBorderColor(color bc) { borderColor = bc; }
  void setBorderHoverColor(color bhc) { borderHoverColor = bhc; }
  void setBackgroundColor(color bgc) { backgroundColor = bgc; }
  void setBackgroundHoverColor(color bghc) { backgroundHoverColor = bghc; }
  
  
  // set button "mode"
  void isHollow() { hollow = true; }
  void notHollow() { hollow = false; }
  
}
