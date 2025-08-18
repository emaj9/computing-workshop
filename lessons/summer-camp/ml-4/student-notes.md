# Thursday, August 14th

## Recap from Wednesday

- Data cleaning
- Data leakage (k-fold cross-validation)
    - Using test data in training
    - Argue about features
- Supervised VS Unsupervised learning
- K-Means
    - Normally distributed data
    - Know number of classes
- DBSCAN
    - Non-normal data
    - Handles noise
- Silhouette score
    - Blunt curve ending = good score

## Pop quiz!

1. Supervised VS Unsupervised?
     - Supervised data -> have labels, make predictions, ground truth
     - Unsupervised -> without labels, know clusters
2. Validation VS Evaluation?
    - Validation -> during training -> parameter tuning
    - Evaluation -> final test using unseen data
3. What metrics we can use to evaluate a model?
    - Confusion matrix -> Supervised models
        - Recall & Precision
    - Silhouette score -> unsupervised models
4. Avoid data leakage
    - Argue legitimacy of each feature
    - Cleaning data (Dupes, empty values, format, etc)
5. Bagging? Ensemble methods?
    - Bagging -> Bootstrapping + Aggregation (Random forests)
    - Ensemble -> Using many models together
6. White box VS Black box
    - White box -> Explainable, we can trace how we arrived at an answer
    - Black box -> Hard to understand, no idea!
7. What determines when/if ML is appropriate to solve a problem?
    - Think if there is a pattern and a need
8. How does a model train?
    - Depends on the model! Every model trains differently!
        - KNN -> Load the data
        - DT -> Best split questions
        - KMEAN -> Moving centroids
        - DBSCAN -> Recursive spreading pattern
        - NN -> Deep learning
    - Common pipeline:
        1. Instantiate classifier
        2. Fit model
        3. Test

## Neural Nets

- NNs made up of "neurons", called perceptron
- Each perceptron has fixed weights, and bias
- We put these neurons together to make layers, repeated it over and over to obtain layered structure
- Input signal to output (activation -> transfer function -> output)
    - sum(x_i * w_i_j) = y_j
    - Input layer -> Hidden layers -> Output layer
- Activation functions
    - Linear (ReLu)
    - Step
    - Sigmoid
- Input layer corresponds to number of features
- Output layer corresponds to number of classes to predict
- For images, every single pixel is a feature
    - Transform 2D to 1D
- NNs are not distance based algorithms, no curse of dimensionality

Keep in mind

- Too many layers:
    - A lot of time and energy to train, prone to overfitting
- Too few layers:
    - "Underfitting", bad performance
- 1 hidden layer is often sufficient
    - Each layer should generally have decreasing neurons
    - Input layer > hidden layer > output layer
    - Hidden layers should be < half of input layer
    - Hidden layers should have < (2/3 * input layer + output layer)

## NNs Training

- We can compare model's predicted output to the expected out to quantiy how "wrong" the network is
- This measure of wrongness is called the "cost". And it is computed using a cost function (or loss function)
- Cost function:
    - Input: Weights and biases of the network
    - Output: How off the network is, on average
    - Parameters: Sample of the picture-label pairs
- We want to find an input for the cost function that makes the cost function's output as small as possible.
- This is a minimization problem from Calculus 1 -> But NN is not a simple function, thus we use an approximation: Gradient Descent (ball rolling down curve)
- Random gradient descent (stochastic gradient descent)
- Backpropagation = Figuring out which way "down" is
    - Adjust weights and biases

So far, we've been talking about "Feed forward NN" where all the nodes are moving in one direction

But Back propagation, the loss, how poorly the algorithm performed. So we adjust all the weights and biases going backwards in the network

## Different types of NNs

### Convolutional neural networks

- Computer vision uses "Convolutional neural networks (CNN)"
    - They use 2D instead of 1D, so more variety of layer types
    - Most important is a layer that applies a "kernel" to the input image -> It's nice because it compresses the size of the input data into a more compact format
    - Each neuron in a convolutional layer is a separate 
    
    #### Convolution layers
        - Wieghts and biases are now put into the kernel that is slid around the image.
        - A special kind of hidden layer called: the convolution layer where each node in this hidden layer is a sperate kernel
        - This results in a loss of a pixel boundary around the image

    #### Pooling layers
        
        - Pooling layers often follow convolution layers. 
        - Good, because they reduce the dimensionality of the feature map, keeping only essential information ("compressing", taking average of 2x2 into 1 output or max/min value)

    #### Dropout layer
        - Dropout layers randomly drop/deactivate a fraction of neurons in training. 
        - Helps prevent overfitting forcing the algorithm to use different neurons and not rely too heavily on any one neuron
        - This allows the network to distribute the data/work across neurons.        
    
    - Reshape/flatten layers = If we have both 2D and 1D, then need to reshape layers to get them to work together

### Recurrent neural networks (RNN)

- If we allow backwards arrows, we get Recurrent neural networks (RNNs) which are suited intuitively to processing sequences like text and speech -> Helpful to remember context
    
    - Text generation with RNNs -> Predict next word, this creates a new problem: since can't be trained in parallel so training RNNs is extremely slow
    - Word recognition -> Break down into words and tokens, think about distance map -> Each token maps to a vector -> Each vectors have their own dimensions (How much emotion a word brings, or object word, or positive or negative)
    - Each token has a certain "attention" and "transformers"

    #### Text Generation  
      - RNNs can be used to **predict the next word** in a sequence.  
      - However, RNNs are difficult to **train in parallel**, making training **slow and inefficient**.  
      - This limitation led to the development of more efficient architectures like **Transformers**.

    #### Word Recognition  
      - Text is broken into **tokens** (e.g., words or subwords).  
      - Each token is mapped to a **vector** using embeddings.  
      - These vectors have **multiple dimensions** representing abstract properties like:
        - Emotion
        - Object vs. abstract word
        - Positive or negative sentiment

    #### Attention
        - Attention is when the previous context influences the wieghts and biases of the output
        - "What is the capital ... of *France*?" 
        - Capital in this case refers to the city not finacial resources.
        - Attention helps models disambiguate meaning based on context.
    
    #### Transformers
        - A archetecture solution to the problem of RNNs and their training in parrallel issue
        - A transformer is a neural network architecture designed to address limitations of RNNs, especially their sequential processing.
        - Allows for parallel training, making it faster and more efficient than RNNs or LSTMs.
        - Built primarily using attention mechanisms (e.g., self-attention).
        - Introduced in the paper “Attention is All You Need” (Vaswani et al., 2017).
        - Transformers are the foundation for models like BERT, GPT, and T5.

- Layers are used in conjunction

Industry libraries: PyTorch and Tensorflow


## Live coding

### Data

The first thing we need to do is load the data set. 


```python
#import sklearn
from sklearn.datasets import load_digits
#load the digits
digits = load_digits()
images = digits['images']
```

We need to know what this dataset is all about before we can mess with it. Let's print it!


```python
# exploring the dataset
```


```python
import matplotlib.pyplot as plt
images_and_labels = list(zip(digits.images, digits.target))
for index, (image, label) in enumerate(images_and_labels[:4]):
    plt.subplot(2, 4, index + 1)
    plt.axis('off')
    plt.imshow(image, cmap=plt.cm.gray_r, interpolation='nearest')
    plt.title('Training: %i' % label)
```

### Preparing the data

When we look at the images data, we see the images are encoded as a 2D matrix of pixel darkness, on a scale from 0 to 16. 

We need to reshape the data into a means our algorithm can read (1D!). Luckily sk learn has got a simple solution for this 


```python
n_samples = len(digits.images) #we need to know the size of the data
data1D = digits.images.reshape((n_samples, -1)) #so we can turn it from 2D to 1D
```

__Train and test__

Like we saw with every other algorithm, we need to split our data into two parts: one to train, and another to test. SK learn makes that really easy.


```python
from sklearn.model_selection import train_test_split

train_image, test_image, train_target, test_target = \ # To allow to write code on a new line
    train_test_split(data1D, digits['target'], test_size=0.25)
```

### Classifier time!

The neural net classifier we will choose from sklearn is the MLPClassifier, that is multi-layer perception (not my little pony). 

As with all ML algorithms we've seen, the devil is in choosing the perfect parameters. When making a ANN classifier, we want to start with one hidden layer. 


```python
from sklearn.neural_network import MLPClassifier
#how to even use MLPClassifier? just ask!
MLPClassifier?

#How would we make a mlp with 2 layers of 16 nodes each?
mlp = MLPClassifier(hidden_layer_sizes=(16,16), max_iter=500)
#And how do we train this mlp?
mlp.fit(train_image, train_target)
```
### Predicting and evaluating our classifier

Now let's run the classifier on the test set we made when we did the train-test split at the beginning.


```python
predictions = mlp.predict(test_image)
```

Now of course sk learn has some easy prewritten functions to build a classification report. Isn't it great?


```python
from sklearn.metrics import classification_report
print(classification_report(test_target,predictions))
```

                  precision    recall  f1-score   support
    
               0       0.94      0.91      0.92        32
               1       0.85      0.95      0.90        43
               2       0.98      0.91      0.94        53
               3       0.96      0.98      0.97        54
               4       0.95      0.93      0.94        44
               5       0.91      0.98      0.94        42
               6       0.98      0.92      0.95        50
               7       0.98      0.94      0.96        49
               8       0.93      0.93      0.93        40
               9       0.93      0.98      0.95        43
    
        accuracy                           0.94       450
       macro avg       0.94      0.94      0.94       450
    weighted avg       0.94      0.94      0.94       450

# Try to draw a number in the grid!

In the grid below you can "draw" a number by using values between 0 and 16. Zero would be "nothing here" and 16 would be "very very dark here". Does the neural network struggle with your "artificial" numbers? Does it struggle with certain numbers more than others?

```python
import numpy as np
mynumber = np.array([
    0, 0, 0, 0, 5, 5, 0, 0, 
    0, 0, 12, 11, 11, 16, 0, 0, 
    0, 0, 15, 0, 0, 14, 0, 0, 
    0, 0, 12, 3, 0, 12, 0, 0, 
    0, 0, 7, 11, 11, 13, 0, 0, 
    0, 0, 0, 0, 0, 11, 0, 0, 
    0, 0, 0, 0, 0, 11, 0, 0, 
    0, 0, 0, 0, 0, 10, 0, 0,
])
mlp.predict([mynumber])

array([9])
```