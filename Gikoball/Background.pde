class Background
{

    // Constructor
    Background()
    {
    }
    void draw()
    {
        image(img_background, 0,0);
        image(img_floor, 0, 425);
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

