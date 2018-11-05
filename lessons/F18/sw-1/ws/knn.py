import csv
from collections import defaultdict
import math

def distance(p1, p2):
    return math.sqrt(sum((x1 - x2) ** 2 for x1, x2 in zip(p1, p2)))

def classify(point_to_classify, data, k=3):
    # sort the data by distance to `point`, the data we want to classify.
    data_with_distances = []
    for point in data:
        # here we pair each data point with its distance to the point
        # to classify
        data_with_distances.append(
            (distance(point, point_to_classify), point_to_classify))
    # sort the data by its distance to the point to classify
    sort(data_with_distances)

    # data_by_distance = sorted(data, key=lambda p: distance(p[1:], point[1:]))
    # now we set up a dictionary for the votes.
    # The dictionary associates class labels with how many votes are
    # for that class. 
    votes = defaultdict(0) # default number of votes for a class is zero.
    
    for (_, l) in data_by_distance[:k]:
        votes[l] += 1
    return max((v for v in votes.items()), key=lambda (_, count): count)[0]

if __name__ == '__main__':
    with open('small-nice.data', 'rb') as csvfile:
      reader = csv.reader(csvfile)
      reader.next() # skip the header in the csv file
      #
      data = [ entry[1:4] for entry in reader ]
