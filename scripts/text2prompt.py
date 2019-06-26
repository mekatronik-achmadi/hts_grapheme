#!/usr/bin/python2

import sys

#####################
# Author: Bajibabu B
#####################

def main(text_file,prompt_file,prefix_name,leadzero):
	count=1
	with open(text_file,'r') as f_in, open(prompt_file, 'w') as f_out:
		for line in f_in.readlines():
			new_line='( ' + prefix_name + '_' + str(count).zfill(leadzero) \
				  + ' '  + '"' + line.rstrip() + '" )'
			f_out.writelines(new_line + '\n')
			count+=1

if __name__ =="__main__":
	if len(sys.argv) == 3:
		text_file=sys.argv[1] #text file as first input
		prompt_file=sys.argv[2] #ouput prompt file as second input
		prefix_name='test' #if no third output then test will be default
		lead_zero=0 #jika tidak butuh 0 di depan angka
	elif len(sys.argv) == 5:
		text_file=sys.argv[1]
		prompt_file=sys.argv[2]
		prefix_name=sys.argv[3] 
		lead_zero=int(sys.argv[4])
	else:
		print "Usage: python2 text2prompt.py <text_file> <prompt_file>"
		print "Usage: python2 text2prompt.py <text_file> <prompt_file> <prefix> <leadzero>"
		sys.exit(2)
	
	main(text_file,prompt_file,prefix_name,lead_zero)


