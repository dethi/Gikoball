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
        {class Ending
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
          currentUI = UIState.GAME;
          atk_ki.remove();
          theBall.reborn();
          load_level(level_file);
          println("Restarted");
        }
    }
}
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
          currentUI = UIState.GAME;
          atk_ki.remove();
          theBall.reborn();
          load_level(level_file);
          println("Restarted");
        }
    }
}

          currentUI = UIState.GAME;
          atk_ki.thrown = false;
          theBall.reborn();
          load_level(level_file);
          println("Restarted");
        }
    }
}

