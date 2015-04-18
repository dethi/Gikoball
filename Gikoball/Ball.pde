class Ball
{
  // REAL POSITION X = X + SHIFT !!!!!
  float x, y;
  float right, left, bottom, top;  
  float speedX, speedY;
  int WEIGHT = 50;
  int acceleration = 1;
  float COEFF_FROTTEMENT = 0.97;
  int nb_collisions = 0;
  float radius;
  int t = 0;
  float gravityPower = 0.97;
  PImage skin;

  int nb_lives;

  boolean condition1;
  boolean condition2;

  //movement of the ball
  boolean downPressed = false;
  boolean leftPressed = false;
  boolean rightPressed = false;

  Ball(int x, int y, int radius/*, PImage skin*/)
  {
    nb_lives = 1;
    condition1 = false;
    condition2 = false;
    this.x = x;
    this.y = y;
    speedX = 0;
    speedY = 0;
    this.radius = radius;

    left = x - radius;
    right = x + radius;
    top = y - radius;
    bottom = y + radius;

    //println("ball");
    //println("x :"+x+" y :"+y+" radius :"+this.radius+" width "+2 * this.radius);
    //println("left :"+left+" right :"+right+" top :"+top+" bottom :"+bottom);
  }
  
  void reborn() 
  {
    shift = 0;
    this.speedX = 0;
    this.speedY = 0;
    this.x = 30;
    this.y = 100;
    this.nb_lives=1;
    this.condition1=false;
    this.condition2=false;    
    /* We need to also reboot enemies and collections*/
  }
  void keyPressed() 
  {
    if (key == CODED)
    {
      if (keyCode==LEFT)
        leftPressed = true;
      if (keyCode==RIGHT)
        rightPressed = true;
      if (keyCode==DOWN)
        downPressed = true;
    }
  }

  void keyReleased()
  {
    if (key == CODED) {
      if (keyCode == DOWN) {
        downPressed = false;
      } else if (keyCode == LEFT) {
        leftPressed = false;
      } else if (keyCode == RIGHT) {
        rightPressed = false;
      }
    }
  }

  void setX(float x) {
    this.x=x;
  }

  void setSkin(PImage skin) //possibility to change the skin;
  {
    this.skin = skin;
  }

  float getX() {
    return this.x;
  }

  void moveBall()
  {
    if (downPressed) {
      speedY += 0.5;
    }
    if (leftPressed) {
      if (speedX <= 10)
        speedX += 0.5;
    }
    if (rightPressed) {
      if (speedX >= -10)
        speedX -= 0.5;
    }
  }

  void Gravity() {
    /*
           if (this.y >= 425)
     { //or change this to a method that gets the collision with the floor, set to screen height for now
     this.y = 424;
     speedY = -speedY * COEFF_FROTTEMENT; //no infinite bounce, the ball gradually slows down
     } else if (this.y <= 0)
     { //or change this to a method that gets the collision with the floor, set to screen height for now
     this.y = 1;
     speedY = -speedY/* * COEFF_FROTTEMENT*/    ; //no infinite bounce, the ball gradually slows down
    /*    } */
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

  void draw(ArrayList<Platform> platform_list, int shift) 
  {
    moveBall();
    Gravity();
    x+= shift;
    update(platform_list);
    x-= shift;

    //Extras 
    image(loadImage("baner_01.png"), 5, 30, 100, 50);
    if (condition1)
      image(loadImage("pu_01.png"), 105, 45, 30, 30);

    image(this.skin, x - radius, y-radius, radius*2, radius*2);
  }

  /* params:
   
   platform_x - top left corner X coordinate
   platform_y - top left corner Y coordinate
   platform_width - width of rectangle
   platform_height - and the height
   */

  void update(ArrayList<Platform> platform_list)
  {
    update_position(); 
    collides(platform_list);
  }
  
  void update_position()
  {
    right = x + radius;
    left = x - radius;
    top = y - radius;
    bottom = y + radius;
    println("position ball x"+this.x);
  }

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
    if (distance_x <= (platform_width / 2))
      return true;
    if (distance_y <= (platform_height / 2))
      return true;


    float corner_distance_sq = pow(distance_x - platform_width / 2, 2) +
      pow(distance_y - platform_height/2, 2);

    return (corner_distance_sq <= pow(radius, 2));
  }

  void update_position_collision(Platform platform)
  {
    // Ball is on the right of the platform 
    //println(this.left >= platform.right);
    if (this.x <= platform.left + abs(speedX) && this.y <= platform.top + abs(speedY))
    {//top left corner
      //println("The ball is on the top left corner of the platform");
      speedX = abs(speedX) * COEFF_FROTTEMENT;
      speedY = -abs(speedY) * COEFF_FROTTEMENT;
      this.x -= speedX+1;
      this.y += speedY-1;
    } else if (this.x >= platform.right - abs(speedX) && this.y <= platform.top + abs(speedY))
    {//top right corner
      //println("The ball is on the top right corner of the platform");
      speedX = -abs(speedX) * COEFF_FROTTEMENT;
      speedY = -abs(speedY) * COEFF_FROTTEMENT;
      this.x -= speedX-1;
      this.y += speedY-1;
    } else if (this.x <= platform.left + abs(speedX) && this.y >= platform.bottom - abs(speedY))
    {//bottom left corner
      //println("The ball is on the bottom left corner of the platform");
      speedX = abs(speedX) * COEFF_FROTTEMENT;
      speedY = abs(speedY);
      this.x -= speedX+1;
      this.y += speedY+1;
    } else if (this.x >= platform.right - abs(speedX) && this.y >= platform.bottom - abs(speedY))
    {//bottom right corner
      //println("The ball is on the bottom right corner of the platform");
      speedX = -abs(speedX) * COEFF_FROTTEMENT;
      speedY = abs(speedY);
      this.x -= speedX-1;
      this.y += speedY+1;
    } else 
      if (this.left >= platform.right - abs(speedX)/* && this.top <= platform.bottom &&
     this.bottom >= platform.top && this.top <= platform.bottom*/)
    {
      //println("The ball is on the right of the platform");
      //++this.x;
      speedX = -abs(speedX)/* * COEFF_FROTTEMENT*/;
      this.x -= speedX+1;
    }
    // Ball is on the left of the platform
    else if (this.right <= platform.left + abs(speedX)/* && this.top <= platform.bottom &&
     this.bottom >= platform.top && this.top <= platform.bottom*/)
    {
      //println("The ball is on the left of the platform");
      //--this.x;
      speedX = abs(speedX)/* * COEFF_FROTTEMENT*/;
      this.x -= speedX+1;
    }
    // Ball is on the top of the platform
    else if (this.bottom <= platform.top + abs(speedY)/*&& this.top <= platform.top &&
     this.left <= platform.right && this.right >= platform.left*/)
    {
      //println("The ball is on the top");
      speedY = -abs(speedY) * COEFF_FROTTEMENT;
      this.y += speedY-1;
    }
    // Ball is on the bottom of the platform
    else if (/*this.right >= platform.left && this.left <= platform.right &&*/
    this.top >= platform.bottom - abs(speedY))
    {
      //println("The ball is on the bottom");
      speedY = abs(speedY);
      this.y += speedY+1;
    }
  }

  void collides(ArrayList<Platform> platform_list)
  {
    for (int i = 0; i < platform_list.size(); ++i)
    {
      if (is_ball_collinding_with_platform(platform_list.get(i).x, 
        platform_list.get(i).y, platform_list.get(i).platform_width, platform_list.get(i).platform_height))
      {
        // A collision is detected between the ball and platform_list[i].
        if (platform_list.get(i).platform_image.equals("end_level.png")) 
        {
          currentUI = UIState.ENDING;
          ending_state = ENDING_STATE.WIN;
          restart = 1;
        } else if (platform_list.get(i).platform_image.equals("pu_01.png") == true) 
        { 
          this.condition1=true;
          this.skin=loadImage("ball2.png");
          //"erasing"
          platform_list.get(i).platform_image="empty.png";
          platform_list.get(i).platform_width=1;
          platform_list.get(i).platform_height=1;
        } else if (platform_list.get(i).platform_image.equals("pu_02.png") == true) 
        {
          this.condition2=true;
          /*
                   things, like enabling the kamehameha
           */
        } else if (platform_list.get(i).platform_image.equals("empty.png") == true) 
        {
          /* nothing */
        } else 
        {
          update_position_collision(platform_list.get(i));
        }
        
      }
    }
  }

  void check_loose()
  {
    if (this.y >= SCREEN_HEIGHT || nb_lives <= 0)
    {
      println("--Lose");
      currentUI = UIState.ENDING;
      ending_state = ENDING_STATE.GAME_OVER;
      restart = 1;
    }
  }
}

