import os
import argparse
from glob import glob
import time
from datetime import datetime
import shutil


def get_date_tokens(date: str) -> tuple[int, int, int, int, int, int]:
    return int(date[0:4]), int(date[4:6]), int(date[6:8]), int(date[8:10]), int(date[10:12]), int(date[12:14])


p = argparse.ArgumentParser()
p.add_argument('--src', default='.')
src_dir = p.parse_args().src
files = list(filter(lambda f: f.endswith('.mp3'), [y for x in os.walk(src_dir) for y in glob(os.path.join(x[0], '*'))]))
print('files found = ' + str(len(files)))
for file in files:
    try:
        print('old = ' + file)
        new_file = src_dir + '/' + os.path.basename(file).split('@')[1]
        shutil.copyfile(file, new_file)
        print('new = ' + new_file)
        mod_time = time.mktime(datetime(*get_date_tokens(new_file.split('_')[1].split('.')[0])).timetuple())
        os.utime(new_file, (mod_time, mod_time))
    except Exception as e:
        print(repr(e))
