#Solutions to MLWARE1
MLWARE1 is a Text Analytics Hackathon organised by Analytics Vidhya from 23-25th Feb 2017 (https://datahack.analyticsvidhya.com/contest/mlware-1/).
The task for this competition is to build a machine learning model that, given a tweet, can classify it correctly as sarcastic or non-sarcastic.

##Dataset:
Two files - one each for training and testing are provided. <br />
**training.csv** - This file contains three columns :- <br />
  •ID - ID for each tweet <br />
  •tweet - contains the text of the tweet  <br />
  •label - the label for the tweet (‘sarcastic’ or ‘non-sarcastic’)  <br />
**test.csv** - This file has two columns containing the ID and tweets. The predictions on this set would be judged.  <br />

##Evaluation:
The metric used for evaluating the predictions for this problem is simply the F1-score.

##Approach
###Feature Extraction
1) TF-IDF <br />
2) Spelling correction followed by Word2vec <br />
3) Number of occurrence  of positive & negative words <br />
4) Presence of specific/frequent hash tags like #sarcasm, #not etc. <br />

*Other cleaning steps or features that could have been extracted (but not done presently) :- <br />
a) Keep only english words [Cleaning] <br />
b) Stemming or Lemmatization [Cleaning] <br />
c) GloVe <br />
d) Swivel <br />
e) Lda2vec <br />
f) CBOW <br />
g) N-grams: Binary feature dictionary <br />
h) Capitalizations <br />
i) Topic Modeling (LDA) <br />
j) Hidden Markov <br />
h) Presence of contrasting positive & negative sense in the sentence <br />
i) Entity detect <br />
j) Sentence length, Number of co-occurrence of "!", "?", quotes("") etc. in a sentence <br />
###Modeling
1) Rule based classifier based on statistics: If #sarcasm, #not etc. present then sarcastic <br />
2) GBM in h20 <br />
3) Random Forest in h20 <br />

*Other modeling steps that could have been done but not done presently :- <br />
a) SVM <br />
b) XGBOOST <br />
c) Deep Neural Network in h20 <br />
d) Recurrent Neural Networks <br />
e) Other Deep Learning approaches, defining own cost functions & optimizing it etc. <br />
###Ensembling of outputs
The outputs of rule based classifier and GBM has been ensembled.
###References
1) Aditya Joshi,Pushpak Bhattacharyya, Mark J Carman Automatic Sarcasm Detection: A Survey https://arxiv.org/abs/1602.03426 <br />
2) Chun-Che Peng, Mohammad Lakis, Jan Wei Pan, Detecting Sarcasm in Text: An Obvious Solution to a Trivial Problem http://cs229.stanford.edu/proj2015/044_report.pdf  <br />
3) Roberto González-Ibáñez, Smaranda Muresan, Nina Wacholder, Identifying Sarcasm in Twitter: A Closer Look http://www.aclweb.org/anthology/P11-2102  <br />
4) Dmitry Davidov, Oren Tsur, Ari Rappoport, Semi-Supervised Recognition of Sarcastic Sentences in Twitter and Amazon https://www.aclweb.org/anthology/W/W10/W10-2914.pdf  <br />
5) Dylan Drover, Sarcasm Detection in Product Reviews using Sentence Scale Sentiment Change with Recurrent Neural Networks http://dylandrover.com/sarcasm_project.pdf  <br />
6) Piyoros Tungthamthiti, Kiyoaki Shirai, Masnizah Mohd, Recognition of Sarcasm in Tweets Based on Concept Level Sentiment Analysis and Supervised Learning Approaches http://www.aclweb.org/anthology/Y14-1047  <br />
7) Ellen Riloff, Ashequl Qadir, Prafulla Surve, Lalindra De Silva,Nathan Gilbert, Ruihong Huang, Sarcasm as Contrast between a Positive Sentiment and Negative Situation http://www.anthology.aclweb.org/D/D13/D13-1066.pdf  <br />
8) Aniruddha Ghosh et. al, Sentiment Analysis of Figurative Language in Twitter http://alt.qcri.org/semeval2015/cdrom/pdf/SemEval080.pdf  <br />
9) Aniruddha Ghosh, Tony Veale, Fracking Sarcasm using Neural Network https://www.aclweb.org/anthology/W/W16/W16-0425.pdf  <br />
10) Silvio Amir Byron C. Wallacey Hao Lyuy Paula Carvalho Mario J. Silva, Modelling Context with User Embeddings for Sarcasm Detection in Social Media https://arxiv.org/abs/1607.00976  <br />
11) Aditya Joshi, Vaibhav Tripathi, Kevin Patel, Pushpak Bhattacharyya, Mark Carman, Are Word Embedding-based Features Useful for Sarcasm Detection? https://www.aclweb.org/anthology/D/D16/D16-1104.pdf  <br />
12) Meishan Zhang, Yue Zhang and Guohong Fu, Tweet Sarcasm Detection Using Deep Neural Network https://www.aclweb.org/anthology/D/D16/D16-1104.pdf  <br />
