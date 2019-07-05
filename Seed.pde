
// Seed Of Life <- LSystem


// TODO::
//
//  - Try to adjust perimeter rings so they are always in contact with outer most seeds
//  - Fill flower until rings
//


class Seed extends LSystem {
  
  private boolean metatron = false;
  private float radius = 300;
  private color lowColor = color(130,130);
  
  // cap level in order to prevent crashing
  private int minLevel = 1;
  private int maxLevel = 31;
  
  
  Seed() {
    super("SeedOfLife.json");
    angle = PI/3;
    highColor = color(240,240,240);
  }
  
  
  void display() {
    if (!hidden) {
      pushMatrix();
      
      super.display();
  
      // look at each character of current value String
      for (int i = 0; i < value.length(); ++i) {
        char v = value.charAt(i);
        
        // loop over valid alphabet characters
        for (LCharacter c : alphabet) {
  
          // if current character is in alphabet,
          // perform its specified action
          if (c.value == v) {
            switch (c.act) {
              case TR:
                turnRight(angle);
                break;
              case PUSH:
                pushMatrix();
                break;
              case POP:
                popMatrix();
                break;
              case CIRCLE:
                ellipse(0, 0, radius, radius);
                break;
              case TRANS:
                //translate(0, radius);
                trans(radius);
                break;
              case BOLD:
                if (applyColor)
                  stroke(highColor);
                break;
              case LOW:
                if (metatron)
                  noStroke();
                else if (applyColor)
                  stroke(lowColor);
                break;
              default:
                if (v != 'I')
                  println("LSystem::SeedOfLife::unexpected token: '" + v + "';");
                break;
            }
            
            // break from character loop once 
            // current character has been handled
            break;
          }
        }
      }
      
      // draw perimeter rings
      strokeWeight(6);
      stroke(applyColor || metatron ? lowColor : highColor);
      ellipse(0,0, (height-25)/2,(height-25)/2);
      ellipse(0,0, (height-6)/2,(height-6)/2);
      strokeWeight(3);
  
      popMatrix();
    }
  }
  
  
  // add radius resizing to step/unstep and restrict min level to 1
  void step() {
    if (level < maxLevel) {
      super.step();
      resetRadius();
    }
  }
  
  void unstep() {
    if (level > minLevel) value = levels.get(--level);
    resetRadius();
  }
  
  
  // internal update of radius based upon level
  private void resetRadius() { radius = (height - 40) / (2 * (level + 1)); }
  
  
  // allow external manipulationof private members
  void setRadius(float r) { radius = r; }
  void setLowColor(color lc) { lowColor = lc; }
  void isMetatron() { metatron = true; }
  void notMetatron() { metatron = false; }
  
  
  // allow external access to radius
  float getRadius() { return radius; }
  
  // external access to level bounds
  int minLevel() { return minLevel; }
  int maxLevel() { return maxLevel; }
  
}
