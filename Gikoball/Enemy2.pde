class Enemy2
{
  //Attributs
  float x;
  float y;
  float left;
  float right;
  float top;
  float bottom;
  int number_hp;
  float enemy_width;
  float enemy_height;
  boolean is_attacking;
  String enemy_image;
  float speed_y;
  float gravityPower = 0.97;
  int WEIGHT = 50;
  float velocity_y;

  Enemy2(float x, float y, float enemy_width, float enemy_height, 
  String enemy_image)
  {
    // Coordonnates
    this.x = x;
    this.y = y;
    this.enemy_height = enemy_height;
    this.enemy_width = enemy_width;
    // Sprite
    this.enemy_image = enemy_image;

    // Positions for collisions
    left = x;
    right = x + enemy_width;
    top = y;
    bottom = y + enemy_height;
    velocity_y = 0;
  }

  void update(Platform[] platforms, float ball_x, float ball_y)
  {
    //UpdatePosition -> Gravity -> Will infinitly bounces -> Use check_collision_with_rectangle
    //CheckCollisionWithPlayer -> If hits player, player dies
    //CheckCOllisionWithPlayer'sBullet -> if hit but a player's bullet, will be removed -> Use check_collision_with_rectangle
  }

  void draw(int shift)
  {
    image(loadImage(this.enemy_image), this.x - shift, this.y, this.enemy_width, this.enemy_height);
  }

  void update_position(Platform[] platforms)
  {
     //If collisions with top platform -> bounce -> velocityY = -10;
     //Else : velocityY += gravity_power;   
  }
  
  boolean check_collision_with_player(float ball_x, float ball_y, float ball_radius)
  {
    if(dist(this.x, this.y, ball_x, ball_y) <= (ball_radius + this.radius))
       return true; 
  }
  
  boolean check_collision_with_rectangle(
  float rectangleX, 
  float rectangleY, 
  float rectangle_width, 
  float rectangle_height)
  {
    float distance_x = abs((this.x + this.rectangle_width / 2) - rectangleX - rectangle_width / 2);
    float distance_y = abs((this.y + this.rectangle_height / 2) - rectangleY - platform_height / 2);

    if (distance_x > (rectangle_width / 2 + this.rectangle_width/2))
      return false;
    if (distance_y > (rectangle_height / 2 + this.rectangle_height/2)) 
      return false;
    if (distance_x <= (rectangle_width/2))
      return true;
    if (distance_y <= (rectangle_height/2))
      return true;

    float corner_distance_sq = pow(distance_x - rectangle_width / 2, 2) +
      pow(distance_y - rectangle_height / 2, 2);

    return (corner_distance_sq <= pow(this.rectangle_width / 2, 2));
  }
}
