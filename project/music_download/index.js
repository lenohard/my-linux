const fs = require('fs');
const puppeteer = require('puppeteer');

let scrape = async () => {
  const browser = await (puppeteer.launch({
    headless: false }));
  const page = await browser.newPage();
  // 进入页面

  await page.goto('https://music.163.com/#/my/m/music/playlist?id=10602032', {waitUntil: 'load'});

  await page.click(".m-top .m-tophead a.link");
  await page.click("a.other");
  await page.click("div.login-list div.u-official-terms input");
  await page.click("div.login-list .u-main a");
  await page.type(".n-log2  .txtwrap #p", "15238723375");
  await page.type(".n-log2  #pw", "1123581321");
  await page.click(".n-log2 a.j-primary");


  // 获取歌曲列表的 iframe
  await page.waitFor(3000);
  let iframe = await page.frames().find(f => f.name() === 'contentFrame');

  const authors = await iframe.evaluate(() =>{
    let data = [];
    let elements = document.querySelectorAll("table tbody tr > td:nth-child(4) > div > span")
    for(var element of elements){
      let author = element.getAttribute('title');
      data.push(author)
    }

    return data;
  })


  const albums = await iframe.evaluate(() =>{
    let data = [];
    let elements = document.querySelectorAll("table tbody tr > td:nth-child(5) > div > a")
    for(var element of elements){
      let author = element.getAttribute('title');
      data.push(author)
    }

    return data;
  })

  const ids = await iframe.$$eval('table.m-table tbody tr td div div div span.txt a', elements => {
    id = elements.map(v =>{
      title = (v.children[0].getAttribute('title'));
      id = v.getAttribute('href').slice(9);
      return id+":::"+title;
    })
    return id;
  });

  for(var i = 0;  i<ids.length; i++){
    ids[i] = ids[i]+":::"+authors[i]+":::"+albums[i];
  }

  const dis = await iframe.$$eval('table.m-table tbody tr.js-dis td div div div span.txt a', elements => {
    id = elements.map(v =>{
      title = (v.children[0].getAttribute('title'));
      id = v.getAttribute('href').slice(9);
      return id+":::"+title;
    })
    return id;
  });

  const authors_ = await iframe.evaluate(() =>{
    let data = [];
    let elements = document.querySelectorAll("table tbody tr.js-dis > td:nth-child(4) > div > span")
    for(var element of elements){
      let author = element.getAttribute('title');
      data.push(author)
    }

    return data;
  })


  const albums_ = await iframe.evaluate(() =>{
    let data = [];
    let elements = document.querySelectorAll("table tbody tr.js-dis > td:nth-child(5) > div > a")
    for(var element of elements){
      let author = element.getAttribute('title');
      data.push(author)
    }

    return data;
  })

  for(var i = 0;  i<dis.length; i++){
    dis[i] = dis[i]+":::"+authors_[i]+":::"+albums_[i];
  }

  // 写入文件
  let writerStream = fs.createWriteStream('ids.txt');
  writerStream.on('error', function(err){console.log(err)});
  ids.forEach(function(v){
    writerStream.write(v+'\n')
  });
  writerStream.end();


  let writerStream2 = fs.createWriteStream('dis.txt');
  writerStream2.on('error', function(err){console.log(err)});
  dis.forEach(function(v){
    writerStream2.write(v+'\n')
  });
  writerStream2.end();

  browser.close();
  return ids;
};

scrape().then(value => {
  console.log(value)
})
