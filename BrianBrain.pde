/**
 * 
 * @author psksvp@gmail.com
 *
 */
public class BrianBrain implements Runnable
{
  class Cell
  {
    public static final int DEAD = 0;
    public static final int ALIVE = 1;
    public static final int DYING = 2;
    private int currentState;
    private int nextState;

    private int X;
    private int Y;
    private int Z;

    public Cell(int x, int y, int z, int state)
    {
      setX(x);
      setY(y);
      setZ(z);
      setCurrentState(state);
    }

    public void draw()
    {
      //draw
      if (ALIVE == this.currentState())
      {
        stroke(0, 255, 0);
        point(X(), Y(), Z());
      } 
      else if (DYING == this.currentState())
      {
        stroke(0, 0, 255);
        point(X(), Y(), Z());
      } 
      else
      {
        stroke(0);
        point(X(), Y(), Z());
      }
      
      
    }

    public void evolve() 
    {
      this.setCurrentState(this.nextState());
    }


    public int currentState() 
    {
      return currentState;
    }

    public void setCurrentState(int currentState) 
    {
      this.currentState = currentState;
    }

    public int nextState() 
    {
      return nextState;
    }

    public void setNextState(int state) 
    {
      this.nextState = state;
    }

    public int X() 
    {
      return X;
    }

    public void setX(int x) 
    {
      X = x;
    }

    public int Y() 
    {
      return Y;
    }

    public void setY(int y) 
    {
      Y = y;
    }

    public int Z() 
    {
      return Z;
    }

    public void setZ(int z) 
    {
      Z = z;
    }
  }


  //////////////////////////////////////////
  private Cell[][][] world;
  private int columns, rows, slices, size;
  private int runForNStep = 10;

  public void setNumberOfStep(int nStep)
  {
    runForNStep = nStep;
  }

  public BrianBrain(int r, int c, int s, int size)
  {
    this.size = size;
    this.columns = r;
    this.rows = c;
    this.slices = s;
    world = new Cell[columns][rows][slices];
    reset();
  }

  public void run(int nStep)
  {
    for (int i = 0; i < nStep; i++)
    {
      this.generate();
      this.visualize();
    }
  }

  public void reset()
  {
    for (int i = 0, xSize = -size; i < columns; i++, xSize++) 
    {
      for (int j = 0, ySize = -size; j < rows; j++, ySize++) 
      {
        for (int k = 0, zSize = -size; k < slices; k++, zSize++)
        {
          int state = (int)random(0, 3);
          world[i][j][k] = new Cell(xSize, ySize, zSize, state);
        }
      }
    }
  }

  void visualize() 
  {
    for ( int i = 0; i < columns; i++) 
    {
      for ( int j = 0; j < rows; j++) 
      {
        for( int k = 0; k < slices; k++)
        {
          world[i][j][k].draw();
        }
      }
    }
  }

  void generate() 
  {
    for (int x = 0; x < columns; x++) 
    {
      for (int y = 0; y < rows; y++) 
      {
        for (int z = 0; z < slices; z++)
        {
          // Rules 
          if ((world[x][y][z].currentState() == Cell.DEAD)) 
          {
            int neighbors = 0;
            for (int i = -1; i <= 1; i++) 
            {
              for (int j = -1; j <= 1; j++) 
              {
                for(int k = -1; k <=1; k++)
                {
                  if (Cell.ALIVE == world[(x+i+columns)%columns][(y+j+rows)%rows][(z+k+slices)%slices].currentState())
                    neighbors += 1;
                }
              }
            }
            if (1 == neighbors)
              world[x][y][z].setNextState(Cell.ALIVE);
          } 
          else if ((world[x][y][z].currentState() == Cell.ALIVE)) 
            world[x][y][z].setNextState(Cell.DYING);           
          else if ((world[x][y][z].currentState() == Cell.DYING)) 
            world[x][y][z].setNextState(Cell.DEAD);          
          else
          {
          }
        }
      }
    }

    for (int i = 0; i < columns; i++) 
    {
      for (int j = 0; j < rows; j++) 
      {
        for(int k = 0; k < slices; k++)
        {
          world[i][j][k].evolve();
        }
      }
    }
  }


  @Override
  public void run() 
  {
    run(runForNStep);
  }
}