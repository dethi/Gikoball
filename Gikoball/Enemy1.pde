class Enemy1
{
  //Attributs
  float x;
  float y;
  float left;
  float right;
  float top;
  float bottom;
  int number_of_lives;
  float enemy_width;
  float enemy_height;
  boolean is_attacking;
  String enemy_image;

  Enemy1(float x, float y, float enemy_width, float enemy_height, 
  String enemy_image)
  {
    this.x = x;
    this.y = y;
    this.enemy_height = enemy_height;
    this.enemy_width = enemy_width;
    this.enemy_image = enemy_image;

    left = x;
    right = x + enemy_width;
    top = y;
    bottom = y + enemy_height;
  }
  
}

