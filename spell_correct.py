from autocorrect import spell
fp=open('test_MLWARE1.csv','r')
fp1=open('test_spell-corrected.csv','w')
fp.readline()#Heading remove
fp1.write("tweet\n")
for line in fp:
	tk=line.split()
	#corr_word=[]
	for word in tk:
		fp1.write(spell(str(word))+" ")
	fp1.write("\n")
fp.close()
fp1.close()