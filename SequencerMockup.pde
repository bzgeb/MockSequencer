int buttonSize = 45;
int buttonRightMargin = buttonSize + 10;
int buttonBottomMargin = buttonSize + 10;
int buttonCornerRadius = 8;

int buttonCenterRadius = 16;
int buttonCenterCenterRadius = 16;
int extraSpace = 0;

Button[] buttons;
Button clicked;
PVector lastMousePos;

void setup() {
  size(1024, 768, P2D);
  noStroke();
  frameRate(60);
  
  buttons = new Button[12 * 16];
  
  for ( int i = 0; i < 12; ++i ) {
    switch(i) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
        extraSpace += 10;
        break;
    }
    for ( int j = 0; j < 16; ++j ) {
      int buttonX = 40 + (j * buttonRightMargin); 
      int buttonY = 20 + (i * buttonBottomMargin) + extraSpace;
      
      buttons[j + (i * 16)] = new Button(buttonX, buttonY, 
        buttonSize, buttonSize);
    } 
  }
}

void draw() {
  for (int i = 0; i < 12; ++i) {
    for (int j = 0; j < 16; ++j) {
      buttons[j + (i * 16)].draw();
    }    
  }
}

void keyPressed() {
 if (key == 'p') {
   save("Mockup.png");
 } 
}

void mousePressed() {
  for (int i = 0; i < 192; ++i ) {
    if ( buttons[i].clicked() ) {
      clicked = buttons[i]; 
      lastMousePos = new PVector(mouseX, mouseY);
    }
//    buttons[i].handleInput();
  } 
}

void mouseReleased() {
  clicked = null;
}

void mouseDragged() {
  if ( clicked != null ) {
    float level = (lastMousePos.y - mouseY) * 0.003f;
    clicked.increaseLevel(level);
    lastMousePos.x = mouseX;
    lastMousePos.y = mouseY;
  }
}


/***************
* Button Class
****************/
class Button extends java.awt.Rectangle {
  CircleSlider slider;
  
  Button(int x, int y, int width, int height) {
    super(x, y, width, height);
    slider = new CircleSlider(buttonCenterRadius, 360, x + width / 2, y + height / 2);
    slider.setLevel(0.6f);
  }
  
  public void draw() {
    // Draw Button
    fill(255, 255, 255);
    rect(x, y, width, height, 
      buttonCornerRadius, buttonCornerRadius, buttonCornerRadius, buttonCornerRadius);
    
    // Draw Center Meter
    slider.draw();
        
    // Draw Center center
    fill(255, 255, 255);
      ellipse(x + width / 2, y + height / 2, buttonCenterCenterRadius, buttonCenterCenterRadius);
  }
  
  public boolean clicked() {
    return contains( mouseX, mouseY ); 
  }
  
  public void handleInput() {
    if ( contains( mouseX, mouseY ) ) {
      slider.increaseLevel(0.01);
    }
  }
  
  public void increaseLevel( float amount ) {
    slider.increaseLevel( amount ); 
  }
}

/****************
* Circle Slider
*****************/
class CircleSlider {
  PVector[] vertices;
  int sections;
  float x;
  float y;
  
  PShape shape;
  float level;
  
  CircleSlider( float radius, int sections, float x, float y ) {
    this.sections = sections;
    this.x = x;
    this.y = y;
    initVertices( radius );
    
    setLevel(1);
  }
  
  static final float DEG2RAD = PI / 180;
  private void initVertices( float radius ) {
    vertices = new PVector[sections + 2];
    vertices[0] = new PVector(0, 0);
    for(int i = 0; i <= sections; ++i){
      float angle = i * TWO_PI / sections - (90 * DEG2RAD);
      float vx = cos(angle) * radius;
      float vy = sin(angle) * radius;
    
      vertices[i + 1] = new PVector(vx, vy);
    }
  }
  
  public void draw() {
    shape(shape, x, y);
  }
  
  public void setLevel( float level ) {
    this.level = constrain(level, 0, 1);
    shape = createShape();
    shape.beginShape(TRIANGLE_FAN);
    shape.noStroke();
    shape.fill(169, 221, 250);
  
    shape.vertex(vertices[0].x, vertices[0].y);
    for(int i = 0; i <= sections; ++i) {
      if ( i / (float)sections > this.level ) {
        shape.fill(0, 0, 0);
      }
      shape.vertex(vertices[i].x, vertices[i].y);
    }
    shape.endShape(CLOSE); 
  }
  
  public void increaseLevel( float amount ) {
    setLevel( this.level + amount ); 
  }
}
