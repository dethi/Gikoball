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
  PImage skin;

  Enemy2(float x, float y, float enemy_width, float enemy_height, 
  PImage skin)
  {
    // Coordonnates
    this.x = x;
    this.y = y;
    this.enemy_height = enemy_height;
    this.enemy_width = enemy_width;
    // Sprite
    this.skin = skin;

    // Positions for collisions
    left = x - radius;
    right = x + radius;
    top = y - radius;
    bottom = y + enemy_height;
    velocity_y = 0;
    this.radius = this.enemy_width / 2;
    to_remove = false;
  }

  void update(ArrayList<Platform> platform_list, Ball ball, Attack atk_ki)
  {
    update_position(platform_list);
    // COLLISION WITH THE PLAYER
    if (check_collision_with_player(ball.x, ball.y, ball.radius))
    {
      println("2");
      to_remove = true;
      --ball.nb_lives;
      println("--coliEn");
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
        image(this.skin, x - radius - shift, y - radius, radius*2, radius*2);
  }

  void update_position(ArrayList<Platform> platform_list)
  {
    for (int i = 0; i < platform_list.size (); ++i)
    {
      if (check_collision_for_rectangle(platform_list.get(i).x, 
      platform_list.get(i).y, 
      platform_list.get(i).platform_width, 
      platform_list.get(i).platform_height))
        velocity_y = -10;
    }
    velocity_y += gravity_power;
    this.y += velocity_y;
    
    right = x + radius;
    left = x - radius;
    top = y - radius;
    bottom = y + radius;    
  }

  boolean check_collision_with_player(float ball_x, float ball_y, float ball_radius)
  {
    if (dist(this.x, this.y, ball_x+ shift, ball_y) <= (ball_radius +  this.radius))
    {
      println("this x"+x+"this.y"+y+"ball_x"+ball_x + shift+"ball_y"+ball_y);
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

    if (distance_x > (platform_width / 2 + this.radius))
      return false;
    if (distance_y > (platform_height/2 + this.radius)) 
      return false;
    if (distance_x <= (platform_width/2))
      return true;
    if (distance_y <= (platform_height/2))
      return true;


    float corner_distance_sq = pow(distance_x - platform_width / 2, 2) +
      pow(distance_y - platform_height / 2, 2);

    return (corner_distance_sq <= pow(radius, 2));
  }
}

