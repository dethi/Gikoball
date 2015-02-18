class Ball
{
  int x, y;
 
  Ball(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
    void keyPressed() {
      if(key == LEFT)
        this.x--;
      if(key == RIGHT)
        this.x++;
    }
  
    void draw() {
    rect (this.x, this.y, 50, 50); //need a sprite
  }
}
