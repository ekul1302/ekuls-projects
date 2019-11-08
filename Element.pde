int shellNumber, extraElectrons;
int level, center;
boolean[][]shellConfiguration;
int[]shellElectrons;

class Element {
  Element() {
    shellNumber=0;
    extraElectrons=0;
    level=height/2+100;
    center=width/2-150;
  }

  void changeNumbers(boolean[][] SC, int[] SE) {
    shellConfiguration=SC;
    shellElectrons=SE;
  }

  void drawRings() {
    strokeWeight(4);
    for (int i=0; i<shells.length; i++) {
      if (i==0)stroke(255, 0, 0);
      if (i==1)stroke(255, 127, 0);
      if (i==2)stroke(255, 255, 0);
      if (i==3)stroke(0, 255, 0);
      if (i==4)stroke(0, 0, 255);
      if (i==5)stroke(75, 0, 130);
      if (i==6)stroke(139, 0, 255);
      for (int j=0; j<shells[i].length; j++) {
        if (shells[i][j]) {
          noFill();
          ellipse(width/2, level, 25+90*i+20*j, 25+90*i+20*j);
        }
      }
      stroke(255);
    }
  }
}
