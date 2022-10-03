import re

# don't end with digit
not_end_with_digit = re.compile(r'.*[^\d]\n$')

end_digits = re.compile(r'.*[^\d]+(\d+)\n$')

with open('result.txt', 'r') as f:
    lines = f.readlines()

for i,v in enumerate(lines):
    if not_end_with_digit.match(v):
        print(i, v)
