
// Dodecahedron <- LSystem


class Dodecahedron extends LSystem {
  
  // edge lengths
  private float inEdge = 4;
  private float midEdge = 3;
  private float exEdge = 32;
  private float smallEdge = 2;
  
  // additional angles
  private float bigAngle = 150 * PI / 180;
  private float mediumAngle = 110 * PI / 180;
  private float smallAngle = 100 * PI / 180;
  private float tinyAngle = 40 * PI / 180;

  
  Dodecahedron() {
    super("Dodecahedron.json");
    angle = TWO_PI/3;
    //highColor = color(255, 255, 0);
    highColor = color(187, 151, 61, alpha);
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
                dashedMove(lvl * inEdge);
                break;
              case MF_small:
                moveForward(lvl * smallEdge);
                break;
              case MF_medium:
                dashedMove(lvl * midEdge);
                break;
              case MF_extra:
                moveForward(lvl * (exEdge + 0.5));
                break;
              case TR:
                turnRight(angle);
                break;
              case TR_tiny:
                turnRight(PI - tinyAngle);
                break;
              case TR_small:
                turnRight(PI - smallAngle);
                break;
              case TR_medium:
                turnRight(PI - mediumAngle);
                break;
              case TR_big:
                turnRight(PI - bigAngle);
                break;
              case TL:
                turnLeft(PI - smallAngle);
                break;
              case TL_tiny:
                turnLeft(PI - tinyAngle);
                break;
              case PUSH:
                pushMatrix();
                break;
              case POP:
                popMatrix();
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
              case INV:
                rotate(PI);
                break;
              default:
                if (v != 'I')
                  println("LSystem::Dodecahedron::unexpected token: '" + v + "';");
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
  
 
  // takes internal edge, as it can be 
  // calculated in terms of Seed Of Life radii
  void setEdgeLengths(float e) {
    inEdge = 3 * e / 5;
    exEdge = 2 * e / 3;
    midEdge = 7 * e / 13;
    smallEdge = 7 * e / 32;
  }
  
  
}
