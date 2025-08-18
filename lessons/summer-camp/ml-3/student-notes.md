# Wednesday, August 13th

## Recap from Tuesday

- Data collection and ethics (God trick, HeLa & PIDD)
- Data cleaning -> Pandas & Numpy
- Decision trees -> "Best split questions"
- Prone to overfitting, so Random forest -> Bootstrapping technique
- 2 sources of randomness to Random forests:
    1. Random sampling
    2. Random features (removing or adding)
- "Bagging" = Bootstrapping + Aggregation

## Data cleaning color activity code

```python
# Transforming file #8 to CSV, Or use ChatGPT!
with open('colors-8-hillary.csv', 'r') as input_file:
    next(input_file) # Skip the first line of the file
    with open('colors-8-hillary.csv', 'w') as out_file
        print('R,G,B,name', file=out_file)
        for line in input_file:
            fixed_line = line[1:-3] # cut off first char and last 2
            fixed_line = fixed_line.replace(';', ',') # Replace ; to ,
            print(fixed_line, file=out_file)
```

```python
import pandas as pd

paths = [
    colors-1-pooya.csv
    colors-2-johann.csv
    colors-3-nausicaa.csv
    colors-4-tian.csv
    colors-5-victor.csv
    colors-6-chris.csv
    colors-7-gilbert.csv
    colors-8-hillary.csv
    colors-9-ismail.csv
]

# Glob method
from glob import glob

dfs = []
for path in glob('colors-2025/*.csv'):
    df = pd.read_csv(path)
    df.columns = {'R', 'G', 'B', 'name'}
    dfs.append(df)

# Concat dataframe
df = pd.concat(dfs)

# We realize that there are still problems in the dataset, white spaces or duplicates

df['name'] = df['name'].str.lower().str.strip()
print(df.to_string()) # To check csv

print(df['name'].value_counts().to_string()) # To check how many duplicate rows
```

## Unsupervised learning

- Does not know the labels for the points
- It's about clusters -> Try to collect data and group them in divided groups
- 2 algorithms
    1. K-means
    2. DBSCAN
- You don't normally have ground truth for unsupervised models
    - Difficult to assess performance
    - No train-test split
    - No accuracy

### K-Means

Like asking “I want exactly 3 groups, please split these marbles into 3 piles.”

Centroid = Circles to determine groupings

Convergence = When the training has no more incremental improvements to make in the iterative training process

- Very sensitive with the inital centroid positions, and sensitive to outliers
- Must have a normal cluster distribution, have a center
- Must know K beforehand
- Faster for large datasets

### DBSCAN

Like saying “Find me all dense piles of marbles, and ignore the ones rolling off alone.”

- Picking an unidentified point, and growing the cluster around it, continues with next point once done
    - Based on epsilon and minPoints (if there are x amount of minimum points in that neighborhood, then start cluster)
- Assumptions that clusters have "Uniform density"
- Can handle noise (as in, not every point has to have a group)
- Find clusters of any shape and based on density
- Slow for large datasets
- Core points are bigger points and non-core points are "frontiers" (usually around the border of the cluster)

## How to evaluate unsupervised models

### For supervised
- Show unseen data
- Create confusion matrix
    - Precision = TP/(TP+FP)
    - Recall = TP/(TP+FN)

### For unsupervised
- Kind of hard since there are no "labels"
- There is a "Silhouette Score"
    - Computes difference between a data point from its centroid versus the distance to the nearest other centroid
    - Each data point will get a silhouette score between -1 and 1
    - -1 = very far from it's centroid and closer to another
    - 1 = very close to it's centroid and further from others
    - 0 = equal distance from 2 nearest centroids
- Silhouette scores can help find right value for K in KMeans!
- KMeans actually won't have negative Silhouette scores, due to it's own mechanism properties --> each point is calssified to the closest centroid.
- A Very negative Silhouette score could mean that your data is not normally distributed.
- A Silhouette socre of 0 means that this point is evenly on the boundary of 2 decision spaces or classes.
- Want to look for blunt edges for the Silhouette scores graphs
- But, keep in mind that there is no ground truth when testing unsupervised models and it depends on the context and what you are evaluating!

## ML Validation

Data leakage is deceptively simple

- ALWAYS TRAIN TEST SPLIT
    - Split the data: Then Normalize
    - Split the data: Then fill in empty data
    - Split the data: Then select a subset

- Even with the split, there are still chances of data leakage
1. Ensure your test sample generalizes
    - What question am I trying to answer?
    - Can the data I'm collecting answer that question?
2. Select features wisely
    - Can the features in my data reasonably be used to make this prediction?
    - What are the features I'm testing on?
    - Argue the legitimacy of each feature in the dataset
    - Is it potentially a proxy for the outcome being predicted?
3. Maintain train test split
    - How will you address duplication in the dataset?
    - How will you address dependencies in the dataset?
    - If you did any pre-processing on unsplit data, THAT is leakage

Validating a model is when we test a ML algorithm on a subset of the data, and adjust hyperparameters to improve performance

Evaluation is testing it on unseen data

An effective way: K-fold cross-validation
- Keep a reserve of test data for the very end
- In the train set, mix up what is tested and trained and average the results, tuning along the way
