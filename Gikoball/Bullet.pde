class Bullet
{
  // Postions
  float x;
  float y; 
  float left;
  float right;
  float top;
  float bottom;
  float bullet_width;
  float bullet_height;
  String bullet_image;

  float velocity_x;
  boolean has_reached;
  boolean to_remove;

  Bullet(float x, float y, float bullet_width, float bullet_height, 
  String bullet_image, float velocity)
  {
    // Coordonnates
    this.x = x;
    this.y = y;
    this.bullet_height = bullet_height;
    this.bullet_width = bullet_width;
    // Sprite
    this.bullet_image = bullet_image;

    // Positions for collisions
    left = x;
    right = x + bullet_width;
    top = y;
    bottom = y + bullet_height;

    velocity_x = velocity;
    has_reached = false;
    to_remove = false;
  }
  
    void draw(int shift)
  {
    update();
    //image(loadImage(this.enemy_image), this.x - shift, this.y, this.enemy_width, this.enemy_height);
  }
  
  void update()
  {
   if(has_reached)
    to_remove = true; 
  }
}

