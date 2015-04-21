PFont f;
String typing = "";
String userName = "";

// Greeting
int starting_greeting_time;
int count_down_greeting_launched = 0; 

// STORY
PImage img_story;

int restart = 0;

// Story count down
int story_countdown;
int starting_time;
int count_down_story_launched = 0; 

// Story String
String story1 = "- C'mon Goku! The earth needs you!";

String story2 = "- We don't have the whole day!\n"+
"Freezer's minions have been hanging \n"+
"around freely and making a mess over\n"+
"here. You are the only one who can \n"+
"stop them. So get up on The Nimbus \n"+
"Cloud and go to the city to get rid\n"+
"of the cruel minions. \n"+
"Take care, even being you this will\n"+
"be a hard task.\n";

String story3 = "- What?! Broken?! How a magic cloud\n"+ 
"can be broken...?\n"+
"Okay okay, then it will be even harder!\n"+
"You have to bounce around trying not \n"+
"fall into the ground's holes those \n"+
"guys made. It will be okay if you \n"+
"bounce in the ground or in the \n"+
"buildings but it's not a great idea\n"+
"to touch the enemies... Better to \n"+
"kick them out!\n";

String story4 = "- Remember to collect food and Staffs\n"+
"to power yourself up! I should teach\n"+
"you more fighting techniques, but we\n"+
"don't have time right now!!! So if we\n"+
"meet in the city I will teach you then!\n";

// BACKGROUND 
PImage img_background;
PImage img_floor;
//PImage skinBall;

/**********************************************
 ***              platforms stuff            ***
 **********************************************/

/* Platform sprites
 * The platform names and looking and temporary.
 */
PImage green_platform;
PImage red_platform;
String level_file="level_1.csv"; 

Table level;

ArrayList<Platform> platform_list = new ArrayList<Platform>();//needs to be for the f*cking initializ of ball

/*
* Comment / uncomment on of both for debugging or presentation
 */
//UIState currentUI = UIState.WELCOME;
UIState currentUI = UIState.GAME;
Welcome welcome = new Welcome();
Score score = new Score();
Background background = new Background();
Ball theBall = new Ball(50, 100, 25/*, skinBall*/);
Attack atk_ki = new Attack(100, 100, 30, 30, "atk_ki.png");

/**********************************************
 ***              Enemies stuff             ***
 **********************************************/
PImage enemy1_image;
PImage enemy2_image;
PImage bullet_image;

ArrayList<Enemy1> enemy1_list=new ArrayList<Enemy1>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy2> enemy2_list = new ArrayList<Enemy2>();

/* 
 * Ending screen
 */
PImage congratulations_screen;
PImage gameover_screen;
Ending ending;
ENDING_STATE ending_state;

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;
int shift = 0;
int level_length=1600; //just to initialize


void setup() 
{
  load_level(level_file);  
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  f = createFont("Arial", 32, true);
  img_story = loadImage("roshi.png");
  img_background = loadImage("background2.jpg");
  img_floor = loadImage("floor.png");
  green_platform = loadImage("green_platform.png");
  red_platform = loadImage("red_platform.png");
  theBall.setSkin(loadImage("ball.png"));
  enemy1_image = loadImage("enemy1.png");
  enemy2_image = loadImage("enemy2.png");
  bullet_image = loadImage("bullet.png");

  // ENDING SCREEN
  congratulations_screen = loadImage("congratulations.jpg");
  gameover_screen = loadImage("gameover.jpg");
  ending = new Ending(gameover_screen);
  ending_state = ENDING_STATE.GAME_OVER;
}

void load_level(String level_f) {  
  platform_list = new ArrayList<Platform>();
  enemy1_list=new ArrayList<Enemy1>();
  bullets = new ArrayList<Bullet>();
  enemy2_list = new ArrayList<Enemy2>();

  level = loadTable(level_f, "header");

  TableRow row = level.getRow(0);
  level_length = row.getInt("x");
  println(level_length);

  for (int i=1; i< level.getRowCount (); i++)
  {
    println("line number " + (i) + " is read");
    row = level.getRow(i);
    int x = row.getInt("x");
    int y = row.getInt("y");
    int p_height = row.getInt("platform_height");
    int p_width = row.getInt("platform_width");
    String p_image = row.getString("platform_image");
    if (p_image.equals("enemy1.png") == false && p_image.equals("enemy2.png") == false)
    {
      println("platform");
      platform_list.add(new Platform(x, y, p_width, p_height, loadImage(p_image), p_image));
    } else if (p_image.equals("enemy1.png"))
    {
      println("enemy1");
      enemy1_list.add(new Enemy1(x, y, p_width, p_height, loadImage(p_image)));
    } else if (p_image.equals("enemy2.png")) 
    {
      println("enemy2");
      enemy2_list.add(new Enemy2(x, y, p_width, p_height, loadImage(p_image)));
    }
  }
}

void draw_menu_greeting()
{
  int t;

  if (count_down_greeting_launched == 0)
    launch_greeting_countdown();

  background(0);

  fill(250);
  text("Hi "+userName+"!\n", 400 - 50, 100);

  t = (millis() - starting_greeting_time) / 1000;
  //println(t);
  if (t >= 6) {
    currentUI = UIState.STORY;
    println("Story launched");
  }
}

void launch_greeting_countdown()
{
  count_down_greeting_launched = 1;
  starting_greeting_time = millis();
}


void launch_story_countdown()
{
  starting_time = millis();
  count_down_story_launched = 1;
  story_countdown = 0;
}


void draw_story()
{
  image(img_story, 0, 0);

  if (count_down_story_launched == 0)
    launch_story_countdown();

  if (story_countdown <= 30) {
    story_countdown = (millis() - starting_time) / 1000;

    f = createFont("Arial", 16, true);

    if (story_countdown < 3)
      text(story1, 400 - 300, 100);
    else if (story_countdown >= 4 && story_countdown < 12)
    {
      text(story1, 400 - 300, 100);
      text(story2, 400 - 300, 150);
    } else if (story_countdown >= 13 && story_countdown < 22)
    {
      text(story3, 400 - 300, 100);
    } else if (story_countdown >= 23)
    {
      text(story4, 400 - 300, 100);
    }
  } else {
    currentUI = UIState.GAME;
    println("game launched");
    if (restart == 1)
    {
      println("restart");
      theBall.x = 50;
      theBall.y = 100;
      restart = 0;
      theBall.nb_lives=1;
    }
  }
  f = createFont("Arial", 32, true);
}

void scrolling() //maybe in another class instead of a function?
{
  if (theBall.x > 550) {    
    if (shift + 800<level_length) {
      if (theBall.speedX<0) //scroll if it is moving forward
      {
        shift+=abs(theBall.speedX);
        theBall.setX(theBall.getX() + theBall.speedX);
      }
    }
  } else if (theBall.x < 250) {      
    if (shift > 0) {
      if (theBall.speedX>0) //scroll if it is moving backward
      {
        shift-=abs(theBall.speedX);   
        theBall.setX(theBall.getX() + theBall.speedX);
      }
    }
  }
}

void update_bullet_list()
{
  for (int i = 0; i < enemy1_list.size (); ++i)
  {
    for (int j = 0; j < enemy1_list.get (i).bullet_list.size(); ++j)
    {
      if (!enemy1_list.get(i).bullet_list.get(j).has_reached)
        bullets.add(enemy1_list.get(i).bullet_list.get(j));
    }
  }
}

void remove_bullet_list()
{
  for (int j = bullets.size () - 1; j >= 1; --j)
    bullets.remove(j);
}

void remove_enemy2()
{
  for (int i = 0; i < enemy2_list.size (); i++)
  {
    if (enemy2_list.get(i).to_remove)
    {
      score.addScore(100, (int)enemy2_list.get(i).x+10, (int)enemy2_list.get(i).y+10);
      enemy2_list.remove(i);
    }
  }
}

void remove_enemy1()
{
  for (int i = 0; i < enemy1_list.size (); i++)
  {
    if (enemy1_list.get(i).to_remove)
    {
      score.addScore(100, (int)enemy1_list.get(i).x+10, (int)enemy1_list.get(i).y+10);
      enemy1_list.remove(i);
    }
  }
}

void draw()
{
  if (keyPressed && currentUI == UIState.GAME)
    theBall.keyPressed();
  switch(currentUI) 
  {
  case WELCOME:
    welcome.draw();
    break;
  case GREETING:
    draw_menu_greeting();
    break;
  case STORY: 
    draw_story();
    //currentUI = UIState.GAME;
    break;
  case GAME:
    background.draw();
    scrolling();
    score.printScore(theBall);
    //score.addScore(100, int(theBall.x)+10,int(theBall.y)+10);
    theBall.check_loose();
    theBall.draw(platform_list, shift);
    if (atk_ki.thrown)
      atk_ki.draw(platform_list, shift);

    update_bullet_list();

    for (int i = 0; i < platform_list.size (); ++i)
      platform_list.get(i).draw(shift);
    for (int i = 0; i < enemy1_list.size (); ++i)
      enemy1_list.get(i).draw(shift, theBall.x, bullet_image, platform_list, atk_ki);
    for (int i = 0; i < enemy2_list.size (); ++i)
    {
      enemy2_list.get(i).draw(shift);
      enemy2_list.get(i).update(platform_list, theBall, atk_ki);
    }

    for (int i = 0; i < bullets.size (); ++i)
    {
      println("position bullet "+bullets.get(i).x);
      if (theBall.is_ball_collinding_with_platform(bullets.get(i).x - shift, bullets.get(i).y, 
      bullets.get(i).bullet_width, bullets.get(i).bullet_height))
      {
        if (!bullets.get(i).to_remove) --theBall.nb_lives;
        bullets.get(i).to_remove = true;
      }
    }
    remove_enemy1();
    remove_enemy2();
    remove_bullet_list();
    break;
  case ENDING:
    if (ending_state == ENDING_STATE.GAME_OVER)
      ending.ending_screen = gameover_screen;
    else
      ending.ending_screen = congratulations_screen;
    ending.draw();
    break;
  }
}

void keyPressed() //the method keyPressed is bullshit
{
  switch(currentUI)
  {
  case WELCOME:
    welcome.keyPressed();
    break;
  case GREETING: 
    break;
  case STORY: 
    break;
  case GAME:
    if ((key=='x'||key=='X')&& !atk_ki.thrown) {
      println("boom");
      atk_ki.thrown=true;
      atk_ki.setX(theBall.x);
      atk_ki.setY(theBall.y);
    }
    break;
  case ENDING:
    ending.keyPressed();
    break;
  }
}

void keyReleased()
{
  switch(currentUI)
  {
  case GAME:
    theBall.keyReleased();
    break;
  case ENDING:
    theBall.keyReleased();
    shift = 0;
    break;
  }
}

