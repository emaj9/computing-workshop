# Neural Networks 2

### Questions:

1. What is the curse of dimensionality?

2. Why are KNN or DBSCAN algorithms not ideal for data that has high dimensionality?

3. Why do we want to reduce the dimensionality of data in PCA?

4. What does it mean for the transformation matrix to be "orthonormal"?

5. What is the role of eigenvectors or eigenfaces in PCA?

6. Why is variance important in PCA?

### Answers:

1. What is the curse of dimensionality?

> As you increase the number of dimensions used to train a neural network, the amount of data and training required increases exponentially.  
> Example:
> 1D: Place a point every cm on a 10 cm line → 10 points
> 2D: Place a point every cm on a 10 cm × 10 cm square → 100 points
> 3D: Place a point every cm on a 10 cm × 10 cm × 10 cm cube → 1,000 points

2. Why are KNN or DBSCAN algorithms not ideal for data that has high dimensionality?

> KNN and DBSCAN both rely on distance calculations between data points. As dimensionality increases, the number of distance computations grows exponentially.  
> Additionally, in high dimensions, distances between points become less meaningful due to the "curse of dimensionality," causing degraded performance.  
> Thus, for anything other than small or low-dimensional datasets, these algorithms often perform poorly.

3. Why do we want to reduce the dimensionality of data in PCA?

> Reducing dimensionality helps simplify the data, reduce noise, and improve computational efficiency. 
> Most of the meaningful information (variance) in high-dimensional data often lies in a smaller number of dimensions. 
> By reducing dimensions, we can still capture the important patterns while discarding less useful information.

4. What does it mean for the transformation matrix to be "orthonormal"?

> An orthonormal matrix has columns (or rows) that are both orthogonal (perpendicular) to each other and of unit length. 
> This means:
> - Each vector in the matrix has a magnitude of 1.
> - The dot product between any two different vectors is 0.
> Such a matrix preserves distances and angles, making it ideal for coordinate transformations like PCA.

5. What is the role of eigenvectors or eigenfaces in PCA?

> Eigenvectors of the covariance matrix define the directions (principal components) along which the data varies the most. 
> Each eigenvector points in a direction of maximum variance, and its corresponding eigenvalue tells us how much variance is in that direction. 
> PCA uses these eigenvectors to form a new coordinate system for the data, ordered by importance (variance explained).

6. Why is variance important in PCA?

> Variance tells us how much the data changes or spreads out in a certain direction. 
> In PCA, we look for directions where the data spreads out the most, because that’s where the most important patterns are.
> By keeping the directions with high variance, we keep the most useful information. 
> The directions with low variance usually don’t add much and can often be removed without losing much meaning.
