# Spring 2018


# Project 3: Algorithm Implementation and Evaluation

----


### [Project Description](doc/)

Term: Spring 2018

+ Project title: Collaborative Filtering on `Anonymous Microsoft Web` and `EachMovie` Data
+ Team Number: 7
+ Team Members: Jessica Zhang, Daniel Parker, Jiongjiong Li, Xiangyu Liu, Ginny Gao
+ Project summary: We used 2 types of collaborative filtering algorithms: Memory-based and Model-based on 2 data sets, `Ananoymous Microsoft Web` for implicit rating, and `EachMovie` for explicit rating, to predict users' ratings on webpages or movies they have't rated, which indicates they might not know thesed items, and based on the ratings, these items could be good recommendations for them.

Contribution statement:  

+ Jessica Zhang: Model-based Algorithm, base + cross-validation.

+ Daniel Parker: did not contribute to this project.

+ Jiongjiong Li: 

+ Xiangyu Liu: Model-based Algorithm, base + evaluation.

+ Ginny Gao: explored different similiary weighting measures (Pearson, Spearman, Vector Similarity, Entropy, Mean Square Difference) in Memory-based model, and experimented on whether rating normalization (according to Paper 2, Sec 7) enhances model performance. Tested different similarity weights with normalization, compared different evaluatation metrics.


# Model-based Algorithm - clustering



Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
