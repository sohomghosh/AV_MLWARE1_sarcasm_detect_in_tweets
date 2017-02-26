fp=open("labels_train.csv",'w')
for line in open("tweet_label.csv",'r'):
	a=line.split("   ,")[1]
	fp.write(a)
fp.close()