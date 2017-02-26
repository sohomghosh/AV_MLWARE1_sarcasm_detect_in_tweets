import re
pos_lis=[]
neg_lis=[]
fp1=open("pos_neg_train.csv",'w')
fp2=open("train_MLWARE1.csv",'r')
fp2.readline()
for line in open("poswordlist.txt"):
	pos_lis.append(str(line)[:-1].lower())
for line in open("negwordlist.txt"):
	neg_lis.append(str(line)[:-1].lower())
#print(pos_lis)
#print(neg_lis)

for line in open("/home/sohom/Downloads/AV/AV_MLWARE1/train_w2v/corrected_label.csv"):#test_spell-corrected.csv"):
	words=re.sub("[^\w]", " ",str(line)).split()
	words_small=[str(word).lower() for word in words]
	pos=0
	neg=0
	for word in words_small:
		if word in pos_lis:
			pos=pos+1
		if word in neg_lis:
			neg=neg+1
	line1=fp2.readline()
	fp1.write(str(pos)+","+str(neg)+"\n")

fp1.close()
fp2.close()