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


UIState currentUI = UIState.WELCOME;
Welcome welcome = new Welcome();

int SCREEN_WIDTH = 1024;
int SCREEN_HEIGHT = 720;

void setup() 
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  f = createFont("Arial", 16, true);
}

void draw_menu_greeting()
{
  int t;

  if (count_down_greeting_launched == 0)
    launch_greeting_countdown();


  background(0);

  fill(250);
  text("Hi "+userName+"\n", 512 - 50, 50);

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
  int count_down_greeting_launched = 1;
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

    if (story_countdown < 4)
      text("Here is the story that we have to do", 512 - 50, 50);
    else if (story_countdown >= 4 && story_countdown < 8)
    {
      text("Here is the story that we have to do", 512 - 50, 50);
      text("Here is the story that we have to do", 512 - 50, 250);
    } else if (story_countdown >= 8 && story_countdown < 12)
    {
      text("Here is the story that we have to do", 512 - 50, 50);
      text("Here is the story that we have to do", 512 - 50, 250);
      text("Here is the story that we have to do", 512 - 50, 450);
    } else
    {
      text("Here is the story that we have to do", 512 - 50, 50);
      text("Here is the story that we have to do", 512 - 50, 250);
      text("Here is the story that we have to do", 512 - 50, 450);
      text("Here is the story that we have to do", 512 - 50, 650);
    }
  } 
  
  else
  {
    currentUI = UIState.GAME;
    println("game launched");
  }
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

