
// Icosahedron <- LSystem


class Icosahedron extends LSystem {
  
  // edge lengths
  private float inEdge;
  private float exEdge;
  private float weirdEdge;
  private float smallEdge;
  
  // additional angles
  private float bigAngle = 106.5*PI/180;
  private float mediumAngle = 96.75*PI/180;
  
  
  Icosahedron() {
    super("Icosahedron.json");
    angle = PI/6;
    //highColor = color(102, 0, 153);
    //highColor = color(255, 69, 0);
    highColor = color(127, 92, 175, alpha);
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
                dashedMove(lvl * weirdEdge);
                break;
              case MF_small:
                dashedMove(lvl * smallEdge);
                break;
              case MF_medium:
                dashedMove(lvl * inEdge);
                break;
              case MF_extra:
                moveForward(lvl * exEdge);
                break;
              case TR:
                turnRight(angle);
                break;
              case TR_medium:
                turnRight(mediumAngle);
                break;
              case TR_big:
                turnRight(bigAngle);
                break;
              case TRANS:
                trans(lvl * (exEdge - smallEdge));
                break;
              case TRANS_extra:
                trans(lvl * exEdge);
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
                  println("LSystem::Icosahedron::unexpected token: '" + v + "';");
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
  
 
  // takes external edge, as it can be 
  // measured in terms of Seed Of Life radii
  // uses equation: 
  //  a*a = b*b + c*c - 2*b*c*cos(A)
  // where:
  //  a - unknown side
  //  b,c - known sides
  //  A - angle between b and c
  void setEdgeLengths(float e) {
    exEdge = e;
    smallEdge = 2 * exEdge / 5;
    weirdEdge = sqrt(smallEdge*smallEdge + exEdge*exEdge -
                    (2 * smallEdge * exEdge * cos(PI/3)));
    inEdge = sqrt(weirdEdge*weirdEdge + weirdEdge*weirdEdge-
                  (2 * weirdEdge * weirdEdge * cos(73.5*PI/180)));
  }
  
  
}
