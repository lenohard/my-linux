#!/usr/bin/env python
import re
import os

with open("content") as con:
    cs = con.readlines()
    cs = [i[:-1] for i in cs]


with open("result.txt") as res:
    rs = res.readlines()
    rs = [i[:-1] for i in rs]

offset = int(re.match("offset    ([0-9]+)", cs[0]).groups()[0])

pats = [i.split('    ') for i in cs[1:]]


# rs = list(filter(lambda x: x!='\n', rs))
final = []
for l in rs:
    for p in pats:
        if re.match(p[0], l):
            gs = re.match(p[0], l).groups()
            title = gs[0]
            page = int(gs[1]) + offset
            level = int(p[1])
            final.append([title, page, level])
            continue

content = "(bookmarks)"
current = len(content)-1
cur_level = 0
for f in final:
    level = int(f[2])
    deep = cur_level - level
    before = content[:current+1+deep]
    after = content[current+1+deep:]
    middle = ' ("{0}" "#{1}")'.format(f[0], f[1])
    current = current + len(middle) + deep
    content = before + middle + after
    cur_level = level

with open("tmp", 'w') as t:
    t.write(content)
