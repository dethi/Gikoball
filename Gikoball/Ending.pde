class Ending
{
  PImage ending_screen;
  Ending(PImage screen)
  {
    this.ending_screen = screen;
  }

  void draw()
  {
    image(ending_screen, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  }

  void keyPressed()
  {
    if (key == 's')
    {
      currentUI = UISTATE.WELCOME;
    }
  }
}

