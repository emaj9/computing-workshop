#!/usr/bin/python

from sklearn.datasets import load_iris
from sklearn import tree
import graphviz 

dataset = load_iris()

classifier = tree.DecisionTreeClassifier(max_depth=3)
classifier.fit(dataset['data'], dataset['target'])

dot_data = tree.export_graphviz(
    classifier,
    feature_names=dataset['feature_names'],
    filled=True)
graphviz.Source(dot_data).render('tree.pdf')
