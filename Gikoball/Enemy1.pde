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
  String enemy_image;

  Enemy1(float x, float y, float enemy_width, float enemy_height, 
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

    // Relevant for fights
    number_hp = 3;
    is_attacking = false;
  }

  // If the enemy and the ball are close enough, the enemy will attack
  void update_is_attacking(float ball_x)
  {
    if (abs(ball_x - this.x) <= (SCREEN_WIDTH / 2))
      is_attacking = true;
    else  
      is_attacking = false;
  }

  void draw(int shift)
  {
    update();
    image(loadImage(this.enemy_image), this.x - shift, this.y, this.enemy_width, this.enemy_height);
  }

  void update(float ball_x)
  {
    update_is_attacking(ball_x);
  }

  void attack(float ball_x)
  {
    if (is_attacking)
    {
      if (ball_x < this.x)
        ;// Attack left
      else
        ;// Attack right
    }
  }

  void fire(int direction)
  {
    /*
     * If direction ==  0 then fire_to_left
     *   Else if direction == 1 then fire_to_right
     * Else, f*ck off
     */
    if (direction == 1)
    {
      // New bullet on the left
      // Give velocity to the bullet
    } else
    {
      // new bullet on the right
      // Give velocity to the bullet
    }
  }
}

