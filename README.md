# VpvpVpd [![NPM version][npm-image]][npm] [![Build Status][travis-image]][travis] [![Coverage Status][coveralls-image]][coveralls]

[![Sauce Test Status][sauce-image]][sauce]

> MikuMikuDance Vocaloid-Pose-Data(.vpd) Parser

## インストール

```bash
$ npm install vpvp-vpd --save
```

# API

## vpd.parse(buffer) -> `{header,bones}`

MikuMikuDanceの「ポーズデータ保存」で生成した`SHIFT_JIS`の`.vmd`ファイルを`UTF-8`に変換して、オブジェクトを返します。

```js
// Dependencies
var vpd= require('vpvp-vpd');
var fs= require('fs');

// Main
var vpdFile= fs.readFileSync('./pose.vpd');
var data= vpd.parse(vpdFile);
console.log(data);
// {
//   "header": [
//     "VocaloidPoseDatafile",
//     "初音ミク七葉HT.osm;//親ファイル名",
//     "139;//総ポーズボーン数"
//   ],
//   "bones": [
//     {
//       "id": "Bone0",
//       "name": "センター",
//       "position": [ 0.939673, -1.35, 0.129938 ],
//       "quaternion": [ 0, 0, 0, 1]
//     },
//     {
//       "id": "Bone1",
//       "name": "グルーブ",
//       "position": [ 0, 0, 0 ],
//       "quaternion": [ 0, 0, 0, 1 ]
//     },
//     // more 137 bones...
//   ]
// };
```

<!--
# Related projects
* (todo)vpvp-threejs
* (todo)vpvp
* (todo)vpvp-pmx
* (todo)vpvp-vmd
* __vpvp-vpd__
-->

# Related projects
* [vpvp-vmd](https://github.com/59naga/vpvp-vmd/)
* __vpvp-vpd__

License
---
[MIT][License]

[License]: http://59naga.mit-license.org/

[sauce-image]: http://soysauce.berabou.me/u/59798/vpvp-vpd.svg
[sauce]: https://saucelabs.com/u/59798
[npm-image]:https://img.shields.io/npm/v/vpvp-vpd.svg?style=flat-square
[npm]: https://npmjs.org/package/vpvp-vpd
[travis-image]: http://img.shields.io/travis/59naga/vpvp-vpd.svg?style=flat-square
[travis]: https://travis-ci.org/59naga/vpvp-vpd
[coveralls-image]: http://img.shields.io/coveralls/59naga/vpvp-vpd.svg?style=flat-square
[coveralls]: https://coveralls.io/r/59naga/vpvp-vpd?branch=master
