
// LSystem class
//
// Requires:
//    LCharacter class
//    Rule class


class LSystem {
  
  String name;
  ArrayList<LCharacter> alphabet;
  char axiom;
  ArrayList<Rule> rules;
  
  String value; // starts as axiom
  int level;
  ArrayList<String> levels;
  
  boolean applyColor = false;
  protected float defaultStroke = 3;
  protected color highColor = color(255);
  protected color defaultColor = color(255);
  protected float alpha = 210;

  protected float angle = PI/3;
  
  protected boolean hidden = false;
  
  protected boolean dashed = false;
  private float dashLength = 10;
  private boolean depth = false;

  protected int lvl;  // internal "level" counter
                    // represents number of concentric geometric shapes
                    // used to calculate length of edges



  // constructor takes a filename of a JSON file
  // containing and LSystem represented as a JSONObject
  LSystem(String filename) {

    // load JSON file
    JSONObject system = loadJSONObject(filename);

    // parse name
    name = system.getString("Name");
    //setMode();

    // parse alphabet
    alphabet = new ArrayList<LCharacter>();
    JSONArray characters = system.getJSONArray("Alphabet");
    for (int i = 0; i < characters.size(); ++i) {
      JSONObject c = characters.getJSONObject(i);
      alphabet.add(new LCharacter(c.getString("value").charAt(0), c.getString("action")));
    }

    // parse rules
    rules = new ArrayList<Rule>();
    JSONArray rs = system.getJSONArray("Rules");
    for (int i = 0; i < rs.size(); ++i) {
      JSONObject r = rs.getJSONObject(i);
      rules.add(new Rule(r.getString("symbol").charAt(0), r.getString("derives")));
    }

    axiom = system.getString("Axiom").charAt(0);    
    value = "" + axiom;
    level = 0;
    
    levels = new ArrayList<String>();
    levels.add(value);
  }


  void display() {
    translate(width/2, height/2);
    stroke(defaultColor);
    if (applyColor)
      stroke(highColor);
    dashed = false;
    lvl = 2;
  }


  void turnRight(float angle) { rotate(angle); }
  void turnLeft(float angle) { rotate(-angle); }
  void trans(float dist) { translate(0, -dist); }
  void moveForward(float dist) { 
    line(0, 0, 0, -dist); 
    translate(0, -dist);
  }
  
  
  void dashedMove(float dist) {
    if (dashed) {
      while (dist >= dashLength * 2) {
        moveForward(dashLength);
        dist -= dashLength;
        trans(dashLength);
        dist -= dashLength;
      }
      if (dist > 0)
        moveForward(dist > dashLength ? dashLength : dist);
      if (dist > dashLength)
        trans(dist - dashLength);
    } else
      moveForward(dist);
  }


  void step() {
    if (level + 1 <= levels.size() - 1)
      value = levels.get(++level);
    else {
      String newValue = "";
      for (int i = 0; i < value.length(); ++i) {
        char c = value.charAt(i);
        boolean hasRule = false;
        for (Rule r : rules) {
          if (r.symbol == c) {
            newValue += r.derives;
            hasRule = true;
            break;
          }
        }
        if (!hasRule)
          newValue += c;
      }
      value = newValue;
      ++level;
      levels.add(value);
    }
  }
  
  
  void unstep() { 
    if (level > 0) 
      value = levels.get(--level);
  }

  
  void setLevel(int lvl) {
    if (lvl < 0)
      lvl = 0;
    while (level > lvl)
      unstep();
    while (level < lvl)
      step();
  }
  
  
  void setTurnAngle(float ang) { angle = ang; }
  void setDefaultStroke(float dflt) { defaultStroke = dflt; }
  void setHighColor(color hc) { highColor = hc; }
  void setDefaultColor(color dc) { defaultColor = dc; }
  
  void hide() { hidden = true; }
  void show() { hidden = false; }
  void toggleVisibility() { hidden = !hidden; }
  boolean hidden() { return hidden; }
  
  void enableColoring() { applyColor = true; }
  void disableColoring() { applyColor = false; }
  void toggleColoring() { applyColor = !applyColor; }
  boolean coloring() { return applyColor; }
  
  void setDashLength(float dl) { dashLength = dl; }
  
  void hideDepth() { depth = false; }
  void showDepth() { depth = true; }
  void toggleDepth() { depth = !depth; }
  boolean depth() { return depth; }
  
  int level() { return level; }
  

  void printL() {
    println("LSystem: " + name);
    println("\tAlphabet:");
    for (LCharacter c : alphabet) {
      print("\t\t" + c.value + " = ");
      switch (c.act) {
      case NULL: 
        print("do nothing\n"); 
        break;
      case MF: 
        print("move forward\n"); 
        break;
      case TR: 
        print("turn right\n"); 
        break;
      case TL: 
        print("turn left\n"); 
        break;
      default: 
        print("\n"); 
        break;
      };
    }
    println("\tAxiom: " + axiom);
    println("\tRules:");
    for (Rule r : rules)
      println("\t\t" + r.symbol + " => " + r.derives);
  }
  
  
}
