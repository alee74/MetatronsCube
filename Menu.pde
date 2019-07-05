
// Menu class to be used for the help menu

class Menu {
  
  // position & size
  private float px = 20;
  private float py = 20;
  private float sx = 200;
  private float sy = 200;
  private float cornerRadius = 3;
  
  // content
  private String title = "Hello There!";
  private String body = "fill me!";
  
  // text properties
  private float titleSize = 30;
  private String titleFontName = "Arial Bold";
  private PFont titleFont;
  private boolean underline = false;
  private float bodySize = 15;
  private String bodyFontName = "Arial";
  private PFont bodyFont;
  
  // spacing
  private float titlePadding = 25; // between title and body
  private float xPadding = 10; // for all
  private float yPadding = 15; // for all
  
  // colors
  private color titleColor = color(0);
  private color bodyColor = color(0);
  private color backgroundColor = color(160);
  
  // visibility
  private boolean hidden = false;
  
  // close button
  private RoundButton close;
  
  // internal use only
  private float titleY;
  
  
  Menu() {
    // create fonts
    titleFont = createFont(titleFontName, titleSize);
    bodyFont = createFont(bodyFontName, bodySize);
    
    // create and style close button
    close = new RoundButton(px+sx-10, py+10, 7, "x");
    close.setXTextPadding(1);
    close.setYTextPadding(4.5);
    close.setTextColor(color(75));
    close.setTextHoverColor(color(0));
    close.setBorderWidth(0.5);
    close.isHollow();
    
    setTitleY();
  }
    
  
  Menu(float posX, float posY, float sizeX, float sizeY, String t, String b) {
    px = posX;
    py = posY;
    sx = sizeX;
    sy = sizeY;
    title = t;
    body = b;
    
    // create fonts
    titleFont = createFont(titleFontName, titleSize);
    bodyFont = createFont(bodyFontName, bodySize);
    
    // create and style close button
    close = new RoundButton(px+sx-15, py+15, 10, "X");
    close.setTextSize(18);
    close.setFontName("Arial");
    close.setXTextPadding(1);
    close.setYTextPadding(6);
    close.setTextColor(color(75));
    close.setTextHoverColor(color(0));
    close.setBorderWidth(0);
    close.isHollow();
    
    setTitleY();
  }
  
  
  void display() {
    if (!hidden) {
      noStroke();
      rectMode(CORNER);
      
      // draw background
      fill(backgroundColor);
      rect(px,py, sx,sy, cornerRadius);
      
      // draw title text
      fill(titleColor);
      textFont(titleFont);
      textAlign(CENTER);
      text(title, px+(sx/2), titleY);
      
      // underline title
      if (underline) {
        stroke(titleColor);
        strokeWeight(3);
        line(px+(sx/2)-(textWidth(title)/2),titleY+3, px+(sx/2)+(textWidth(title)/2),titleY+3);
        noStroke();
      }
      
      // draw body text
      fill(bodyColor);
      textFont(bodyFont);
      textAlign(LEFT);
      text(body, px+xPadding, titleY+titlePadding, sx-(2*xPadding),sy-(2*yPadding));
      
      
      // check for click on close button
      if (mousePressed && close.mouseOver())
        hide();
      
      // draw close button
      close.display();
    
    }
  }
  
  
  // visibility
  boolean hidden() { return hidden; }
  void hide() { hidden = true; }
  void show() { hidden = false; }
  void toggleVisibility() { hidden = !hidden; }
  
  
  // allow external manipulation
  void setPosition(float x, float y) { px = x; py = y; setTitleY(); }
  void setSize(float x, float y) { sx = x; sy = y; }
  void setCornerRadius(float cr) { cornerRadius = cr; }
  
  void setTitle(String t) { title = t; }
  void setBody(String b) { body = b; }
  void appendToBody(String b) { body += b; }
  
  void setTitleSize(float ts) { titleSize = ts; titleFont = createFont(titleFontName, titleSize); setTitleY(); }
  void setTitleFontName(String tfn) { titleFontName = tfn; titleFont = createFont(titleFontName, titleSize); setTitleY(); }
  void setTitleFont(PFont tf) { titleFont = tf; setTitleY(); }
  void underlineTitle() { underline = true; }
  void noUnderlineTitle() { underline = false; }
  void setBodySize(float bs) { bodySize = bs; bodyFont = createFont(bodyFontName, bodySize); }
  void setBodyFontName(String bfn) { bodyFontName = bfn; bodyFont = createFont(bodyFontName, bodySize); }
  void setBodyFont(PFont bf) { bodyFont = bf; }
  
  void setTitlePadding(float tp) { titlePadding = tp; }
  void setXPadding(float xp) { xPadding = xp; }
  void setYPadding(float yp) { yPadding = yp; setTitleY(); }
  
  void setTitleColor(color tc) { titleColor = tc; }
  void setBodyColor(color bc) { bodyColor = bc; }
  void setBackgroundColor(color bgc) { backgroundColor = bgc; }
  
  
  // calculate title y position
  private void setTitleY() {
    textFont(titleFont);
    titleY = py + yPadding + textAscent();
  }
  
}
