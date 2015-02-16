class Welcome {
  Welcome() { 
    // do some initialization
  }

  void draw() {
    background(0);

    // Set the font and fill for text
    textFont(f);
    fill(250);

    text("Welcome on Ballzy game !!", 512 - 50, 50);

    fill(255);
    rect(512, 300, 500, 100);

    fill(130, 130, 130);
    text(typing, 512, 300 + 65);
  }

  void keyPressed() {
    if (key == ENTER || key == RETURN) {
      userName = typing;
      typing = "";
      println("userName: " + userName);
      currentUI = UIState.GREETING;
    } else if (key != CODED) {
      if (key == BACKSPACE)
        typing += " ";
      else
        typing = typing + key;
    }
  }
}

