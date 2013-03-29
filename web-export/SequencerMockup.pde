void setup() {
  size(1024, 768);
  noStroke();
}

int buttonSize = 45;
int buttonRightMargin = buttonSize + 10;
int buttonBottomMargin = buttonSize + 10;
int buttonCornerRadius = 8;

int buttonCenterRadius = 16;
int buttonCenterCenterRadius = 16;
int extraSpace = 0;

//Rect[] rectangles;

void draw() {
  for (int i = 0; i < 12; ++i) {
    switch(i) {
      case 1:
        translate(0, 10);
        break;
      case 3:
        translate(0, 10);
        break;
      case 5:
        translate(0, 10);
        break;
      case 7:
        translate(0, 10);
        break;
      case 8:
        translate(0, 10);
        break;
      case 10:
        translate(0, 10);
        break;
    }
    for (int j = 0; j < 16; ++j) {
      drawButton(i, j);
    }    
  }
}

void drawButton(int i, int j) {
  int buttonX = 40 + (j * buttonRightMargin); 
  int buttonY = 20 + (i * buttonBottomMargin);
  
  // Draw Button
  fill(255, 255, 255);
  rect(buttonX, buttonY, 
    buttonSize, buttonSize, 
    buttonCornerRadius, buttonCornerRadius, buttonCornerRadius, buttonCornerRadius);
    
  // Draw Center Meter
  fill(169, 221, 250);
  drawCircleSlider(buttonX + buttonSize / 2, buttonY + buttonSize / 2, 
    buttonCenterRadius, 360, 0.6);
//  ellipse(buttonX + buttonSize / 2, buttonY + buttonSize / 2, buttonCenterRadius, buttonCenterRadius);
  fill(255, 255, 255);
  ellipse(buttonX + buttonSize / 2, buttonY + buttonSize / 2, buttonCenterCenterRadius, buttonCenterCenterRadius);
}

static final float DEG2RAD = PI / 180;
static final float TWOPI = PI * 2;
void drawCircleSlider(float x, float y, float radius, float sections, float fullness) {
  pushMatrix();
  translate(x, y);
  beginShape(TRIANGLE_FAN);
  noStroke();
  fill(169, 221, 250);
  vertex(0, 0);
  for(int i = 0; i <= sections; i++){
    float angle = i * TWOPI / sections - (90 * DEG2RAD);
    float vx = cos(angle) * radius;
    float vy = sin(angle) * radius;
    
    if ( i / sections > fullness ) {
      fill(0, 0, 0);
    }
    vertex(vx,vy);
  }
  endShape(CLOSE); 
  popMatrix();
}

void keyPressed() {
 if (key == 'p') {
   save("Mockup.png");
 } 
}

class Rect extends java.awt.Rectangle {
}

