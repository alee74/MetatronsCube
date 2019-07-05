/* * * * * * * * * * * * * *
 *                         *
 *  Austin James Lee       *
 *                         *
 *  Dr. Matthew Hibbs      *
 *  CSCI-3353 - Graphics   *
 *  Homework 2             *
 *                         *
 * * * * * * * * * * * * * */



// TODO::
//
//  - Do something cooler with color?
//



Seed seed;
Cube cube;
Tetrahedron tetra;
Star star;
Octahedron octa;
Dodecahedron dodeca;
Icosahedron icosa;

int metatronLvl;
RoundButton q;
Menu help;
RoundButton i;
Menu info;

FadingLabel minLvl;
FadingLabel maxLvl;
FadingLabel metaLbl;


void setup() {
  surface.setTitle("Metatron's Cube");
  size(1000, 1000);
  metatronLvl = 4;

  // create LSystems
  seed = new Seed();
  cube = new Cube();
  tetra = new Tetrahedron();
  star = new Star();
  octa = new Octahedron();
  dodeca = new Dodecahedron();
  icosa = new Icosahedron();
  
  // start with Metatron's Cube displayed
  makeMetatron();

  // create and style help button
  q = new RoundButton(width-25, 25, 15, "?");
  q.setTextSize(25);
  q.setTextColor(color(120));
  q.setTextHoverColor(color(255));
  q.setXTextPadding(1);
  q.setYTextPadding(10);
  q.isHollow();
  
  // create and style help menu
  help = new Menu(200,175, width-400, height-350, "Help Menu", "");
  help.setYPadding(15);
  help.setTitleFontName("Courier");
  help.underlineTitle();
  help.appendToBody("The content displayed can be manipulated in a variety of ways: the L-System " +
    "levels can be increased and decreased, each Platonic Solid/L-System can be toggled individually " +
    "or as a whole, and they can be drawn in the same color or distinct ones. Below is a table of " +
    "the control keys and their effects on the displayed content.\n\n");
  help.appendToBody("                   M    Standard view of Metatron's Cube\n");
  help.appendToBody("                   C    Toggle distinct coloring\n");
  help.appendToBody("                   D    Toggle depth (3D projection lines)\n");
  help.appendToBody("                   S    Toggle Seed/Flower of Life\n");
  help.appendToBody("                   4    Toggle Tetrahedron\n");
  help.appendToBody("                   5    Toggle Star Tetrahedron\n");
  help.appendToBody("                   6    Toggle Cube\n");
  help.appendToBody("                   8    Toggle Octahedron\n");
  help.appendToBody("                   9    Toggle Dodecahedron\n");
  help.appendToBody("                   0    Toggle Icosahedron\n");
  help.appendToBody("                   X    Hide all\n");
  help.appendToBody("                   -    Hide all but Seed/Flower of Life\n");
  help.appendToBody("                   +    Show all\n");
  help.appendToBody("                   I    Toggle info menu\n");
  help.appendToBody("                 H/?    Toggle this help menu\n");
  help.appendToBody("    J/UP/RIGHT arrow    Increase L-System levels\n");
  help.appendToBody("   K/DOWN/LEFT arrow    Decrease L-System levels\n");
  help.appendToBody("\nSo go on, give it a try! See what kind of interesting configurations you can render!\n");
  help.setBodyFontName("Courier");
  help.hide();
  
  // create and style info button
  i = new RoundButton(25, 25, 15, "i");
  i.setTextSize(25);
  i.setTextColor(color(120));
  i.setTextHoverColor(color(255));
  i.setXTextPadding(0.25);
  i.setYTextPadding(9.5);
  i.isHollow();
  
  // create and style info menu
  info = new Menu(300,300, width-600,height-600, "About Metatron's Cube", "");
  info.setTitleFontName("Century Gothic");
  info.appendToBody("Metatron's Cube is the name given to the sacred geometrical " +
    "configuration created by overlaying the \"Fruit of Life\" pattern with the " +
    "Platonic Solids (Tetrahedron, Cube, Octahedron, Dodecahedron, Icosahedron), " +
    "along with the Star Tetrahedron.\n\n");
  info.appendToBody("This sacred geometry is unique in that all of the Platonic " +
    "Solids are said to be represented by or contained within the underlying " +
    "\"Flower of Life\" because they can all be drawn accurately by connecting " +
    "points creaed by the intersections of its component circles.\n");
  info.setBodyFontName("Century Gothic");
  info.setXPadding(20);
  info.underlineTitle();
  info.hide();
  
  // create fading labels for min/max level and metatron
  minLvl = new FadingLabel(10,height-15, "minimum level", Align.Left, 0.75);
  maxLvl = new FadingLabel(width-10,height-15, "maximum level", Align.Right, 0.75);
  metaLbl = new FadingLabel(width-10,height-15, "Metatron's Cube", Align.Right, 1.5);
  metaLbl.setFontSize(30);
  
}


void draw() {
  background(0);
  noFill();
  stroke(255);
  strokeWeight(3);
  ellipseMode(RADIUS);

  // display LSystems
  seed.display();
  cube.display();
  tetra.display();
  star.display();
  octa.display();
  dodeca.display();
  icosa.display();
  
  // check for click on buttons
  if (mousePressed) {
    if (q.mouseOver()) { info.hide(); help.show(); }
    if (i.mouseOver()) { help.hide(); info.show(); }
    minLvl.kick();
    maxLvl.kick();
  }

  // display buttons and menus
  q.display();
  help.display();
  i.display();
  info.display();
  
  // display labels
  minLvl.display();
  maxLvl.display();
  metaLbl.display();
  
}


void keyPressed() {
    
  // display "pure" Metatron's Cube
  if (key == 'm' || key == 'M') { makeMetatron(); metaLbl.kick(); }

  // toggle coloring
  if (key == 'c' || key == 'C') {
    seed.notMetatron();
    // only occurs after Metatron's Cube
    if (seed.coloring() != cube.coloring())
      enableAllColoring();
    else
      toggleAllColoring();
  }
  
  // toggle depth (show/hide dashed lines for 3D)
  if (key == 'd' || key == 'D') {
    seed.notMetatron();
    toggleAllDepth();
  }
  
  // toggle help menu
  if (key == 'h' || key == 'H' || key == '/' || key == '?') {
    if (help.hidden() && !info.hidden())
      info.hide();
    help.toggleVisibility();
  }
    
  // toggle info menu
  if (key == 'i' || key == 'I') {
    if (info.hidden() && !help.hidden())
      help.hide();
    info.toggleVisibility();
  }

  // increase level
  if (keyCode == LEFT || keyCode == DOWN || key == 'j' || key == 'J') {
    seed.notMetatron();
    seed.unstep();
    updateGeometricLevels();
    if (seed.level() == seed.minLevel()) minLvl.kick();
  }
  // decrease level
  if (keyCode == RIGHT || keyCode == UP || key == 'k' || key == 'K') {
    seed.notMetatron();
    seed.step();
    updateGeometricLevels();
    if (seed.level() == seed.maxLevel()) maxLvl.kick();
  }

  //// TOGGLE LSYSTEMS

  // Seed Of Life
  if (key == 's' || key == 'S') { seed.toggleVisibility(); seed.notMetatron(); }
  // Tetrahedron - 4 faces
  if (key == '4') { tetra.toggleVisibility(); seed.notMetatron(); }
  // Cube - 6 faces
  if (key == '6') { cube.toggleVisibility(); seed.notMetatron(); }
  // Star - 12 faces
  if (key == '5') { star.toggleVisibility(); seed.notMetatron(); }
  // Octahedron - 8 faces
  if (key == '8') { octa.toggleVisibility(); seed.notMetatron(); }
  // Dodecahedron - 12 faces
  if (key == '9') { dodeca.toggleVisibility(); seed.notMetatron(); }
  // Icosahedron - 20 faces
  if (key == '0') { icosa.toggleVisibility(); seed.notMetatron(); }

  // show all
  if (key == '=' || key == '+') { showAll(); seed.notMetatron(); }
  // hide all
  if (key == 'x' || key == 'X') { hideAll(); seed.notMetatron(); }
  // hide all Geometric - leave Seed Of Life
  if (key == '-' || key == '_') { hideAll(); seed.show(); seed.notMetatron(); }
}


// helper to appropriately display Metatron's Cube
void makeMetatron() {
  showAll();
  seed.isMetatron();
  seed.setLevel(metatronLvl);
  updateGeometricLevels();
  disableAllColoring();
  seed.enableColoring();
  showAllDepth();
}


// helper function to set levels of Geometric LSystems
// in order to remain within the bounds of the Seed/Flower 
// of Life and set the length of their edges accordingly
void updateGeometricLevels() {
  // Cube
  cube.setLevel((seed.level / 2) - 1);
  cube.setEdgeLength(2 * seed.getRadius());
  // Tetrahedron
  tetra.setLevel((seed.level / 2) - 1);
  tetra.setEdgeLengths(2 * seed.getRadius());
  // Star
  star.setLevel((seed.level / 2) - 1);
  star.setEdgeLengths(2 * seed.getRadius());
  // Octahedron
  octa.setLevel((seed.level / 2) - 1);
  octa.setEdgeLengths(2 * seed.getRadius());
  // Dodecahedron
  dodeca.setLevel((seed.level / 2) - 1);
  dodeca.setEdgeLengths(2 * seed.getRadius());
  //Icosahedron
  icosa.setLevel((seed.level / 2) - 1);
  icosa.setEdgeLengths(2 * seed.getRadius());
}


// helper to toggle (hide) all LSystems
void hideAll() {
  seed.hide();
  cube.hide();
  tetra.hide();
  star.hide();
  octa.hide();
  dodeca.hide();
  icosa.hide();
}


// helper to toggle (show) all LSystems
void showAll() {
  seed.show();
  cube.show();
  tetra.show();
  star.show();
  octa.show();
  dodeca.show();
  icosa.show();
}


// helper to toggle (disable) coloring for all LSystems
void disableAllColoring() {
  seed.disableColoring();
  cube.disableColoring();
  tetra.disableColoring();
  star.disableColoring();
  octa.disableColoring();
  dodeca.disableColoring();
  icosa.disableColoring();
}


// helper to toggle (enable) coloring for all LSystems
void enableAllColoring() {
  seed.enableColoring();
  cube.enableColoring();
  tetra.enableColoring();
  star.enableColoring();
  octa.enableColoring();
  dodeca.enableColoring();
  icosa.enableColoring();
}


// helper to toggle coloring for all LSystems
void toggleAllColoring() {
  if (!cube.coloring())
    enableAllColoring();
  else
    disableAllColoring();
}

// helper to toggle depth for all LSystems
void toggleAllDepth() {
  cube.toggleDepth();
  tetra.toggleDepth();
  star.toggleDepth();
  octa.toggleDepth();
  dodeca.toggleDepth();
  icosa.toggleDepth();
}

// helper to toggle (enable) depth for all LSystems
void showAllDepth() {
  cube.showDepth();
  tetra.showDepth();
  star.showDepth();
  octa.showDepth();
  dodeca.showDepth();
  icosa.showDepth();
}
