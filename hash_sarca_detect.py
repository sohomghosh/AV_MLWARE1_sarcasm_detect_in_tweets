fp=open("responses_hash_start_detect.txt",'w')
for line in open("test_submission_tfidf_v4.csv",'r'):
	if "#sarca" in str(line).lower() or "#not" in str(line).lower() or "#serious" in str(line).lower() :
		fp.write(str(line.split(',')[0])+",sarcastic\n")
	elif "#thankful " in str(line).lower() or "#love" in str(line).lower() or "#father" in str(line).lower() or "#health" in str(line).lower() or "#iam " in str(line).lower() or "#birthday" in str(line).lower() or "#blessed" in str(line).lower() or "#model" in str(line).lower() or "#smile" in str(line).lower() or "#nervous" in str(line).lower():
		fp.write(str(line.split(',')[0])+",non-sarcastic\n")
	else:
		fp.write("\n")
fp.close()