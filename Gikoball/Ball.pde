class Ball
{
  int x, y;
  int speedUp, speedDown;
  int naturalGravity;
  int timeStop = 0;
  int stateBall; // 1 is going down, 2 going up
  
 
  Ball(int x, int y) {
    this.x = x;
    this.y = y;
    speedDown = 1;
    speedUp = 0;
    naturalGravity = 1;
    stateBall = 1;
  }
  
    void keyPressed() {
      if(key == CODED)
      {
        if(keyCode == LEFT)
        {
          this.x = this.x - 2;
        }
        if(keyCode == RIGHT)
        {
          this.x = this.x + 2;
        }
        if(keyCode == DOWN)
        {
          if(this.stateBall == 2)//decelerates the ball when going up
            speedUp+= -1;
          if(this.stateBall == 1)//accelerates the ball when going down
            speedDown+= 2;
        }
        if(keyCode == UP)
        {
        }
      }
    }
    
    void Gravity(){
      timeStop++;
      if(timeStop == 10)
      {
        timeStop = 0;
        //if(this.stateBall == 2)
        speedUp += -naturalGravity;
        //if(this.stateBall == 1)
        speedDown += naturalGravity;
      }
      
      if(this.y >= 425) //or change this to a method that gets the collision with the floor, set to screen height for now
      {
        speedUp = (int)(0.99*speedDown); //no infinite bounce, the ball gradually slows down
        this.stateBall = 2;
      }
      if(this.stateBall == 2)
      if(speedUp <= 0)
      {
        this.stateBall = 1;
        speedDown = 0;
      }
      
        if(this.stateBall == 1)
          this.y = this.y + speedDown;
        else if(this.stateBall == 2)
                this.y = this.y - speedUp;
    }
  
    void draw() {
    Gravity();
    ellipse(this.x, this.y, 50, 50); //need a sprite
  }
}
