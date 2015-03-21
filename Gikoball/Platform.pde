class Platform
{
  /* x and y are the origin of the platform
   * The origin is the bottom left corner
   */
  float x, y;

  /* Explicit enough. Just added platform before because height and weight
   * are some global variable. I love processing...
   */

  float platform_height;
  float platform_width;


  // Sprite of the platform
  PImage platform_image;

  // Contructor of the object platform
  Platform(float x, float y, float platform_weight, float platform_height, 
  PImage platform_image)
  {
    this.x = x;
    this.y = y;
    this.platform_height = platform_height;
    this.platform_width = platform_width;
    this.platform_image = platform_image;
  }

  void draw()
  {
    image(this.platform_image, this.x, this.y);
  }
}

