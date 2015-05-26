class Ending
{
    PImage ending_screen;

    Ending(PImage screen)
    {
        this.ending_screen = screen;
    }

    void draw(Score score, String userName)
    {
        image(ending_screen, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        text("Your finished with a score of:",0,275);
        text(userName+ ": " + score.currentScore,0,300);
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

