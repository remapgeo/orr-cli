from glob import glob
import os
from shutil import rmtree
import re
files = [*glob('orr_cli/**/*.md', recursive=True), *glob('orr_cli/**/*.MD', recursive=True)]


TAGS = ["ERROR", "WTF", "BROKEN", "ISSUE", "ASAP",  "BUG", 
        "REMOVE", "HACK", "FIXME", "TODO", "XXX", "DONE", 
        "NOTE", "MARK", "REVIEW", "REF" ]

if os.path.isdir('docs/orr_cli'):
    rmtree('docs/orr_cli')

for file in files:
    
    dest_file = os.path.join('docs', os.path.relpath(file.replace('.MD', '.md')))
    dest_subdir = os.path.dirname(dest_file)
    print(f'Create file: {dest_file}')
    
    os.makedirs(dest_subdir, exist_ok=True)
    
    with open(file, 'r') as old:
        with open(dest_file, 'w') as new:
            for line in old.readlines():
                pattern = f"(--|//|#|<!--|;|/\\*|^|^[ \\t]*(-|\\d+.))\\s*({'|'.join(TAGS)})"
                m = re.search(pattern,line)
                if m is None:
                    new.write(line)
            