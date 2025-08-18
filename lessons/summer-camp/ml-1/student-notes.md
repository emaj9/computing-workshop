# Monday, August 11

## Intro

AI > ML > Deep Learning

Stats, Math, CS

ML algorithms "learn" from data, no fixed instructions!

ML:
- Unsupervised learning
    - Clustering (based on input data only, don't know how many groups)
- Supervised learning
    - Classification (cat/dog)
    - Regression (determine output based on params, input & output)

Steps to implementing ML:
1. Decide if ML is necessary -> Are there patterns?
2. Aquire data and prepare it
3. Split the data for training and testing (Train/Test split)
4. Train the ML (baking)
5. Test the ML with new data aka the test data
6. Tune parameters (avoid overfitting, you want errors)

## KNNs: K-Nearest Neighbors 
(Supervised, thus labeled)

- Data points will be similar to other data points nearest it 
- K = num of points around selected point
- Background color around points are the classifier to determine the grouping
- Different metrics = different algorithms -> human touch
- More Ks = more classifications = more white space

## Code

Library we use: https://scikit-learn.org/stable/ 

API doc for load_breast_cancer: https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_breast_cancer.html 

Anaconda > Jupyter Notebook > knn.ipynb

Really KNOW your data!

Some definitions:
- Actual measurements = "data" (X)
- Actual category/class/answer = "target" (Y)
- Training a model = "Fitting" a model
- Algorithm that makes predictions = "Classifier"
- Giving algorithm test data = "Data leakage"
- Easy to understand algorithm = "Explainable/White Box"

Need documentation of a function?
- `function_name?` and then run code (Shift + Enter)

knn.ipynb : 
```python
# We import the libraries and use them in the code
from sklearn.datasets import load_breast_cancer
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# Load the dataset.

# Returns 2 variables -> X and y, because we set return_X_y to True (called multi-variable assignment!)
X, y = load_breast_cancer(return_X_y=True) 

# Another multi-variable assignment, 4 variables this time
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25)
# X is a list of n entries, each of which is a list of 10 measurements related to the tumour
# Y is a list of n entries, each of which is a number indicating whether 
# the corresponding tumour is malignant or benign

# FOR ALL SKLEARN CLASSIFIERS, SAME STEPS:
# 1. Instantiate the classifier (choose K)
# 2. Fit the classifier (training)
# 3. Make predictions! Run the classifier on the test set
# 4. Compare predictions with reality --> Compute accuracy

# Step 1 - Instantiate the classifier
classifier = KNeighborsClassifier(n_neighbors=3) # run (Shift + Enter) KNeighborsClassifier? to see the documentation and see what we need to input inside the function

# Step 2 - Fit the classifier. Fit flushes the memory everytime you run it
classifier.fit(X_train, y_train) # If you need documentation to see what the function does or requires as input, run classifier.fit?

# Step 3 - Make the predictions on the testing set! (X_test)
y_predicted = classifier.predict(X_test)

# Step 4 - Compare with reality to see how accurate (put it to work!). We use the accuracy_score library
accuracy_score(y_test, y_predicted)

# Extra step - Generate the confusion matrix.
confusion_matrix(y_test, y_predicted)

# Example output:
# array([[45, 6],
#       [2, 90]])
# Column 0, Row 0 (45) is True positive (Good!)
# Column 0, Row 1 (6) is False negative (Bad!)
# Column 1, Row 1 (90) is True negative (Good!)
# Column 1, Row 0 (2) is False positive (Really bad! In the case of cancer tumors predictions...)
```

PROS of KNNs:
- Simplicity (White box, easy to understand and need little data)

CONS of KNNs:
- Not good on BIG data, not good on many samples or features
- Classification only (Supervised)

### OPTIONAL: If you want to practice your programming skills with Python, follow these steps on Visual Studio Code to setup your environment. Or practice on Jupyter Notebook!
```
# Go to chosen directory/folder
cd folder_name

# Open a terminal and create virtual environment
python -m venv venv

# Choose a method to Activate based on your environment:

# (A) Activate virtual environment (cmd / PowerShell for Windows)
./venv/Scripts/activate

# (B) Activate virtual environment (git-bash for Windows)
source ./venv/Scripts/activate

# (C) Activate virtual environment (Bash for Linux or Mac)
. venv/bin/activate

# Install requirements if needed
pip install -r requirements.txt

# As you're coding, you might need to install packages
pip install package_name

# Save new packages to requirements.txt for future use
pip freeze > requirements.txt

# (Optional) If you have tests, run this command
pytest
```

\- Dan Moraru
