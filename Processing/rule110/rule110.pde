/*******************************************************************************
 * Copyright (c) 2013 Serdar Ormanlı.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the GNU Public License v2.0
 * which accompanies this distribution, and is available at
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 * 
 * Contributors:
 *     Serdar Ormanlı - initial API and implementation
 ******************************************************************************/

Cell[][] grid;

int gridSize=2;
int screenWidth=600;
int screenHeight=600;
int cols = screenWidth/gridSize;
int rows = screenHeight/gridSize;


boolean rule(boolean c1, boolean c2, boolean c3) {
  return ((c2&(!c1))|(c2^c3));
}

void setup() {
  size(screenWidth, screenHeight);
  grid = new Cell[cols][rows];

  for (int i = 0; i < cols; i++) {
    grid[i][0] = new Cell(i*gridSize, 0, gridSize, gridSize, false);
  }
  print(rule(false, true, false));
  grid[rows-1][0].status=true;

  for (int j = 1; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      boolean c1=false;
      if (i-1>-1) {
        c1=grid[i-1][j-1].status;
      }
      boolean c2=grid[i][j-1].status;
      boolean c3=false; 
      if (i+1<rows) { 
        c3=grid[i+1][j-1].status;
      }

      grid[i][j] = new Cell(i*gridSize, j*gridSize, gridSize, gridSize, rule(c1, c2, c3));
    }
  }
}

void draw() {
  background(0);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].display();
    }
  }
}

class Cell {
  float x, y;
  float w, h;
  boolean status;

  Cell(float tempX, float tempY, float tempW, float tempH, boolean status) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    this.status=status;
  } 

  void display() {
    stroke(status?0:255);
    fill(status?0:255);
    rect(x, y, w, h);
  }
}
