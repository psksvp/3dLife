float angle = 0f;

float rotX = 0.0, rotY = 30.0;
int lastX, lastY;
float distX = 0.0, distY = 0.0;

float xD = 200;
float yD = 200;
float zD = 200;


BrianBrain bb = new BrianBrain(60, 60, 60, 60);

void setup()
{
  size(400, 400, P3D);
}

void draw()
{
  background(0);
  lights();
  translate(width/2, height/2);
  scale(3.5, 3.5, 3.5);
  rotateX(rotX + distY);
  rotateY(rotY + distX);

  //stroke(255, 0, 0);
  //noFill();
  //box(xD*2, yD*2, zD*2);

  
  bb.visualize();
  bb.generate();
}

void keyPressed()
{
  bb.reset();
}

void mousePressed()
{
  lastX = mouseX;
  lastY = mouseY;
}
void mouseDragged()
{
  distX = radians(mouseX - lastX);
  distY = radians(lastY - mouseY);
}

void mouseReleased()
{
  rotX += distY;
  rotY += distX;
  distX = distY = 0f;
}