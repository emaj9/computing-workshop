# Friday, August 15th - Last day :(

## Recap from Thursday

- Neural networks
    - Black box
    - Input > Hiddens > Output layers
    - Perceptrons & Activation functions
- Convolutional, Pooling, Droput layers
- Understand limits of research, different culture of inputs
- Recurrent neural networks (RNNs), can't be trained in parallel
- Gradient descent (find min of a function) and Back propagation to train NNs
    - Want loss function number to go down
- Learning rate (Hyperparameter)
- Can be used for anything, classification and regression
- A lot of human intuition in machine learning

## Principal Component Analysis (PCA)

Technique used to make data more manageable by identifying the most important features of the data

### Dimensionality Reduction
- Curse of dimensionality = As the number of features (dimensions) grows, the amound of data required grows exponentially!
- Distance does not work anymore with higher dimensions
    - KNN, KMeans do not work anymore with these higher dimensions

With PCA, we can trim the data down to its more important parts
- Which dimensions explains the most variance, etc
- Remove the unimportant ones

### Coding example notes

- Went down from 4096 dimensions to 125 that still have 95% variance
- Using PCA, we can use linear addition to identify important features (use other images to create chosen face)

## Natural language processing (NLP)

- How do we turn words into numbers? -> Word Embedding
- Encoder-decoder architecture
    - Encoder outputs an output vector and decoder reads that
- Done in LLMs but repeated many times
- RNNs suck, so Attention Networks to the rescue!
    - Attention networks work by finding the important parts of the data and just remembering those
    - Words importance in a sentence, and in relation to other words
- ChatGPT uses "Multi-Head Attention layer" in its encoder-decoder architecture
- Parallel coputing = Computers compute several things at the same time
- Keep in mind there are more ways to machine learning!
    - Self-supervised learning
    - Semi-supervised learning
    - Reinforcement learning (Dynamic programming to train system with rewards and punishment)

## Limits of AI

- Easy to fool image classifiers
- LLMs struggle with complex human interactions & emotions
- LLMs do not "understand" they just want to write good text, predicting the next word
- Still lacks generalizability
- Often learns the wrong things
- Environment limits as well, a lot of energy to train
    - Building hardware embodies the training emissions
    - 3/4 of emissions of big tech is manufacturing
    - 99% of materials are discarded during production
- ML is prone to overhype -> Buzzwords for investors
- Social limits -> Should it be done?
- Requires a ton of data
- Surveillance capitalism / Data misuse
- Shoutout to Edward Snowden
- Replicates human bias
- Garbage in, garbage out.
- Never forget the relationship between computers and war
- Forms of oppresion
- But, it's not all bad...
    - Can help climate change
    - Medical breakthroughs

We need to weigh the pros and cons in the end.

## How to take your learning further

- Review papers from research
- Online: SkLearn doc, user guide, CDSI
- CDSI: Statistics Consulting Service (for consulting for your research)
- Clubs
- Business analytics MGSC and INSY codes
- Kaggle (Coco and Yolo)

### McGill CompSci courses to take

Take these in order if you are new to programming

1. COMP 202 (Intro to programming)
2. COMP 206 (Linux, C, Networking)
3. COMP 250 (Java)
4. COMP 273 (Low-level programming)
5. COMP 251 (Algorithms, LeetCode)
6. COMP 421 (Database)
    
If you are comfortable with programming 

1. COMP 424 (Artifical Intelligence)
2. COMP 551 (Applied Machine Learning)
3. COMP 550 (Natural language processing)
4. COMP 558 (Computer vision)

Other courses on AI topics 500+ levels

Probably a good idea to take some math classes and statistics, some of which are:

1. MATH 240
2. MATH 208
3. MATH 323