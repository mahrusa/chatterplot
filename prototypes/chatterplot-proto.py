import pandas as pd
import matplotlib.pyplot as plt

def maxm(column, df):
  first = list(df.columns.values)[0]
  items = df[column].tolist()
  fitems = df[first].tolist()
  index = df.index[df[column] == max(items)].tolist()[0] 
  print("The maximum value of " + column + " is " + str(max(items)) + " at " + first + " " + str(fitems[index]))

def minm(column, df):
  first = list(df.columns.values)[0]
  items = df[column].tolist()
  fitems = df[first].tolist()
  index = df.index[df[column] == min(items)].tolist()[0] 
  print("The minimum value of " + column + " is " + str(min(items)) + " at " + first + " " + str(fitems[index]))

def avg(column, df):
  items = df[column].tolist()
  avg = sum(items) / len(items)
  print("The average value of " + column + " is " + str(avg))

def sums(column, df):
  items = df[column].tolist()
  print("The sum of " + column + " is " + str(sum(items)))

def graph(inp, column, df):
  cols = list(df.columns.values)

  for col in cols:
    if(col.casefold() in inp and col != column):
      col2 = col
      break
  l2 = df[column].tolist()
  l1 = df[col2].tolist()
  plt.scatter(l1, l2)
  plt.xlabel(col2)
  plt.ylabel(column)
  plt.title("Relationship between " + col2 + " and " + column)
  plt.show()

  print("Here you go! ")

  

df = pd.read_csv('sample_data/california_housing_train.csv')

cols = list(df.columns.values)


while(True):
  inp = input("\nHow can ChatterPlot assist you today?\n\n")

  print('\n')

  if("?" in inp):
    inp = inp[:inp.rindex('?')]

  column = ''

  if(inp == ''):
    break

  for col in cols:
    if(col.casefold() in inp):
      column = col
      break

  if(column==''):
    print("Sorry, I don't understand that. Please try again. ")
    continue
  
  if("max" in inp or "maximum" in inp  or "highest" in inp):
    maxm(column, df)
  
  elif("min" in inp  or "minimum" in inp  or "lowest" in inp ):
    minm(column, df)

  elif("average" in inp  or "mean" in inp ):
    avg(column, df)

  elif("sum" in inp  or "total" in inp ):
    sums(column, df)

  elif("graph" in inp or "relationship" in inp):
    graph(inp, column, df)
    continue

  else:
     print("Sorry, I don't understand that. Please try again. ")
