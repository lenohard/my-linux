#!/usr/bin/env python
import re
import os
import sys

# ocr create bm file for `djvu` and `pdf` separately from the `content` file which include all level Rgex, and the `result` file which include all the raw text of content

# result.txt  title+page:::([-+]offset)|finalPG:::level
# +offset mean miss pages in pdf so content number are large real one
# -offest mean inserted pages ......


continuelevel = 1
leap=0

def match(p, l):
    f = l.split(":::");
    global continuelevel
    global leap
    pattern = p[0].strip().split("###");
    if len(pattern) > 1 and pattern[1]:
        gs = re.match(pattern[0], f[0].strip())
    else:
        gs = re.match(pattern[0], f[0].strip(), re.IGNORECASE)


    if gs:
        gp = gs.groups()
        title = gp[0].strip()

        if len(f) == 3:
            level = int(f[2])
        else:
            level = int(p[1])

        if len(f) == 2:
            if f[1][0]=='#':
                page = int(f[1][1:])
            elif f[1][0] == '+':
                leap = leap + int(f[1][1:])
                page = int(gp[1]) + offset+leap
            elif f[1][0] == '-':
                leap = leap - int(f[1][1:])
                page = int(gp[1]) + offset+leap
        else:
            page = int(gp[1]) + offset+leap

        return title, page, level, f
    else:
        return None


with open("content") as con:
    cs = con.readlines()
    cs = [i[:-1] for i in cs]

with open("result.txt") as res:
    rs = res.readlines()
    rs = [i[:-1] for i in rs]

offset = int(re.match("offset    ([-0-9]+)", cs[1]).groups()[0])
ifCover = int(re.match("ifCover    ([-0-9]+)", cs[0]).groups()[0])

pats = [i.split(':::')[1:] for i in cs[2:]]

# rs = list(filter(lambda x: x!='\n', rs))
if(sys.argv[1] == 'djvu'):
    if ifCover:
        final = [['Front Cover', ifCover, 1]]
    else:
        final = []
    for l in rs:
        mn = 0
        for p in pats:
            m = match(p, l)
            if m:
                mn += 1
                title, page, level, full = m[0], m[1], m[2], m[3]
                # in case mess with the " in djvu bookmark part
                title = title.replace('"', "'")
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
    # the resulted content have the structure like this
    # (bookmarks ("title" "#page") ("title" "#page") ("title" "#page" ("title" "#page") ("title" "#page")) ("title" "#page"))

    with open("tmp", 'w') as t:
        t.write(content)
else:
    if ifCover:
        final='''BookmarkBegin\nBookmarkTitle:{}\nBookmarkLevel:{}\nBookmarkPageNumber:{}\n'''.format('Front Cover', 1, ifCover)
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

