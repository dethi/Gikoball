class Platform
{

  /* x and y are the origin of the platform
   * The origin is the bottom left corner
   */
  int x, y;

  /* Explicit enough. Just added platform before because height and weight
   * are some global variable. I love processing...
   */

  int platform_height;
  int platform_width;

  // Here are some explicit variables to make easier the collision
  int left;
  int right;
  int top;
  int bottom;

  // Sprite of the platform
  PImage platform_image;

  // Contructor of the object platform
  Platform(int x, int y, int platform_weight, int platform_height, 
  PImage platform_image)
  {
    this.x = x;
    this.y = y;
    this.platform_height = platform_height;
    this.platform_width = platform_width;
    this.platform_image = platform_image;

    this.left = x;
    this.right = x + platform_width;
    this.top = y + platform_height;
    this.bottom = y;
  }

  // This function check if a given point is included into a platform
  boolean is_point_inside(int x_point, int y_point)
  {
    if (x_point <= this.right && x_point >= this.left && // Test the x position
    y_point <= this.top && y_point >= this.bottom)       // Test the y position
      return true;
    else
      return false;
  }
  
  void draw()
  {
     image(this.platform_image, this.x, this.y); 
  }
}

