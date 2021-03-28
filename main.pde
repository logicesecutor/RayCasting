int nWalls = 10;
int FOV = 120;   //degrees
int nRays = 500;

float rotAngle = 0;
float rotVelocity = 4;  //radians per frame
LightPoint p;

ArrayList<Wall> walls;

void setup() {
  size(1000, 500, P2D);
  //fullScreen(P2D);
  
  float dividedWidth = width*0.5;
  float dividedHeight = height;
  
  p = new LightPoint(FOV, nRays, dividedWidth, dividedHeight);
  walls = new ArrayList();

  //Edge Walls
  walls.add(new Wall(0, 0, dividedWidth, 0));
  walls.add(new Wall(0, 0, 0, dividedHeight));
  walls.add(new Wall(0, dividedHeight, dividedWidth, dividedHeight));
  walls.add(new Wall(dividedWidth, 0, dividedWidth, dividedHeight));
  //Other Random Walls
  //for (int i=0; i<nWalls; ++i)
  //  walls.add(new Wall(random(0, dividedWidth), 
  //    random(0, dividedHeight), 
  //    random(0, dividedWidth), 
  //    random(0, dividedHeight)
  //    ));
  //frameRate(10);
}

void draw() {

  background(0);

  for (Wall w : walls) w.show();
  
  p.update(mouseX, mouseY, rotAngle);
  p.show();

  //println(frameRate);
}

void keyPressed(){
  if (key == 'a')
    rotAngle = -rotVelocity;
  if (key == 'd')
    rotAngle = rotVelocity;
}

void keyReleased(){
  rotAngle = 0;
}
