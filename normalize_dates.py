import os
import argparse
from glob import glob
import time
from datetime import datetime
import shutil

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
        mod_time_str = new_file.split('_')[1].split('.')[0]
        year = int(mod_time_str[0:4])
        month = int(mod_time_str[4:6])
        day = int(mod_time_str[6:8])
        hour = int(mod_time_str[8:10])
        minute = int(mod_time_str[10:12])
        second = int(mod_time_str[12:14])
        mod_time = time.mktime(datetime(year, month, day, hour, minute, second).timetuple())
        os.utime(new_file, (mod_time, mod_time))
    except Exception as e:
        print(repr(e))
