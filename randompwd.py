#!/usr/bin/env python
#
# A script to generate pseudorandom passwords

from random import choice
from string import ascii_letters, digits, punctuation
from sys import argv, exit

def randompwd(num):
	keylist = []
	randompwd = ''
	for i in ascii_letters + digits:
		keylist.append(i)

	for k in range(num):
		randompwd += choice(keylist)
	return randompwd

def main():
	if len(argv) == 2:
		try:
			num = int(argv[1])
			print randompwd(num)
		except:
			print '\tuse integers, Luke!'
			exit(1)
	else:
		print '\tusage: randompwd <length>'

if __name__ == '__main__':
	main()
