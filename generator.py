import sys
import io
import copy
from typing import List


def replace_text(text: str, replace: List[str]) -> str:
    for i in range(len(replace), 0, -1):
        text = text.replace(f'#{i}', replace[i - 1])
    return text


def parse_param(text: str) -> List[List[str]]:
    return eval(text[7:])


def generate_content(i_file: io.TextIOWrapper, replace: List[List[str]]) -> str:
    content: List[str] = ['' for _ in range(len(replace))]

    while line := i_file.readline():
        if line.startswith("// end_gen"):
            return '\n'.join(content)

        for i in range(len(replace)):
            content[i] += replace_text(line, replace[i])


def process_file(i_file: io.TextIOWrapper, o_file: io.TextIOWrapper):
    o_file.write("/// This file is code generated, please do not \n")
    o_file.write("/// edit it manually. If you want to modify, \n")
    o_file.write("/// change the corresponding template file.\n\n")

    while line := i_file.readline():
        if line.startswith("// gen:"):
            o_file.write(generate_content(i_file, parse_param(line)))
        else:
            o_file.write(line)


filename = sys.argv[1]

if not filename.endswith('.template'):
    print(f'file {filename} does not have .template suffix')

i_filename = filename
o_filename = filename[:-9]

print(f'input file: {i_filename}, output file: {o_filename}')

with open(i_filename, 'r') as i_file:
    with open(o_filename, 'w') as o_file:
        process_file(i_file, o_file)
