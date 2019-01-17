FEATURES = [0, 1]

def classify(p, k):
    closest = find_k_closest_points(p, k)
    label = find_label_with_highest_count(closest)
    return label

def validate(test_data, k):
    good = 0
    bad = 0
    for test in test_data:
        classification = classify(test[1:], k)
        if classification == test[0]:
            good += 1
        else:
            bad += 1

    return good / float(good + bad)

def distance(p, q):
    d = 0
    for i in FEATURES:
        d += (p[i] - q[i]) ** 2
    return math.sqrt(d)

def find_k_closest_points(p, k):
    sorted_data = sorted(data, key=lambda q: distance(p, q[1:]))
    return sorted_data[:k]

def find_label_with_highest_count(closest):
    B = 0
    M = 0
    
    for point in closest:
        if point[0] == 'M':
            M += 1
        if point[0] == 'B':
            B += 1
    if B > M:
        return 'B'
    else:
        return 'M'
