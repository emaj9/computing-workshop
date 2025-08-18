# Tuesday, August 12th

## Recap from Monday

- ML Pipeline
    - Data gathering and cleaning
    - Train test split
    - Fit the model
    - Test the model (validation)
- AI, ML, DL subsets
- TRAIN TEST SPLIT
- KNNs
    - Metrics, distance calculations
    - How many Ks
    - How many classifiers (groups)

Labels = Grouping of the classifiers

Features = Input to train classifer

Hyperparameter = An input that you can stretch out to test out different variations to reach optimal accuracy

Sneak peak for tomorrow:
- Split the data first
- Then clean the data (independently)

## Data collection

- Need a LOT of data to train a model
- Who benefits from the research and data? See PIDD and HeLA
    - Instead, do Indigenous Research Practices -> Place based knowledge
- "Rendering Technical" -> Transform our data into technical data, not create a solution to oversimplify a bigger social issue
- Try to MAINTAIN RELATIONSHIPS!
- God Trick = Creating value free, neutral, all seeing knowledge from nowhere by ignoring the partial perspective of the researcher.
- Just think if you need it, if it's ethical
    - Primary (Make your own)
    - Secondary (Someone else's)
    - Web scraping (Not advised)
    - Simulations (Generate data)
    - Collaboration with other researchers

## Data cleaning

- Cleaning and moderating data is a new site of exploitation in ML work (graphic images, etc)
- We need a DATA STRUCTURE to clean and organize our data (for big data)
- Industry libraries: Pandas and Numpy

### Code

```python
# Some interesting queries to analyze and clean data:

import numpy as np
import pandas as pd

dataset = pd.read_csv("Obviously AI Sample Data.csv")

len(dataset.columns) # Num of columns

len(dataset) # Like a list, so num of rows

dataset['tenure'].mean() # Average contract length. Remember, dictionary, must match exact spelling of column

dataset['PaymentMethod'].value_counts() # Most common payment method

dataset.duplicated().sum() # Duplicate rows? NO! If you sum all of the false duplicates, aka 0, then it should be 0 if no duplicates

dataset['customerID'].duplicated().sum() # Unique customers? Yes!

del dataset['customerID'] # Delete the customerID column

dataset.duplicated().any() # Apparently there is the exact same info for users

len(dataset[dataset.duplicated()])
```

## Decision Trees (DT)

- Figure out the best split
- Recursively find best NEXT question for sub layers
- Try to end up with a balanced tree
- Very prone to overfitting, be careful
    - To avoid this, implement a maximum depth to the tree (max_depth=x)

PROS
- Easy to understand, visualize and explainable (White box)
- Handles numerical and categorical data
- Tree is fast

CONS
- Susceptible to overfitting
- Finding an optimal DT is very slow, so most algorithms find suboptimal DTs
- DT learners can create biased trees if some labels dominate
- Not great for noisy data

## Random Forests: Bootstrapping DTs

By bringing many DTs together, we can OVERCOME some of the issues with standalone decision trees
- But we can't train them all the same, if not they were all be similar

Instead, we use **bootstrapping** to generate variations on our dataset, then train separate
decision trees on each of the bootstrapped dataset.
Using multiple models together to form a more powerful model is called an **ensemble method.**

- Bootstrapping turns one N-row dataset into many similar N-row datasets by _randomly sampling with
  replacement._ Sampling with replacement is where each item selected from a population is returned
  to the population before the next item is drawn. This means the same item may be selected
  multiple times in a given sample.
- On average, building an N-row dataset by sampling with replacement from an originally N-row
  dataset will leave us with 2/3 of the rows being unique. (1/3 will be duplicates.)
- The importance of the duplicated rows will be overemphasized. This introduces some error into the
  decision tree trained from that sample. However, by building multiple trees, the errors will
  cancel out!
- New hyperparameter: How many trees?
- Aggregation -> To make prediction, each tree votes its prediction, the label with the most votes
  is the prediction of the forest overall.
- However, the trees will still be correlated since they are trained on same features, instead, the
  random forest learner selects a random sample of features among which to find a best splits ->
  New hyperparameter = how large a random sample of features to use? Rule of thumb: between log(p)
  and sqrt(p) where `p` is the number of total features.

PROS
- Better at avoiding overfitting DTs
- Generally better results
- More robust to noise
- Better for highly dimensional data

CONS
- Takes a long time to predict and train
- Takes a lot of memory too
- Less "white box"

### Code

Our goal in this section of the lesson is to train decision trees to perform classification of unseen data.

To train a decision tree is to construct it. And we construct the tree from a dataset. But what dataset will we use? Luckily, scikit-learn has some built in!

# Exploring datasets
There is a built-in dataset about iris flowers: it suffices to import the `load_iris` function from the `sklearn.datasets` module, and call it to get the dataset.

```python
from sklearn.datasets import load_iris
dataset = load_iris()

# But what's a dataset? Let's have a look.
# Simply evaluate this cell.
dataset
```

Remember from last time how we interactively got documentation on any variable?

__Question:__ Find out what this `dataset` variable is.

Hint: look at the last character from the first line of this cell.
# Your exploration here:

```
dataset?
# Which is a "Bunch", which is just a dictionary
```

__Question:__ what do we write to get the names of the features out of the dataset?

# Your code here:
```
dataset['feature_names']
```

So this dataset has 4 features in it, all measured in centimeters, and referring to some physical measurements of the flowers.

The `data` and `target` entries in the dataset really are the data, whereas the `target_names` and `feature_names` entries are *metadata*; they tell us about the interpretation of the data.

The `data` and `target` entries are related. Let's see how.

```
# The first entry of dataset['data'] is some measurements about a flower,
# and the first element of dataset['target'] tells us which kind of flower that is.

dataset['data'][0], dataset['target'][0]
```

So the data point `[5.1, 3.5, 1.4, 0.2]` is labelled `0`, which represents a flower species.
## Visual intuition for the dataset

Let's quickly get some intuition for what this dataset looks like by plotting it. Jupyter notebooks have built-in integration with the Python plotting library matplotlib. All this comes pre-installed with Anaconda.

Don't pay too much attention to the code here; we just want to get a quick visualization.
```
# Just evaluate this cell. Dig into the code on your own later.

import matplotlib.pyplot as plt
%matplotlib inline
both = list(zip(((x[0], x[2]) for x in dataset['data']), dataset['target']))
for i, mark in zip(set(dataset['target']), '^ov+'):
    X, Y = list(zip(*[p for p, d in both if d == i]))
    plt.scatter(X, Y, marker=mark)
plt.show()

# You can start to think about the questions, like anything below 2 on the Y coordinate is blue triangles!
```

This scatter plot uses the first feature for the X coordinate and the third feature for the Y coordinate; those are the sepal length and petal length, respectively. The different flower types are represented as different symbols in the plot.

### Questions

1. How many different _labels_ are there in this dataset?
2. How many _features_ does this plot consider? How many _features_ are there in total?
3. Using code, find out what the names of the flowers are in this dataset. Hint: you need to look up something in the `dataset` dictionary.
4. Using code, find out how many points there are in this dataset. Hint: use the `len` function.

# Your solution to question 3 here:
```
dataset['target_names']
```
# Your solution to question 4 here:
```
len(dataset['target_names'])
```
# Decision trees

We are using decision trees as *classifiers*. In this notebook, you'll explore using the `DecisionTreeClassifier` from scikit-learn to construct decision trees.

```
from sklearn import tree
from sklearn.model_selection import train_test_split

# We import the `tree` module from the `sklearn` library. 
# This module contains the `DecisionTreeClassifier`.
```

We can create a new classifier by calling `DecisionTreeClassifier`.

```
classifier = tree.DecisionTreeClassifier()
```

We use the `.` operator to reach inside the module; since `DecisionTreeClassifier` is inside the `tree` module, we specify to Python to look inside the tree module (which we imported) and run the function `DecisionTreeClassifier`.

Before proceeding to train our decision tree model, we need to do a train test split, so that we can set aside some of the data for use as an "exam" for our model later.

__Question:__ Use the `train_test_split` function imported above to set aside 25% of the data for use in validation later.

If you don't know how to use the function, remember that you can use `train_test_split?` to see the documentation. Also don't be shy to use ChatGPT!
# Your answer:

```
X = dataset['data']
y = dataset['target']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25)
```

Now we want to train our classifier on the 75% chunk of data obtained from the train_test_split.

We do this using the `fit` function inside `classifier`. The `fit` function takes two inputs:
1. a list of X values (feature measurements)
2. a list of Y values (labels)

These two lists must have the same size!

__Question:__ Use the `fit` function to train the model. What X and Y values do we use? Hint: they're entries inside `dataset`.

# Your answer:
```
classifier.fit(X_train, y_train)
```

We can visualize the decision tree that was created. Again, don't pay too much attention to this code; we could teach a separate course just about data visualization! **This code might not run correctly on your computer;** see the text below.

```
import graphviz # the library we need to visualize trees and graphs

# Define the visualization code as a function so we can reuse it later!
def visualize_tree(clf):
    dot_data = tree.export_graphviz(clf, feature_names=dataset['feature_names'], filled=True)
    return graphviz.Source(dot_data)

visualize_tree(classifier)
```

This code *might* not work on your computer. (Possibly graphviz isn't installed; it's somewhat tricky to install.)
In this case, you can download the visualization [here](https://computing-workshop.com/lessons/W19/ml-2/graphviz/tree.pdf).

__Questions:__

1. What is the interpretation of the colors in the tree?
2. In each node of the tree, what is the relationship between the `samples = N` line and the `value = [...]` line?
3. Notice that in all the teal and purple nodes, the first count in `value` is always zero. Why is that?
4. What is the meaning of the `value` in each node?
5. Invent three data points. Choose feature values so that the first point falls into the orange leaf; the second, into the teal leaf; and the third, into the most purple leaf. Recall that leaves are nodes with no children.
   For example, a point with `petal width = 2.0` would follow the False branch of the root node. Choose the other parameters so that the point arrives at the desired classification.
6. With the data set aside by the train_test_split, validate the model: figure out how to import and use the `accuracy_score` function from sklearn. Try googling and using the sklearn documentation at first, and give ChatGPT a try too!

# Skip questions
```
from sklearn.metrics import accuracy_score
y_predicted = classifier.predict(X_test)
accuracy_score(y_test, y_predicted)
```
