
class Background
{
  int shift =0;
    // Constructor
    Background()
    {
    }
    void draw()
    {
        image(img_background, 0,0);
        image(img_floor, 0, 425);
        
        if (keyPressed) {
            if(key=='a'||key=='A')
              shift--;
            if(key=='d'||key=='D')
              shift++;   
        }
        
        //example piece of level
        rect(0-shift, 550, 400, 50);
        rect(500-shift, 550, 400, 50);
        rect(0-shift, 300, 200, 50);   
        rect(400-shift, 400, 200, 50); 
        rect(700-shift, 200, 200, 50);     
    }

    void keyPressed()
    {
        if (key == ENTER || key == RETURN)
        {
        }
        if (key != CODED)
        {
        }
    }
}

