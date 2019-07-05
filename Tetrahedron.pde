
// Tetrahedron <- LSystem


class Tetrahedron extends LSystem {
  
  // internal/external edge lengths
  private float inEdge = 4;
  private float exEdge = 32;
  
  
  Tetrahedron() {
    super("Tetrahedron.json");
    angle = PI/6;
    //highColor = color(20, 110, 220);
    //highColor = color(60, 128, 150, alpha);
    //highColor = color(213, 84, 58, alpha);
    highColor = color(60, 128, 150, alpha);
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
                moveForward(lvl * inEdge);
                break;
              case MF_extra:
                moveForward(lvl * exEdge);
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
              case LVL:
                lvl++;
                break;
              default:
                if (v != 'I')
                  println("LSystem::Tetrahedron::unexpected token: '" + v + "';");
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
  // measured in terms of Seed Of Life radii
  // uses equation: 
  //  a*a = b*b + c*c - 2*b*c*cos(A)
  // where:
  //  a - unknown side
  //  b,c - known sides
  //  A - angle between b and c
  void setEdgeLengths(float ie) {
    inEdge = ie;
    exEdge = sqrt(inEdge*inEdge + inEdge*inEdge -
              (2 * inEdge*inEdge * cos(TWO_PI/3)));
  }
  
  
}
