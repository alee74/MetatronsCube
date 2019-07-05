
// text alignment enum
public enum Align { Left, Center, Right }


class FadingLabel {
  
  // location
  private float x;
  private float y;
  
  // properties
  private String txt = "henlo";
  private String fontName = "Arial";
  private float fontSize = 20;
  private PFont font;
  private Align align = Align.Center;
  
  // fading
  boolean awake = false;
  private float lifetime;  // in seconds!
  private float lastTime;
  private float timeLeft;
  
  
  FadingLabel(float xx, float yy, String t, Align a, float life) {
    x = xx;
    y = yy;
    txt = t;
    align = a;
    lifetime = life;
    font = createFont(fontName, fontSize);
  }
  
  
  void display() {
    if (awake) {
      // time calculations
      float now = millis();
      timeLeft -= (now - lastTime) / 1000;
      lastTime = now;
      if (timeLeft <= 0) awake = false;
      
      // set text properties and draw
      switch (align) {
        case Left: textAlign(LEFT); break;
        case Right: textAlign(RIGHT); break;
        case Center: textAlign(CENTER); break;
        default: break;
      }
      textFont(font);
      fill(color(255, map(timeLeft, 0,lifetime, 0,255)));
      text(txt, x,y);
    }
  }
  
  
  void kick() {
    timeLeft = lifetime;
    lastTime = millis();
    awake = true;
  }
  
  
  // public access
  String getText() { return txt; }
  
  
  // public manipulation
  void setLocation(float xx, float yy) { x = xx; y = yy; }
  void setText(String t) { txt = t; }
  void setFontName(String fn) { fontName = fn; font = createFont(fontName, fontSize); }
  void setFontSize(float fs) { fontSize = fs; font = createFont(fontName, fontSize); }
  void setFont(PFont f) { font = f; }
  void setAlign(Align a) { align = a; }
  
}
