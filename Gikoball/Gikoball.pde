PFont f;
String typing = "";
String userName = "";
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
  background(0);

  fill(250);
  text("Hi "+userName+"\n", 512 - 50, 50);
  /*
  * TO DO : countdown for displaying the next menu
   * At the end, the userPrompt will be to 2
   */
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

