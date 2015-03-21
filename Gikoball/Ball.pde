class Ball
{
  float x, y;
  float speedX, speedY;
  int WEIGHT = 50;
  int acceleration = 1;
  float COEFF_FROTTEMENT = 0.80;
  int nb_collisions = 0;
  float radius = 25;
  int t = 0;
  float gravityPower = 0.97;

  Ball(int x, int y)
  {
    this.x = x;
    this.y = y;
    speedX = 0;
    speedY = 0;
  }

  void keyPressed() 
  {
    if (key == CODED)
    {
      switch(keyCode)//todo, change this switch (you should be able to move + accelerate in same time)
      {
      case LEFT:
        speedX += 0.5;
        break;
      case RIGHT:
        speedX -= 0.5;
        break;
      case DOWN:
        speedY += 0.5;
        break;
      }
    }
  }

  void Gravity() {
    if (this.y >= 425)
    { //or change this to a method that gets the collision with the floor, set to screen height for now
      this.y = 424;
      speedY = -speedY /** COEFF_FROTTEMENT*/; //no infinite bounce, the ball gradually slows down
    } else if (this.y <= 0)
    { //or change this to a method that gets the collision with the floor, set to screen height for now
      this.y = 1;
      speedY = -speedY * COEFF_FROTTEMENT; //no infinite bounce, the ball gradually slows down
    }
    if (this.x <= 0)
    { //or change this to a method that gets the collision with the floor, set to screen height for now
      this.x = 1;
      speedX = -speedX * COEFF_FROTTEMENT;
    } else if (this.x > 800)
    { //or change this to a method that gets the collision with the floor, set to screen height for now
      this.x = 799;
      speedX = -speedX * COEFF_FROTTEMENT;
    }

    t++;
    if (t==5)
    {
      speedY = speedY * gravityPower;
      t = 0;
    }

    speedY += (9.81 * WEIGHT / 1000);

    speedX = speedX * 0.97;
    this.x -= speedX; 
    this.y += speedY;
  }

  void draw() 
  {
    Gravity();
    //todo, need a sprite, add an animated sprite!
    // MAKE ONE WITH PAINT, WESH ! BD
    ellipse(this.x, this.y, 2 * radius, 2 * radius);
  }

  /* params:
   
   platform_x - top left corner X coordinate
   platform_y - top left corner Y coordinate
   platform_width - width of rectangle
   platform_height - and the height
   */

  boolean is_ball_collinding_with_platform(
  float rectangleX, 
  float rectangleY, 
  float platform_width, 
  float platform_height)
  {
    float distance_x = abs(this.x - rectangleX - platform_width / 2);
    float distance_y = abs(this.y - rectangleY - platform_height / 2);

    if (distance_x > (platform_width / 2 + this.radius))
      return false;
    if (distance_y > (platform_height/2 + this.radius)) 
      return false;
    if (distance_x <= (platform_width/2))
      return true;
    if (distance_y <= (platform_height/2))
      return true;


    float corner_distance_sq = pow(distance_x - platform_width/2, 2) +
      pow(distance_y - platform_height/2, 2);

    return (corner_distance_sq <= pow(radius, 2));
  }

  void collides(Platform[] platform_list)
  {
    for (int i = 0; i < platform_list.length; ++i)
    {
      if (is_ball_collinding_with_platform(platform_list[i].x, 
      platform_list[i].y, platform_list[i].platform_width, platform_list[i].platform_height))
      {
        this.x += -1;
        speedX = -speedX * COEFF_FROTTEMENT;
      }
    }
  }
}

