class Score
{
    int currentScore;
    int animation;
    IntList scoreAnimation; //i=score, i+1=x, i+2=y, i+3=timer
    IntList lifeUpAnimation;
    int scoreNeeded; //score needed for addtional lives

    Score()
    {
        currentScore = 0;
        animation = 0;
        scoreAnimation = new IntList();
        lifeUpAnimation = new IntList();
        scoreNeeded = 100;
    }
    void printScore(Ball theBall)
    {
        text("Score: "+currentScore, 10, 10);
        text("Lives left: "+theBall.nb_lives, 10, 30);
        animScore();
        if(currentScore >= scoreNeeded)
        {
            theBall.nb_lives = theBall.nb_lives + (currentScore-scoreNeeded+100)/100;
            addLife((currentScore - scoreNeeded + 100)/100, (int)theBall.x+42, (int)theBall.y+10);
            scoreNeeded = currentScore + 100-currentScore%100;
        }
        animLifeUp();
    }
    void addScore(int addScore, int x, int y)
    {
        currentScore += addScore;
        scoreAnimation.append(addScore);
        scoreAnimation.append(x);
        scoreAnimation.append(y);
        scoreAnimation.append(42);//time during which the animation will last
    }
    void animScore()
    {
        int i;
        //int currentAnim = 1;
        for(i=0;i<scoreAnimation.size();i=i+4)
        {
            text("+"+scoreAnimation.get(i)+"!",scoreAnimation.get(i+1),scoreAnimation.get(i+2));
            scoreAnimation.set(i+2,scoreAnimation.get(i+2)-1); //the score slowly goes up
            scoreAnimation.set(i+3,scoreAnimation.get(i+3)-1); //the timer goes down
            if(scoreAnimation.get(i+3) == 0)
            {
                scoreAnimation.remove(i);
                scoreAnimation.remove(i);
                scoreAnimation.remove(i);
                scoreAnimation.remove(i);
                i-=4;
            }
        }
    }
    void addLife(int addLife, int x, int y)
    {
        lifeUpAnimation.append(addLife);
        lifeUpAnimation.append(x);
        lifeUpAnimation.append(y);
        lifeUpAnimation.append(42);//time during which the animation will last
    }
    void animLifeUp()
    {
        int i;
        //int currentAnim = 1;
        for(i=0;i<lifeUpAnimation.size();i=i+4)
        {
            text("Life Up!: "+lifeUpAnimation.get(i)+"!",lifeUpAnimation.get(i+1),lifeUpAnimation.get(i+2));
            lifeUpAnimation.set(i+2,lifeUpAnimation.get(i+2)-1); //the score slowly goes up
            lifeUpAnimation.set(i+3,lifeUpAnimation.get(i+3)-1); //the timer goes down
            if(scoreAnimation.get(i+3) == 0)
            {
                lifeUpAnimation.remove(i);
                lifeUpAnimation.remove(i);
                lifeUpAnimation.remove(i);
                lifeUpAnimation.remove(i);
                i-=4;
            }
        }
    }
}
