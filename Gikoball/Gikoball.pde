PFont f;
String typing = "";
String userName = "";

// Greeting
int starting_greeting_time;
int count_down_greeting_launched = 0; 

// STORY
PImage img_story;

// Story count down
int story_countdown;
int starting_time;
int count_down_story_launched = 0; 

// Story String
String story1 = "-C'mon Goku! The earth needs you!";

String story2 = "-We don't have the whole day!\n"+
"Freezer's minions have been hanging \n"+
"around freely and making a mess over\n"+
"here. You are the only one who can \n"+
"stop them. So get up on The Nimbus \n"+
"Cloud and go to the city to get rid\n"+
"of the cruel minions. \n"+
"Take care, even being you this will\n"+
"be a hard task.\n";


String story3 = "-What?! Broken?! How a magic cloud\n"+ 
"can be broken...?\n"+
"Okay okay, then it will be even harder!\n"+
"You have to bounce around trying not \n"+
"fall into the ground's holes those \n"+
"guys made. It will be okay if you \n"+
"bounce in the ground or in the \n"+
"buildings but it's not a great idea\n"+
"to touch the enemies... Better to \n"+
"kick them out!\n";

String story4 = "-Remember to collect food and Staffs\n"+
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

Platform[] platform_list = new Platform[2];//needs to be for the f*cking initializ of ball
int nb_collisions = 0;

UIState currentUI = UIState.GAME; //change to welcome to get the intro, GAME to get into the game directly
Welcome welcome = new Welcome();
Background background = new Background();
Ball theBall = new Ball(50, 100, 25/*, skinBall*/);


/* 
 * Ending screen
 */
PImage congratulations_screen;
PImage gameover_screen;
Ending ending;

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;
int shift = 0;
int level_length=1600; //just to initialize


void setup() 
{
  level = loadTable(level_file, "header");
  int n_platforms=level.getRowCount()-2;//-2 title and length
  platform_list = new Platform[n_platforms];

  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  f = createFont("Arial", 32, true);
  img_story = loadImage("roshi.png");
  img_background = loadImage("background.jpg");
  img_floor = loadImage("floor.png");
  green_platform = loadImage("green_platform.png");
  red_platform = loadImage("red_platform.png");
  theBall.setSkin(loadImage("ball.png"));
  //skinBall = loadImage("ball.png");

  TableRow row = level.getRow(0);
  level_length = row.getInt("x");

  for (int i=1; i<=n_platforms; i++) {
    row = level.getRow(i);
    int x = row.getInt("x");
    int y = row.getInt("y");
    int platform_height = row.getInt("platform_height");
    int platform_width = row.getInt("platform_width");
    String platform_image = row.getString("platform_image");
    println(i+" "+x+" "+y+" "+platform_height +" "+platform_width);

    platform_list[i-1] = new Platform(x, y, platform_width, platform_height, platform_image);

    // ENDING SCREEN
    congratulations_screen = loadImage("congratulations.jpg");
    gameover_screen = loadImage("gameover.jpg");
    ending = new Ending(gameover_screen);
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
  println(t);
  if (t >= 6)
  {
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

  if (story_countdown <= 7) 
  {
    story_countdown = (millis() - starting_time) / 1000;

    f = createFont("Arial", 16, true);

    if (story_countdown < 1)
      text(story1, 400 - 300, 100);
    else if (story_countdown >= 2 && story_countdown < 3)
    {
      text(story1, 400 - 300, 100);
      text(story2, 400 - 300, 150);
    } else if (story_countdown >= 4 && story_countdown < 5)
    {
      text(story3, 400 - 300, 100);
    } else
    {
      text(story4, 400 - 300, 100);
    }
  } else
  {
    currentUI = UIState.GAME;
    println("game launched");
  }
  f = createFont("Arial", 32, true);
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
    if (theBall.x > 650) {    
      if (shift + 800<level_length) {
        if (theBall.x > 750)
          theBall.setX(750);          
        if (theBall.speedX<0) //scroll if it is moving forward 
          shift+=abs(theBall.speedX);
      }
    } else if (theBall.x < 150) {      
      if (shift > 0) {
        if (theBall.x < 50)
          theBall.setX(50);
        if (theBall.speedX>0) //scroll if it is moving backward 
          shift-=abs(theBall.speedX);
      }
    }

    theBall.draw(platform_list, shift);

    for (int i = 0; i < platform_list.length; ++i)
      platform_list[i].draw(shift);
    break;
  case ENDING:
    ending.draw();
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
  }
}

