PFont f;
String typing = "";
String userName = "";
int userPrompt = 0;

void setup() 
{
  size(1024,720);
  f = createFont("Arial", 16, true);
}

void draw_menu_prompt()
{
  background(0);
   
  // Set the font and fill for text
  textFont(f);
  
  // Display everything
  fill(250);
  text("Welcome on Ballzy game !!", 512 - 50, 50);
  
  fill(255);
  rect(512, 300 ,500, 100);
  
  fill(130, 130, 130);
  text(typing, 512, 300 + 65);  
  
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

void draw_story()
{
  
}

void draw()
{
  if (userPrompt == 0)
    draw_menu_prompt();
  else if (userPrompt == 1)
    draw_menu_greeting();
}

void keyPressed()
{
  switch(userPrompt)
  {
    //O = userPromp for the name
    case 0: 
    {
      if (key == ENTER || key == RETURN)
      {
        userName = typing;
        typing = "";
        println("userName: " + userName);
        userPrompt = 1;
      } 
      else if (key != CODED)
      {
        if (key == BACKSPACE)
          typing += " ";
         
        else
         typing = typing + key;
      }
    }
    // 1 = The game greets the payer
    case 1:
    {
      
    }
    // 2 = The game displays the story background
    case 2:
    {
      
    }
  }
}
