class Enemy1
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
  PImage skin;
  int nb_max_bullets = 3;
  int nb_bullets;
  ArrayList<Bullet> bullet_list;
  int t;
  float speed_y;  
  float gravityPower = 0.97;
  int WEIGHT = 50;
  int tmp_fire;
  boolean to_add;
  boolean to_remove;
  float radius;
  Enemy1(float x, float y, float enemy_width, float enemy_height, 
  PImage skin)
  {
    // Coordonnates
    this.x = x;
    this.y = y;
    this.enemy_height = enemy_height;
    this.enemy_width = enemy_width;
    // Sprite
    this.skin = skin;
    this.radius = enemy_width / 2;
    to_add = true;
    // Positions for collisions
    left = x;
    right = x + enemy_width;
    top = y;
    bottom = y + enemy_height;

    // Relevant for fights
    number_hp = 3;
    is_attacking = false;
    bullet_list = new ArrayList<Bullet>();
    nb_bullets = 0;
    t = 0;
    tmp_fire = 0;
    to_remove = false;
  }

  // If the enemy and the ball are close enough, the enemy will attack
  void update_is_attacking(float ball_x)
  {
    if (abs(ball_x - this.x) <= (SCREEN_WIDTH / 2))
      is_attacking = true;
    else  
      is_attacking = false;
  }

  void draw(int shift, Ball ball, PImage bullet_image, ArrayList<Platform> platform_list, Attack atk_ki)
  {
    update(ball, bullet_image);
    image(this.skin, this.x - shift, this.y, this.enemy_width, this.enemy_height);
    for (int i = 0; i < bullet_list.size (); ++i)
      bullet_list.get(i).draw(shift, platform_list);
  }

  void update(Ball ball, PImage bullet_image)
  {
    ++tmp_fire;
    update_is_attacking(ball.x);
    if (tmp_fire >= 50)
    {
      tmp_fire = 0;
      attack(ball.x + shift, bullet_image);
    }

    // COLLISION WITH THE PLAYER
    if (check_collision_with_player(ball.x, ball.y, ball.radius))
    {
      --ball.nb_lives;
      ball.check_loose();
      to_remove = true;
    }

    // COLLISION WITH KII PLAYER
    if (check_collision_for_rectangle(atk_ki.x, atk_ki.y, atk_ki.atk_width, atk_ki.atk_height))
    {
      to_remove = true;
      atk_ki.thrown = false;
    }

    remove_bullets();
  }

  void gravity()
  {
    t++;
    if (t==5)
    {
      speed_y = speed_y * gravityPower;
      t = 0;
    }

    speed_y += (9.81 * WEIGHT / 1000);
    this.y += speed_y;
  }

  void attack(float ball_x, PImage bullet_image)
  {
    if (is_attacking)
    {
      if (ball_x < this.x)
      {
        fire(0, bullet_image);// Attack left
        println("Will attack left. x= "+this.x+" ball_x : "+ball_x);
      } else
      {
        fire(1, bullet_image);// Attack right
        println("Will attack right. x= "+this.x+" ball_x : "+ball_x);
      }
    }
  }

  void fire(int direction, PImage bullet_image)
  {
    /*
     * If direction ==  0 then fire_to_left
     *   Else if direction == 1 then fire_to_right
     * Else, f*ck off
     */
    if (direction == 0)
    {
      if (bullet_list.size() < nb_max_bullets)
      {
        bullet_list.add(new Bullet(this.x - 100, this.y, 15.0, 15.0, 
        "bullet.png", (-9.0)));
      }
    } else
    {
      if (bullet_list.size() < nb_max_bullets)
      {
        bullet_list.add(new Bullet(this.x + 100, this.y, 15.0, 15.0, 
        "bullet.png", (9.0)));
      }
    }
  }

  void remove_bullets()
  {
    for (int i = 0; i < bullet_list.size (); ++i)
    {
      if (bullet_list.get(i).to_remove)
        bullet_list.remove(i);
    }
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

  boolean check_collision_with_player(float ball_x, float ball_y, float ball_radius)
  {
    if (dist(this.x, this.y, ball_x+ shift, ball_y) <= (ball_radius +  this.radius))
      return true;
    else
      return false;
  }
}

