# Decision Trees

### Questions for Decision Trees:

1. What would a decision tree look like if, after each question, you split the data into one-third and two-thirds?

2. If your datasets are unbalanced what would the decision tree look like?

3. Should each question be specific or general? What happens to the shape of the tree in both cases? 

4. Can you just add more data to the model and train it more if the model overfits?

5. What are some downsides with decision trees? 

6. How do you know the max depth to choose when training a decision tree?

#### Answer Key

1. What would a decision tree look like if, after each question, you split the data into one-third
   and two-thirds?

> - Likely lopsided, each branch would be follow the one-third / two-third split.
> - If the splits consistently divide the dataset into a 1/3 and 2/3 ratio, then the resulting tree
>   would indeed be unbalanced or "lopsided", with deeper branches on the side that gets two-thirds
>   of the data. However, in practice, splits are chosen based on optimizing a metric (e.g., Gini
>   impurity, information gain), not a fixed ratio. So such a pattern would only happen
>   artificially or if the data naturally splits that way.

2. If your datasets are unbalanced what would the decision tree look like?

> - The decision tree would likely be very onesided, and the performance of the tree would
>   decrease.
> - The algorithim that constructs the tree wants to reduce the misclassification rate, if you had
>   a dataset with 10,000 red things, and 3 blue things; it may be more accuate to always classify
>   things as red.

3. Should each question be specific or general? What happens to the shape of the decision tree in
   both cases? 

> - Specific questions will split the dataset unevenly, leading to a big difference between the
>   size of each split. This will likely need deeper level decision trees and possibly overfitting.
> - General questions may result in more even splits and potentially shallower trees, but could
>   miss important distinctions.

4. Can you just add more data to the model and train it more if the model overfits?

> - No data cant be added in parts to the decision tree. All the data must be grouped together
>   first, split into test/train sets then used to fit the model.
> - The dataset will have to be remade and the decision tree itself has to be retrained on the new
>   larger dataset.

5. What are some downsides with decision trees?

> - They dont do well with noisy data
> - If the counts of a ceartian type of object in your dataset are biased to one type, then the
>   trees can have a bias where that particular label dominates.

# Random Forests

### Random Forest Questions

1. Can you define the techique of bootstraping?

2. Do you use the same bootstraped sample to train 2 different trees?

3. What sources of randomness exist in a **random forest**?

### Random Forest Questions

1. Can you define the techique of bootstraping?

> - Take your dataset and randomly sample **with replacement.** "With replacement" means that after
>   drawing an item from the dataset, we put it back in before drawing the next one. This
>   introduces some duplication, so on average only about 2/3 of the rows in the resulting dataset
>   are unique.

2. Do you use the same bootstraped sample to train 2 different trees?

> - Not intentionally but since there is a possibility to have duplicate rows, there is some
>   possibility to use the same sample on two different trees.

3. Where does the random sample come from in the **random forest**?

> - There are two sources of randomness. The first comes from bootstrapping. The second is that the
>   decision tree learner, at each time it adds a new node (decision) to the tree, will only
>   consider a random subset of the available features in the dataset.
