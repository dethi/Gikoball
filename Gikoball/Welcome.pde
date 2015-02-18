class Welcome {
  Welcome() { 
    // do some initialization
  }

  void draw() {
    background(0);

    // Set the font and fill for text
    textFont(f);
    fill(250);

    text("Welcome to Ballzy game !!", 400-200, 100);

    fill(255);
    rect(300, 400-100, 400, 50);

    text("Type your name:", 400-350, 335);
    fill(130, 130, 130);
    text(typing, 400-95, 335);
  }

  void keyPressed() {
    if (key == ENTER || key == RETURN) {
      userName = typing;
      typing = "";
      println("userName: " + userName);
      currentUI = UIState.GREETING;
    } else if (key != CODED) {
      if (key == BACKSPACE) {
        if (typing.length()-1>=0) 
          typing=typing.substring(0,typing.length()-1);
          
      } else
        if (typing.length()<22)
          typing = typing + key;
    }
  }
}

