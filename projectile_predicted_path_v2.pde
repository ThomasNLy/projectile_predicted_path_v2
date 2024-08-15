float x, y, yspeed, xspeed;
float gravity = 9.8f;
float angle; // in degrees;
float velocity = 90f;
float path[] = new float[10];
float path2[] = new float[10];
void setup()
{
  size(1000, 800);
  x = 10;
  angle = 0;
}

void draw()
{
  background(180);
  fill(255);
  circle(x, y, 50);
  yspeed += gravity;
  y += yspeed;
  x += xspeed;



  if (y >= height-100)
  {
    y = height-100;
    yspeed = 0;
    xspeed = 0;
  }
  fill(255);
  textSize(30);
  text("Angle: " + angle, 200, 200);
   text("Velocity: " + velocity + " px/frame", 400, 200);
  float radianAngle = degToRad(angle);
  for(int i = 0; i < 10; i++)
  {
    
  //processing coordinate grid y is inversed will need to inverse the trajectory
    //path[i] = -trajectoryFormula(radianAngle, velocity, 10 + 80 * i);//10 spots of possible y coordinate of bullet trajectory
    float spacing = calculateMaxRange(radianAngle, velocity)/ 10;
    path2[i] = -trajectoryFormula(radianAngle, velocity, 10 + spacing * i);
  }
 
  for(int i = 0; i < 10; i++)
  {
     //rect(10  + 80 * i, height-100 + path[i], 10, 10); //10 spots of possible y coordinate of bullet trajectory
     fill(180, 190, 0);
     float spacing = calculateMaxRange(radianAngle, velocity)/ 10;
     rect(10  + spacing * i, height-100 + path2[i], 10, 10);
     noFill();
  }
 
 
  float maxRange = calculateMaxRange(radianAngle, velocity);
  fill(255, 0, 0);
  rect(maxRange, height - 100, 10, 10);
  noFill();
}
void mousePressed()
{
  if (mouseButton == LEFT)
  {
    float radian = degToRad(angle);
    PVector dir = calculateDirVector(radian);
    xspeed = dir.x * velocity;
    yspeed = -dir.y * velocity;
    //println(yspeed);
  }
  if (mouseButton == RIGHT)
  {
    x = 10;
  }
}

void mouseWheel(MouseEvent event)
{
  if (event.getCount() > 0)
  {
    angle+=1;
  }
  if (event.getCount() < 0)
  {
    angle-=1;
  }
}

void keyPressed()
{
  if(key == 'w')
  {
    velocity += 1;
  }
  if(key == 's')
  {
    velocity -= 1;
  }
  
}




PVector calculateDirVector(float angle)
{
  float ydir = sin(angle);
  float xdir = cos(angle);
  return new PVector(xdir, ydir);
}


float degToRad(float angle)
{
  return angle * PI/180;
}




//v is velocity 
float trajectoryFormula(float angle, float v, float _x)
{
  //trajectory formula for calcualting quadratic equation of flight path 
  /*
    cosSquared = cos(angle) * cos(angle);
   y = x * tan(angle) - ((gravity * (x * x))/2 * v * v * cosSquared);
   y: y coordinate of the bullet in the air, the horizontal component(dependant on the bullet's horizontal x coord) 
   x: x coordinate bullet moving forward, vertical component(dpenedant on the bullet's vertical y coord)
   */
  float x = _x; // the current x coordinate of the bullet  as it moves forward
  float cosSquared = cos(angle) * cos(angle);
  float a = x * tan(angle);
  float b = ((gravity * (x * x))/(2 * v * v * cosSquared));
  //println(a - b);

  //returns the resulting y coordinate of where that bullet should be given an x coordinate on the quadratic equation
  return(a-b);
}




//projectile range formula = (velocity^2 * sin2theta)/gravity
float calculateMaxRange(float angle, float v)
{
  //sin2theta = 2sin(theta) * cos(theta)
  
  float range = v * v * (2 * sin(angle) * cos(angle))/gravity;
  return range;
}
