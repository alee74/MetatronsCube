
// Cube <- LSystem


class Cube extends LSystem {
  
  private float edge = 10;
  
  
  Cube() {
    super("Cube.json");
    angle = PI/3;
    //highColor = color(0,250,100);
    //highColor = color(88, 162, 51, alpha);
    highColor = color(213, 84, 58, alpha);
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
              case MF:
                dashedMove(lvl * edge);
                break;
              case TR:
                turnRight(angle);
                break;
              case PUSH:
                pushMatrix();
                break;
              case POP:
                popMatrix();
                break;
              case TRANS:
                trans(lvl * edge);
                break;
              case LVL:
                lvl++;
                break;
              case DASH:
                if (!depth()) noStroke();
                if (applyColor) dashed = true;
                break;
              case NODASH:
                if (!depth()) stroke(applyColor ? highColor : defaultColor);
                dashed = false;
                break;
              default:
                if (v != 'I')
                  println("LSystem::Cube::unexpected token: '" + v + "';");
                break;
            }
            
            // break from character loop once 
            // current character has been handled
            break;
          }
        }
      }
  
      popMatrix();
    }
  }
  
  
  void setEdgeLength(float e) { edge = e; }
  
  
}
