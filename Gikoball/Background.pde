class Background
{
  int shift =0;
  // Constructor
  Background()
  {
  }
  void draw()
  {
    image(img_background, 0, 0);
    image(img_floor, 0, 425);

    if (keyPressed) {
      if (key=='a'||key=='A')
        shift--;
      if (key=='d'||key=='D')
        shift++;
    }
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

