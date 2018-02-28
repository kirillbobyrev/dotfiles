flags = [
    '-Wall',
    '-Werror',
    '-std=c++17',
    '-x',
    'c++',
    '-isystem',
    '/usr/include/',
]

def FlagsForFile(filename):
    return {
	'flags': flags,
	'do_cache': True,
    }
