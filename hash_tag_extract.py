import re
from collections import Counter
fp=open("hash_tags_counts_sarca_non_sarca.csv",'w')
hash_tags=[]
for line in open("train_MLWARE1.csv"):
	if "#" in line:
		m = re.search("[#]{1}[a-zA-Z0-9]*", str(line)).group(0)
		hash_tags.append(str(m)+", response="+str(line.split(',')[-1])[:-1])
#for (ele1:ele2) in Counter(hash_tags):
#	fp.write(str(ele1)+str(ele2)+"\n")
fp.write(str(Counter(hash_tags)))
fp.close()