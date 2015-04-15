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
  float gravity_power = 0.97;
  int WEIGHT = 50;
  float velocity_y;
  float radius;
  boolean to_remove;

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
    this.radius = this.enemy_width / 2;
    to_remove = false;
  }

  void update(Platform[] platforms, int nb_platforms, Ball ball, Attack atk_ki)
  {
    update_position(platforms, nb_platforms);
    // COLLISION WITH THE PLAYER
    if (check_collision_with_player(ball.x, ball.y, ball.radius))
    {
      to_remove = true;
      --ball.nb_lives;
    }

    // COLLISION WITH KII PLAYER
    if (check_collision_for_rectangle(atk_ki.x, atk_ki.y, atk_ki.atk_width, atk_ki.atk_height))
    {
      to_remove = true;
      atk_ki.thrown = false;
    }
  }

  void draw(int shift)
  {
    image(loadImage(this.enemy_image), this.x - shift, this.y, this.enemy_width, this.enemy_height);
  }

  void update_position(Platform[] platforms, int nb_platforms)
  {
    for (int i = 0; i < nb_platforms; ++i)
    {
      if (check_collision_for_rectangle(platforms[i].x, 
      platforms[i].y, 
      platforms[i].platform_width, 
      platforms[i].platform_height))
        velocity_y = -10;
    }
    velocity_y += gravity_power;
    this.y += velocity_y;
  }

  boolean check_collision_with_player(float ball_x, float ball_y, float ball_radius)
  {
    println("blue ball .x = " +x);
    println("theball.x = "+ball_x);
    if (dist(this.x, this.y, ball_x, ball_y) <= (ball_radius +  this.radius / 4))
    {
      println("has hit"); 
      return true;
    } else
      return false;
  }

  boolean check_collision_for_rectangle(
  float rectangleX, 
  float rectangleY, 
  float platform_width, 
  float platform_height)
  {
    float distance_x = abs(this.x - rectangleX - platform_width / 2);
    float distance_y = abs(this.y - rectangleY - platform_height / 2);

    if (distance_x > (platform_width / 2 + this.radius * 2))
      return false;
    if (distance_y > (platform_height/2 + this.radius * 2)) 
      return false;
    if (distance_x <= (platform_width/2))
      return true;
    if (distance_y <= (platform_height/2))
      return true;


    float corner_distance_sq = pow(distance_x - platform_width/2, 2) +
      pow(distance_y - platform_height/2, 2);

    return (corner_distance_sq <= pow(radius, 2));
  }
}

