fp=open("test_submission_hash_tfidf_sparse_posneg_combine_v6.csv",'w')
for line1,line2 in zip(open("test_submission_tfidf_posneg_sparse_v6.csv"),open("responses_hash_start_detect.txt")):
	if len(str(line2))==1:
		fp.write(line1)
	else:
		fp.write(line2)
fp.close()