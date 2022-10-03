#!/usr/bin/env python
import re
import os
import sys

# ocr create bm file for `djvu` and `pdf` separately from the `content` file which include all level Rgex, and the `result` file which include all the raw text of content

continuelevel = 1

def match(p, l):
    f = l.split(":::");
    global continuelevel
    # import ipdb; ipdb.set_trace()
    gs = re.match(p[0].strip(), f[0].strip(), re.IGNORECASE)
    if gs:
        gp = gs.groups()
        title = gp[0].strip()
        page = int(gp[1]) + offset
        level = int(p[1])
        if len(f) > 1:
            level = int(f[1])
            continuelevel = level
        elif len(f) >2:
            page = int(f[2])
        elif level == 0:
            level = continuelevel
        return title, page, level, f
    else:
        return None


with open("content") as con:
    cs = con.readlines()
    cs = [i[:-1] for i in cs]

with open("result.txt") as res:
    rs = res.readlines()
    rs = [i[:-1] for i in rs]

offset = int(re.match("offset    ([-0-9]+)", cs[0]).groups()[0])

pats = [i.split('    ') for i in cs[1:]]

# rs = list(filter(lambda x: x!='\n', rs))
if(sys.argv[1] == 'djvu'):
    final = []
    for l in rs:
        mn = 0
        for p in pats:
            m = match(p, l)
            if m:
                mn += 1
                title, page, level, full = m[0], m[1], m[2], m[3]
                if len(full) > 1:
                    continue # force, jump override
                else:
                    pass
        if mn > 0:
            final.append([title, page, level])

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
else:
    final = ""
    for l in rs:
        mn = 0
        for p in pats:
            m = match(p, l)
            if m:
                mn += 1
                title, page, level, full = m[0], m[1], m[2], m[3]
                if len(full) > 1:
                    continue # force, jump override
                else:
                    pass
        if mn > 0:
            final = final+"BookmarkBegin\nBookmarkTitle:{}\nBookmarkLevel:{}\nBookmarkPageNumber:{}\n".format(title, level, page) # allow override

    final = final + '''PageLabelBegin
PageLabelNewIndex: 1
PageLabelStart: 1
PageLabelNumStyle: LowercaseRomanNumerals
PageLabelBegin
PageLabelNewIndex: {}
PageLabelStart: 1
PageLabelNumStyle: DecimalArabicNumerals'''.format(offset+1)

    with open("tmp.bm", 'w') as t:
        t.write(final)

