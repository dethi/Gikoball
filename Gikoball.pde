PFont f;
String typing = "";
String userName = "";

int SCREEN_WIDTH = 1024;
int SCREEN_HEIGHT = 720;

void setup() 
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  f = createFont("Arial", 16, true);
}

void draw()
{
  background(0);
  int indent = 25;
  
  // Set the font and fill for text
  textFont(f);
  
  // Display everything
  fill(250);
  text("Welcome on OUR GAME !\n ", 512 - 50, 50);
  
  fill(255);
  rect(512, 300 ,500, 100);
  
  fill(130, 130, 130);
  text(typing, 512, 300 + 75);
}

void keyPressed()
{
  if (key == ENTER || key == RETURN) {
    userName = typing;
    typing = "";
    println("userName: " + userName);
  } else if (key != CODED) {
    if (key == BACKSPACE) {
      typing += " ";
    } else {
      typing += key;
    }
  }
}
