class Score
{
  int currentScore;
  int animation;
  IntList scoreAnimation; //i=score, i+1=x, i+2=y, i+3=timer
  
  Score()
  {
    currentScore = 0;
    animation = 0;
    scoreAnimation = new IntList();
  }
  void printScore()
  {
    text("Score: "+currentScore, 10, 10);
    animScore();
  }
  void addScore(int addScore, int x, int y)
  {
    currentScore += addScore;
    scoreAnimation.append(addScore);
    scoreAnimation.append(x);
    scoreAnimation.append(y);
    scoreAnimation.append(10);//time during which the animation will last
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
}
/*if (bullet_list.size() < nb_max_bullets)
      {
        bullet_list.add(new Bullet(this.x - 100, this.y, 50.0, 25.0, 
        "bullet.png", (-9.0)));
      }
    } else
    {
      if (bullet_list.size() < nb_max_bullets)
      {
        bullet_list.add(new Bullet(this.x + 100, this.y, 50.0, 25.0, 
        "bullet.png", (9.0)));
      }
    }
  }

  void remove_bullets()
  {
    for (int i = 0; i < bullet_list.size (); ++i)
    {
      if (bullet_list.get(i).to_remove)
        bullet_list.remove(i);*/
