class Platform
{
  /* x and y are the origin of the platform
   * The origin is the top left corner
   */
  float x, y;

  /* Explicit enough. Just added platform before because height and weight
   * are some global variable. I love processing...
   */

  float platform_height;
  float platform_width;
  
  /* Explicit names.
  * Will be used for make collisions easier
  */
  float left;
  float right;
  float top;
  float bottom;
  // Sprite of the platform
  PImage platform_image;

  // Contructor of the object platform
  Platform(float x, float y, float platform_width, float platform_height, 
  PImage platform_image)
  {
    this.x = x;
    this.y = y;
    this.platform_height = platform_height;
    this.platform_width = platform_width;
    this.platform_image = platform_image;
    
    left = x;
    right = x + platform_width;
    top = y;
    bottom = y + platform_height;
  }

  void draw()
  {
    image(this.platform_image, this.x, this.y);
  }
}

