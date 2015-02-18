class Ball
{
  int x, y;
 
  Ball(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
    void keyPressed() {
      if(key == CODED)
      {
        if(keyCode == LEFT)
        {
          this.x = this.x - 5;
        }
        if(keyCode == RIGHT)
        {
          this.x = this.x + 5;
        }
      }
    }
  
    void draw() {
    ellipse(this.x, this.y, 50, 50); //need a sprite
  }
}
