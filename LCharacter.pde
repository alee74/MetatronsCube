
// LCharacter class for LSystem
// --> represents an LCharacter in LSystem's Alphabet

// enumeration of LCharacter actions
public enum Action { NULL, MF, MF_small, MF_medium, MF_extra,
                     TR, TR_tiny, TR_small, TR_medium, TR_big,
                     TL, TL_tiny, PUSH, POP, CIRCLE,
                     TRANS, TRANS_extra, BOLD, LOW, LVL,
                     DASH, NODASH, INV
                   }
                   
                   
class LCharacter {
  
  char value;
  Action act;
  
  
  LCharacter(char val, String a) {
    value = val;
    act = parseAction(a);
  }
  
  
  Action parseAction(String a) {
    if (a.equals("move forward")) return Action.MF;
    if (a.equals("move small forward")) return Action.MF_small;
    if (a.equals("move medium forward")) return Action.MF_medium;
    if (a.equals("move extra forward")) return Action.MF_extra;
    if (a.equals("turn right")) return Action.TR;
    if (a.equals("turn tiny right")) return Action.TR_tiny;
    if (a.equals("turn small right")) return Action.TR_small;
    if (a.equals("turn medium right")) return Action.TR_medium;
    if (a.equals("turn big right")) return Action.TR_big;
    if (a.equals("turn left")) return Action.TL;
    if (a.equals("turn tiny left")) return Action.TL_tiny;
    if (a.equals("push matrix")) return Action.PUSH;
    if (a.equals("pop matrix")) return Action.POP;
    if (a.equals("draw circle")) return Action.CIRCLE;
    if (a.equals("translate")) return Action.TRANS;
    if (a.equals("extra translate")) return Action.TRANS_extra;
    if (a.equals("bold color")) return Action.BOLD;
    if (a.equals("low color")) return Action.LOW;
    if (a.equals("level up")) return Action.LVL;
    if (a.equals("set dash")) return Action.DASH;
    if (a.equals("set no dash")) return Action.NODASH;
    if (a.equals("invert")) return Action.INV;
    return Action.NULL;
  }
  
}
