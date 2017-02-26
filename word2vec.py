from gensim.models import word2vec
import logging
import os
import numpy as np
import re

logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)

class MySentences(object):
    def __init__(self, dirname):
        self.dirname = dirname
 
    def __iter__(self):
        for fname in os.listdir(self.dirname):
            for line in open(os.path.join(self.dirname, fname)):
                yield re.sub("[^\w]", " ",str(line)).split()
 
sentences = MySentences('/home/sohom/Downloads/AV/AV_MLWARE1/train_w2v/') # a memory-friendly iterator


#sentences = word2vec.Text8Corpus('all_in_one_line.txt')
model = word2vec.Word2Vec(sentences, size=20,min_count =1, window=3, workers =-1,sample=1e-5)
#model['learn']
#model.save('/home/sohom/Downloads/AV/AV_MLWARE1/AV_MLWARE1.model')
#model.save_word2vec_format('/home/sohom/Downloads/AV/AV_MLWARE1/text.model.bin', binary=True)
fp1=open("/home/sohom/Downloads/AV/AV_MLWARE1/train_features",'w')
features_train = np.zeros(shape=(0,20))
for line in open("/home/sohom/Downloads/AV/AV_MLWARE1/train_w2v/corrected_label.csv",'r'):
	tk=re.sub("[^\w]", " ",str(line)).split()
	featur=[0]*20
	for word in tk:
		featur=[a + b for a, b in zip(featur, model[str(word)])]
	features_train = np.vstack([features_train, featur])
	fp1.write(str(featur)+"\n")
fp1.close()	

fp2=open("/home/sohom/Downloads/AV/AV_MLWARE1/test_features",'w')
features_train = np.zeros(shape=(0,20))
for line in open("/home/sohom/Downloads/AV/AV_MLWARE1/train_w2v/test_spell-corrected.csv",'r'):
	tk=re.sub("[^\w]", " ",str(line)).split()
	featur=[0]*20
	for word in tk:
		featur=[a + b for a, b in zip(featur, model[str(word)])]
	features_train = np.vstack([features_train, featur])
	fp2.write(str(featur)+"\n")
fp2.close()	