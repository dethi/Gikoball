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
int nb_platforms;

Table level;

Platform[] platform_list = new Platform[2];//needs to be for the f*cking initializ of ball
int nb_collisions = 0;

/*
* Comment / uncomment on of both for debugging or presentation
 */
//UIState currentUI = UIState.WELCOME;
UIState currentUI = UIState.GAME;
Welcome welcome = new Welcome();
Background background = new Background();
Ball theBall = new Ball(50, 100, 25/*, skinBall*/);
Attack atk_ki = new Attack(100, 100, 30, 30, "atk_ki.png");

/**********************************************
 ***              Enemies stuff             ***
 **********************************************/
PImage enemy1_image;
PImage enemy2_image;
PImage bullet_image;

Enemy1[] enemy1_list;
int nb_enemies1 = 2;

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
  level = loadTable(level_file, "header");
  int n_lines=level.getRowCount();
  platform_list = new Platform[n_lines - 1];//-1 for length
  nb_platforms = 0;
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
  //skinBall = loadImage("ball.png");

  enemy1_list = new Enemy1[10];
  TableRow row = level.getRow(0);
  level_length = row.getInt("x");
  println(level_length);

  int enemy_shift = 0;
  for (int i=1; i< n_lines; i++)
  {
    println("line number " + (i) + " is read");
    row = level.getRow(i);
    int x = row.getInt("x");
    int y = row.getInt("y");
    int platform_height = row.getInt("platform_height");
    int platform_width = row.getInt("platform_width");
    String platform_image = row.getString("platform_image");
    //println(i+" "+x+" "+y+" "+platform_height +" "+platform_width);
    //println(i);
    if (platform_image.equals("enemy1.png") == false && platform_image.equals("enemy2.png") == false)
    {
      platform_list[i - 1 - enemy_shift] = new Platform(x, y, platform_width, platform_height, platform_image);
      ++nb_platforms;
    } else
      ++enemy_shift;
  }

  // Load the enemy1 only
  int platform_shift = 0;
  for (int i = 1; i < n_lines; ++i)
  {
    println("line number " + i + " is read");
    row = level.getRow(i);
    int x = row.getInt("x");
    int y = row.getInt("y");
    int enemy_height = row.getInt("platform_height");
    int enemy_width = row.getInt("platform_width");
    String enemy_image = row.getString("platform_image");
    if (enemy_image.equals("enemy1.png"))
    {
      enemy1_list[i - 1 - platform_shift] = new Enemy1(x, y, enemy_width, enemy_height, enemy_image);
      println(i - platform_shift + "new enemy1 loaded at index "+ (i-1 - platform_shift));
    } else
      ++platform_shift;
  }

  // ENDING SCREEN
  congratulations_screen = loadImage("congratulations.jpg");
  gameover_screen = loadImage("gameover.jpg");
  ending = new Ending(gameover_screen);
  ending_state = ENDING_STATE.GAME_OVER;
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
    theBall.check_loose();
    theBall.draw(platform_list, shift);
    if (atk_ki.thrown)
      atk_ki.draw(platform_list, shift);

    for (int i = 0; i < nb_platforms; ++i)
      platform_list[i].draw(shift);
    for (int i = 0; i < nb_enemies1; ++i)
    {
      enemy1_list[i].draw(shift, theBall.x);
    }
    break;
  case ENDING:
    if (ending_state == ENDING_STATE.GAME_OVER)
      ending.ending_screen = gameover_screen;
    else
      ending.ending_screen = congratulations_screen;
    ending.draw();
    shift = 0;
    theBall.speedX = 0;
    theBall.speedY = 0;
    theBall.x = 30;
    theBall.y = 100;
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

