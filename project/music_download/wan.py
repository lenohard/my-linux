#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
import argparse
import os
from mutagen.easyid3 import EasyID3
from mutagen.id3 import ID3, APIC, TIT2, TPE1, TRCK, TALB, USLT, error
from pathlib import Path
from pyfzf.pyfzf import FzfPrompt

fzf = FzfPrompt()
home = str(Path.home())
session = requests.Session()

parser = argparse.ArgumentParser(prog='wan', description='download the musics you LIKE in NeteaseMusic')
parser.add_argument("phone", type=str, help="account phone number")
parser.add_argument("secret", type=str, help="account password")
parser.add_argument("-d", "--dir",default=os.path.join(home,"wan_music"), type=str, help="save location")
parser.add_argument("-b", "--start",default=0, type=int, help="start location, effective only in --online or --all mode")
parser.add_argument("-e", "--end",default=0, type=int, help="end location , effective only in --online or --all mode, overwrite the --number")
parser.add_argument("-n", "--number",default=0, type=int, help="number of music to be downloaded in effect only with --online or --all mode")
parser.add_argument("-a", "--all",action="store_true", help="download all")
parser.add_argument("-I", "--interactive", default=True, action="store_true", help="interactive with fzf (default)")
parser.add_argument("-o", "--online",action="store_true", help="the first 1000 in ids.txt in order of times of liking")


args = parser.parse_args()
if args.phone:
    phone = args.phone
if args.secret:
    password = args.secret

if args.dir:
    dire = args.dir
    if dire[-1] != '/':
        dire = dire+'/'


# dire = '/home/carl/wan_music/'

directory = Path(dire)
if not directory.exists():
    print("目录不存在, 为您创建目录{}".format(dire))
    os.mkdir(dire)

# Url = 'http://127.0.0.1:3000'
Url = 'http://www.acoin18.com:3000'

m_likes = '/likelist'
m_login = '/login/cellphone'
m_check = '/check/music'
m_detail = '/song/detail'
m_url = '/song/url'

def login(phone, password):
    p_login = {'phone':phone, 'password':password}
    return session.get(Url+m_login, params=p_login)

def detail(id):
    if isinstance(id, list):
        ids = ','.join([str(i) for i in id])
    else:
        ids = id
    p_detail = {'ids':ids}
    return session.get(Url+m_detail, params=p_detail).json()['songs']

def url(id):
    if isinstance(id, list):
        ids = ','.join([str(i) for i in id])
    else:
        ids = id
    p_url = {'id':ids}
    return session.get(Url+m_url, params=p_url).json()['data']

def check(id):
    p_check = {'id':id}
    return session.get(Url+m_check, params=p_check).json()['success']

def likes(id):
    p_likes = {'uid':id}
    return session.get(Url+m_likes, params=p_likes).json()['ids']


def download(id):
    u = url(id)[0]['url']
    info = detail(id)[0]
    pu = info['al']['picUrl']
    if u is None or pu is None:
        raise NameError
    name = info['name']
    # dir = "/home/carl/Downloads/music_download/"
    name = name.replace('/', '|')
    name = name.replace('\x00', '')
    fn = name+'.mp3'
    file = os.path.join(dire, fn)
    print("downloading {}".format(name))
    try:
        r = requests.get(u)
        pr = requests.get(pu)
    except:
        print('can not get pic or mp3')
        return 0
    if r.status_code == 200:
        with open(file,  'wb') as f:
            f.write(r.content)
            print("{}/{} 下载完成!".format(name, id))
    try:
        audio = EasyID3(file)
        audio['title'] = info['name']
        audio['artist'] = info['ar'][0]['name']
        audio['album'] = info['al']['name']
        audio.save()
    except:
        print('无法更改元信息')
    try:
        id3 = ID3(file)
        id3.add(APIC(3, 'image/jpeg',3, 'Front cover', pr.content))
        id3.save(v2_version=3)
    except:
        print("为 {}/{} 增添封面失败, 跳过".format(id, name))

start = args.start

if args.all:
    a = login(phone, password)
    if a.status_code == 200:
        uid = a.json()['profile']['userId']
        print("您已经成功登录")
    else:
        print('something wrong, please contact the administrator')
        exit(0)
    ids = likes(uid);
    if args.number:
        N = start + args.number
    else:
        N = len(ids)
else:
    if args.online:
        with open('ids.txt', 'r') as f:
            lines = f.read().splitlines()
            ids=[];
            for x in lines:
                ids.append(x.split(':::')[0])
            if args.end:
                N = end
            else:
                if args.number:
                    N = start + args.number
                else:
                    N = len(ids)
    else:
        with open('ids.txt', 'r') as f:
            lines = f.read().splitlines()
            for i in range(len(lines)):
                lines[i] = "{:>4}:::{}".format(i, lines[i])
            if args.interactive:
                lines = fzf.prompt(lines, "--multi")
            ids=[]
            for x in lines:
                ids.append(x.split(':::')[1])
            start = 0
            N = len(ids)

    if len(ids) != 0:
        a = login(phone, password)
        if a.status_code == 200:
            uid = a.json()['profile']['userId']
            print("您已经成功登录")
        else:
            print('something wrong, please contact the administrator')
            exit(0)


if isinstance(ids, list):
    print("有{}首音乐将被下载".format(N-start))
    print("从第{}首开始下载, 文件保存在{}目录下.".format(start, dire))
    print("--------------------------------------------------------")
    for i in range(start, N):
        try:
            print("{}: ".format(i-start+1), end=' ')
            download(ids[i])
            print("第{}首下载完成".format(i - start + 1))
        except NameError:
            print('第{}首现在已不存在,或无法下载'.format(i - start + 1))
else:
    print("没有要下载的了～!")
