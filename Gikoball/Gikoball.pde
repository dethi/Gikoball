PFont f;
String typing = "";
String userName = "";

// Greeting
int starting_greeting_time;
int count_down_greeting_launched = 0; 

// Story count down
int story_countdown;
int starting_time;
int count_down_story_launched = 0; 

// Story String
String story1 = "-C'mon Goku! The earth needs you!";

String story2 = "-We don't have the whole day! \n"+
"Freezer's minions have been hanging around freely\n"+
" and making a mess over here. You are the only one who\n"+
"can stop them. So get up on The Nimbus Cloud and go to the city\n"+
"to get rid of the cruel minions. Take care, even being you this will\n"+
"be a hard task.";


String story3 = "-What?! Broken?! How a magic cloud can be broken...?\n"+
"Okay okay, then it will be even harder! You have to bounce around\n"+
"trying not fall into the ground's holes those guys made. It will \n"+
"be okay if you bounce in the ground on in the buildings but it's\n"+
"not a great idea to touch the enemies... Better to kick them out!\n";

String story4 = "-Remember to collect food and [whatever] to power yourself up!\n"+
"I should teach you more fighting techniques, but we don't have time \n"+
"rigth now!!! So if we meet in the city I will teach you then!\n";



UIState currentUI = UIState.WELCOME;
Welcome welcome = new Welcome();

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

void setup() 
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  f = createFont("Arial", 32, true);
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
  background(0); 

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
      text(story2, 400 - 300, 100);
      text(story3, 400 - 300, 150);
    } else
    {
      background(0);
      //text(story3, 400 - 300, 100);
      //text(story4, 400 - 300, 150);
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
  }
}

