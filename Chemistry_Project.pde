String typing;
boolean saved;
int atomicNumber;
String electronConfiguration;
boolean[][] shells=new boolean[7][4];
int[] electrons = new int[7];
Element E;

void setup() {
  size(1500, 1000);
  background(255);
  surface.setResizable(true);
  textAlign(CENTER);
  typing="";
  saved=false;
  electronConfiguration="";
  E=new Element();

  for (int i=0; i<shells.length; i++) {
    for (int j=0; j<shells[i].length; j++) {
      shells[i][j]=false;
    }
  }
}

void draw() {
  background(255);
  fill(0);

  if (!saved) {
    textSize(50);
    text("What is the atomic number?", width/2, height/4);
    text(typing, width/2, height/3);
  } else {
    textSize(40);
    text("Atomic Number: "+atomicNumber, width/2, height/8);
    text("Electron Configuration: ", width/2, height/4-75);
    textSize(25);
    text(electronConfiguration, width/2, height/4);
    typing="";
    E.drawRings();
    textSize(30);
    textAlign(LEFT);

    for (int i=0; i<electrons.length; i++) {
      text("ring "+(i+1)+": "+electrons[i], 3*width/4, height/2+(30*i));
    }
    textAlign(CENTER);
  }
}

void keyPressed() {
  if (!saved) {
    if (key=='\n') {
      if (parseInt(typing)!=0 && parseInt(typing)<=118 && parseInt(typing)>=1) {
        atomicNumber=parseInt(typing);
        saved=true;
        electronConfiguration=calculate();
        E.changeNumbers(shells, electrons);
      } else {
        typing="";
      }
    } else if (key==BACKSPACE && typing.length()>=1) {
      typing=typing.substring(0, typing.length()-1);
    } else {
      typing+=key;
    }
  }

  if (key==' ') {
    saved=false;
    for (int i=0; i<electrons.length; i++) {
      electrons[i]=0;
    }

    for (int i=0; i<shells.length; i++) {
      for (int j=0; j<shells[i].length; j++) {
        shells[i][j]=false;
      }
    }
    atomicNumber=0;
  }
}

String calculate() {
  int numberOfShells=0;
  int valenceElectrons=atomicNumber;
  String eConfig;

  if (atomicNumber>=87) {
    numberOfShells=7;
    valenceElectrons=atomicNumber-86;
  } else if (atomicNumber>=55) {
    numberOfShells=6;
    valenceElectrons=atomicNumber-54;
  } else if (atomicNumber>=37) {
    numberOfShells=5;
    valenceElectrons=atomicNumber-36;
  } else if (atomicNumber>=19) {
    numberOfShells=4;
    valenceElectrons=atomicNumber-18;
  } else if (atomicNumber>=11) {
    numberOfShells=3;
    valenceElectrons=atomicNumber-10;
  } else if (atomicNumber>=3) {
    numberOfShells=2;
    valenceElectrons=atomicNumber-2;
  } else {
    numberOfShells=1;
    valenceElectrons=atomicNumber;
  }

  eConfig=initialText(numberOfShells);
  eConfig+=extraText(numberOfShells, valenceElectrons);

  return eConfig;
}

String initialText(int numberOfShells) {
  String initialConfig="";
  shells[0][0]=true;

  if (numberOfShells>=2) {
    initialConfig="1s(2),";
    shells[1][0]=true;
    electrons[0]=2;
  } 
  if (numberOfShells>=3) {
    initialConfig+="2s(2),2p(6),";
    shells[1][1]=true;
    shells[2][0]=true;
    electrons[1]=8;
  } 
  if (numberOfShells>=4) {
    initialConfig+="3s(2),3p(6),";
    shells[2][1]=true;
    shells[3][0]=true;
    electrons[2]=8;
  }
  if (numberOfShells>=5) {
    initialConfig+="4s(2),3d(10),4p(6),";
    shells[4][0]=true;
    shells[2][2]=true;
    shells[3][1]=true;
    electrons[2]=18;
    electrons[3]=8;
  } 
  if (numberOfShells>=6) {
    initialConfig+="5s(2),4d(10),5p(6),";
    shells[5][0]=true;
    shells[3][2]=true;
    shells[4][1]=true;
    electrons[3]=18;
    electrons[4]=8;
  } 
  if (numberOfShells>=7) {
    initialConfig+="6s(2),4f(14),5d(10),6p(6)";
    shells[6][0]=true;
    shells[3][3]=true;
    shells[4][2]=true;
    shells[5][1]=true;
    electrons[3]=32;
    electrons[4]=18;
    electrons[5]=8;
  }
  return initialConfig;
}

String extraText(int numberOfShells, int valenceElectrons) {
  String extraElectrons="";

  if (numberOfShells==1) {
    if (valenceElectrons==2) {
      extraElectrons="1s(2)";
    } else {
      extraElectrons="1s(1)";
    }
    electrons[0]=valenceElectrons;
  } else if (numberOfShells==2 || numberOfShells==3) {
    electrons[numberOfShells-1]+=valenceElectrons;
    if (valenceElectrons>2) {
      extraElectrons=numberOfShells+"s(2),"+ numberOfShells+"p("+(valenceElectrons-2)+")";
      shells[numberOfShells-1][1]=true;
    } else {
      extraElectrons=numberOfShells+"s("+ valenceElectrons + ")";
    }
  } else if (numberOfShells==4 || numberOfShells==5) {
    if (valenceElectrons>12) {
      extraElectrons=numberOfShells+"s(2),"+(numberOfShells-1)+"d(10),"+numberOfShells+"p("+(valenceElectrons-12)+")";
      electrons[numberOfShells-1]+=(valenceElectrons-10);
      shells[numberOfShells-2][2]=true;
      electrons[numberOfShells-2]+=10;
      shells[numberOfShells-1][1]=true;
    } else if (valenceElectrons>2) {
      extraElectrons=numberOfShells+"s(2),"+(numberOfShells-1)+"d("+(valenceElectrons-2)+")";
      electrons[numberOfShells-1]+=2;
      shells[numberOfShells-2][2]=true;
      electrons[numberOfShells-2]+=(valenceElectrons-2);
    } else {
      extraElectrons=numberOfShells+"s("+valenceElectrons+")";
      electrons[numberOfShells-1]=valenceElectrons;
    }
  } else if (numberOfShells==6 || numberOfShells==7) {
    if (valenceElectrons>26) {
      extraElectrons=numberOfShells+"s(2),"+(numberOfShells-2)+"f(14),"+(numberOfShells-1)+"d(10),"+numberOfShells+"p("+(valenceElectrons-26)+")";
      electrons[numberOfShells-1]+=(valenceElectrons-24);
      shells[numberOfShells-1][1]=true;
      electrons[numberOfShells-2]+=10;
      shells[numberOfShells-2][2]=true;
      electrons[numberOfShells-3]+=14;
      shells[numberOfShells-3][3]=true;
    } else if (valenceElectrons>16) {
      extraElectrons=numberOfShells+"s(2),"+(numberOfShells-2)+"f(14),"+(numberOfShells-1)+"d("+(valenceElectrons-16)+")";
      electrons[numberOfShells-1]+=2;
      electrons[numberOfShells-2]+=(valenceElectrons-16);
      shells[numberOfShells-2][2]=true;
      electrons[numberOfShells-3]+=14;
      shells[numberOfShells-3][3]=true;
    } else if (valenceElectrons>2) {
      extraElectrons=numberOfShells+"s(2),"+(numberOfShells-2)+"f("+(valenceElectrons-2)+")";
      electrons[numberOfShells-1]+=2;
      electrons[numberOfShells-3]+=(valenceElectrons-2);
      shells[numberOfShells-3][3]=true;
    } else {
      extraElectrons=numberOfShells+"s("+valenceElectrons+")";
      electrons[numberOfShells-1]=valenceElectrons;
    }
  }
  return extraElectrons;
}
