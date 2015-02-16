PFont f;
// Variable to store text currently being typed
String typing = "";
// Variable to store saved text when return is hit
String saved = "";

void setup() 
{
  size(1024,720);
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
  text(saved, indent, 130);
  
}

void keyPressed()
{
  // If the return key is pressed, save the String and clear it
  if (key == '\n' )
  {
    saved = typing;
    // A String can be cleared by setting it equal to ""
    typing = ""; 
  } 
  else 
  {
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + key; 
  }
}
