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


UIState currentUI = UIState.WELCOME; //change to welcome to get the intro, GAME to get into the game directly
Welcome welcome = new Welcome();
Background background = new Background();
Ball theBall = new Ball(0, 0);

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

void setup() 
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  f = createFont("Arial", 32, true);
  img_story = loadImage("roshi.png");
  img_background = loadImage("background.jpg");
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

  if (story_countdown <= 15)
  {
    story_countdown = (millis() - starting_time) / 1000;

    f = createFont("Arial", 16, true);
    
    if (story_countdown < 4)
      text(story1, 400 - 300, 100);
    else if (story_countdown >= 4 && story_countdown < 8)
    {
      text(story1, 400 - 300, 100);
      text(story2, 400 - 300, 150);
    } else if (story_countdown >= 8 && story_countdown < 12)
    {
      background(0);

      text(story3, 400 - 300, 100);
    } else
    {
      background(0);
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
  switch(currentUI) {
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
    theBall.draw();
    // TO DO : DENIS, put your CLASS.draw here
    break;
  }
}

void keyPressed()
{
  switch(currentUI) {
  case WELCOME:
    welcome.keyPressed();
    break;
  case GREETING: 
    break;
  case STORY: 
    break;
  case GAME:
    theBall.keyPressed();
    // TO DO : DENIS, PUT your CLASS.keyPressed here
    break;
  }
}

