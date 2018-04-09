# Spring 2018


# Project 3: Algorithm Implementation and Evaluation

----


### [Project Description](doc/)

Term: Spring 2018

+ Project title: Collaborative Filtering on `Anonymous Microsoft Web` and `EachMovie` Data
+ Team Number: 7
+ Team Members: Jessica Zhang, Jiongjiong Li, Xiangyu Liu, Ginny Gao, Daniel Parker
+ Project summary: We used 2 types of collaborative filtering algorithms: Memory-based and Model-based on 2 data sets, `Ananoymous Microsoft Web` for implicit rating, and `EachMovie` for explicit rating, to predict users' ratings on webpages or movies they have't rated, which indicates they might not know thesed items, and based on the ratings, these items could be good recommendations for them. Details can be found in [`main.R`](https://github.com/GU4243-ADS/project-3-algorithms-project-3-algorithms-group-7/blob/master/doc/main.R).

### Memory-based Algorithm



### Model-based Algorithm - clustering



Contribution statement:  

+ Jessica Zhang: Model-based Algorithm, base + cross-validation.

+ Jiongjiong Li: 

+ Xiangyu Liu: Memory-based Algorithm, simrank, base + evaluation.

+ Ginny Gao: explored different similiary weighting measures (Pearson, Spearman, Vector Similarity, Entropy, Mean Square Difference) in Memory-based model, and experimented on whether rating normalization (according to Paper 2, Sec 7) enhances model performance. Tested different similarity weights with normalization, compared different evaluatation metrics.

+ Daniel Parker: 


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
