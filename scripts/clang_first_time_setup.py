#!/usr/bin/env python3

import argparse
import os
import sys
import requests
import json

TERMINAL_WIDTH = 80

parser = argparse.ArgumentParser(description=''' Clone LLVM and Clang with all
                                              the submodules using GitHub mirror
                                              and (optionally) own forks with
                                              corresponding upstreams''',
                                allow_abbrev=False)

parser.add_argument('--dir', '-d', type=str,
                    help='The directory where you want LLVM & Co to live in')

parser.add_argument('--github', '-g', type=str,
                    help='Your GitHub account username')

args = parser.parse_args()

print('-' * TERMINAL_WIDTH)
print()

if args.dir is None:
  args.dir = '.'
elif not (os.path.isdir(args.dir)): 
  print('Fatal error: Passed directory does not exist', file=sys.stderr)
  sys.exit()

print('Cloning LLVM & Co into', os.path.abspath(args.dir))

if args.github is None:
  print('No GitHub username passed; cloning the original llvm-mirror repos')
elif not (requests.get('https://api.github.com/users/' + args.github).ok):
  print('Fatal error: Such GitHub account does not exist', file=sys.stderr)
  sys.exit()
else:
  print('Trying to clone repos forked by ', args.github)

print('Enter the name for the directory with LLVM sources and build files '
      '(Default = LLVM):', end = ' ')
directory = input()

if directory == '':
  directory = 'LLVM'

if os.path.exists(directory):
  print('Fatal error: directory', directory, 'already exists', file=sys.stderr)
  sys.exit()

print()
print('creating', os.getcwd() + '/' + directory, 'directory...')
os.mkdir(directory)

print('creating', os.getcwd() + '/' + directory + '/build', 'directory...')
os.mkdir(directory + '/build')

directory = os.path.abspath(directory)

print('entering' +  directory + '...')
os.chdir(directory)

print()
print('-' * TERMINAL_WIDTH)

