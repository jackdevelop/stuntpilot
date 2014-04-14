// 1 一共16个格子
// 2 每个格子包含position（这个一直不变), number(格子上的数字), steps(进行动作时，格子应该移动的距离，方便UI进行变换)

// 关键变量: direction, tiles
// 关键函数: emptyTiles, isEnd, mergeTile, movingTile, moveLeft, moveRight, moveUp, moveDown

// isEnd: 判断是否结束
// mergeTile: 合并两个格子
// movingTile: 格子移动距离，UI进行运算
// moveLeft: 用户按左键
// moveRight: 右
// moveUp: 上
// moveDown: 下

// 用户移动前需要保存上此的 tiles, 移动后计算新的 tiles, 根据tiles前后变化进行UI变换。


// movingTile, moveLeft, moveRight, moveUp, moveDown
// 移动之后会返回是否移动有效。有时候只能向上移动，或者像左移动. 此时用户按向下移动是 tiles 不变，
// 另外没有加入计算分数的内容。可以在 mergeTile 里面计算分数。

// 缺少的函数.
// initTiles: 初始化函数，在盘子上生成两个有数字的格子。
// generateNumber: 在空格子上生成新的数字格子。利用到 emptyTiles 函数
// 


var direction = 'none'; // 用户当前移动方向 left, right, up, down

var tile = {15361810610
  positon: 0 // 0-15
  number: 0 // 这个格子显示的数字. 0表示灰的
  steps: 0  // 0-3 经过计算这个格子移动的距离

};

// 全局变量包含16个格子
// 00 01 02 03
// 10 11 12 13
// 20 21 22 23
// 30 31 32 33
var tiles = new Array()
for(i = 0; i<16; i++){
  tiles[i] = tile.clone()
}


var emptyTiles = function(){
  // 获得所有的空格子
  var empTiles = tiles.filter(function(t){
    return t.number == 0;
  });

  // 获得所有空格子的位置
  var tilesPositoin = empTiles.map(function(t){
    return t.position;
  })

  // 返回所有空格子的位置数组. 如 [3,4,6,9]
  return tilesPositoin
}


// 是否结束：所有格子都含有数字，且相邻两个资格数字都不一样。
var isEnd = function(){
  // 检查是否还有空格子
  var empTiles = emptyTiles()

  if empTiles.length != 0
    // 1 如果还有空格子, 不结束游戏
    return false
  else
    // 2 没有空格子时，检查是否能合并格子。即是否有两个相邻格子的数字相同。
    // 2.1 第一、二、三列前三个只需要检查格子数字是否与右边的格子和下边的格子相同。
    for (i=0; i<3; i++){
      for (j=0; j<3; j++){
        p = i*4 + j;
        // 检查是否与右边格子数字相同
        if tiles[p].number == tiles[p+1].number
          return false;

        // 检查是否与下边格子相同
        if tiles[p].number == tiles[p+4].number
          return false;
      }
    }

    // 2.2 第四列前三个检查是否与下边格子相同. 注意这里 i+=4
    for (i=3; i<16; i+=4){
      if tiles[i] == tiles[p+4]
        return false;
    }

    // 2.3 第四行前三个是否与右边格子相同
    for (i=12; i<16; i++){
      if tiles[i] == tiles[i+1]
        return false;
    }

  // 前面都检查结束了没有中途return，就结束游戏
  return true;
}

mergeTile = function(source, target, step){
  source.number += target.number;
  target.number = 0;
}

movingTile = function(tile, step){
  tile.steps = step;
}


// 用户按方向键左键或者向左滑动触摸屏。所有数字向左移动
var moveLeft = function(){
  // 格子有移动或者合并则返回 true
  // 格子没有移动或者合并则返回 false

  var isMoved = false;

  // 四列同时进行。注意这里 i+=4
  for (i=0; i<16; i+=4){

    // 从第一个格子到第三个格子进行计算
    for (j=0; j<3; j++){
      var p = i+j;
      // 1 如果这个格子是空格子。 向右搜索找到非空的格子移到此格子里
      // 2 如果这个格子不是空格子。向右搜索找到非空的格子且数字相同的格子进行合并
      if(tiles[p].number == 0){
        for (k=1; k<=3-j; k++){
          if(tiles[p+k].number != 0){
            mergeTile(tiles[p], tiles[p+k]);
            movingTile(tiles[p+k], k);
            isMoved = true
          }
        }
      }

      // 移动空格子之后 再判断此格子是否为空 并进行合并操作
      if (tiles[p].number != 0){
        for (k=1; k<=3-j; k++){
          if(tiles[p+k].number == tiles[p].number){
            mergeTile(tiles[p], tiles[p+k]);
            movingTile(tiles[p+k], k);
            isMoved = true
          }
        }
      }


    } // for (j=0; j<3; i++){
  } // for (i=0; i<16; i+=4){

  return isMoved;
}



// 用户按方向键右键或者向右滑动触摸屏。所有数字向右移动
var moveRight = function(){
  // 格子有移动或者合并则返回 true
  // 格子没有移动或者合并则返回 false

  var isMoved = false;

  // 四列同时进行。注意这里 i+=4
  for (i=0; i<16; i+=4){

    // 从第四个格子到第二个格子进行计算
    for (j=3; j>0; j--){
      var p = i+j;
      // 1 如果这个格子是空格子。 向左搜索找到非空的格子移到此格子里
      // 2 如果这个格子不是空格子。向左搜索找到非空的格子且数字相同的格子进行合并
      if(tiles[p].number == 0){
        for (k=1; k<=3-j; k++){
          if(tiles[p-k].number != 0){
            mergeTile(tiles[p], tiles[p-k]);
            movingTile(tiles[p-k], k);
            isMoved = true
          }
        }
      }

      // 移动空格子之后 再判断此格子是否为空 并进行合并操作
      if (tiles[p].number != 0){
        for (k=1; k<=3-j; k++){
          if(tiles[p-k].number == tiles[p].number){
            mergeTile(tiles[p], tiles[p-k]);
            movingTile(tiles[p-k], k);
            isMoved = true
          }
        }
      }

    } // for (j=0; j<3; i++){
  } // for (i=0; i<16; i+=4){

  return isMoved;
}


// 用户按方向键上键或者向上滑动触摸屏。所有数字向上移动
var moveUp = function(){
  // 格子有移动或者合并则返回 true
  // 格子没有移动或者合并则返回 false

  var isMoved = false;

  // 四行同时进行。注意这里 i++
  for (i=0; i<4; i++){

    // 从第一个格子到第三个格子进行计算 注意这里 j+=4
    for (j=0; j<12; j+=4){
      var p = i+j;
      // 1 如果这个格子是空格子。 向下搜索找到非空的格子移到此格子里
      // 2 如果这个格子不是空格子。向下搜索找到非空的格子且数字相同的格子进行合并
      if(tiles[p].number == 0){
        for (k=4; k<16-j; k+=4){
          if(tiles[p+k].number != 0){
            mergeTile(tiles[p], tiles[p+k]);
            movingTile(tiles[p+k], k);
            isMoved = true
          }
        }
      }

      // 移动空格子之后 再判断此格子是否为空 并进行合并操作
      if (tiles[p].number != 0){
        for (k=4; k<16-j; k+=4){
          if(tiles[p+k].number == tiles[p].number){
            mergeTile(tiles[p], tiles[p+k]);
            movingTile(tiles[p+k], k);
            isMoved = true
          }
        }
      }

    } // for (j=0; j<3; i++){
  } // for (i=0; i<16; i+=4){

  return isMoved;
}


// 用户按方向键下键或者向下滑动触摸屏。所有数字向下移动
var moveDown = function(){
  // 格子有移动或者合并则返回 true
  // 格子没有移动或者合并则返回 false

  var isMoved = false;

  // 四行同时进行。注意这里 i++
  for (i=0; i<4; i++){

    // 从第一个格子到第三个格子进行计算 注意这里 j-=4
    for (j=12; j>0; j-=4){
      var p = i+j;
      // 1 如果这个格子是空格子。 向下搜索找到非空的格子移到此格子里
      // 2 如果这个格子不是空格子。向下搜索找到非空的格子且数字相同的格子进行合并
      if(tiles[p].number == 0){
        for (k=12; k>=16-j; k-=4){
          if(tiles[p-k].number != 0){
            mergeTile(tiles[p], tiles[p-k]);
            movingTile(tiles[p-k], k);
            isMoved = true
          }
        }
      }

      // 移动空格子之后 再判断此格子是否为空 并进行合并操作
      if (tiles[p].number != 0){
        for (k=12; k>=16-j; k-=4){
          if(tiles[p-k].number == tiles[p].number){
            mergeTile(tiles[p], tiles[p-k]);
            movingTile(tiles[p-k], k);
            isMoved = true
          }
        }
      }

    } // for (j=0; j<3; i++){
  } // for (i=0; i<16; i+=4){

  return isMoved;
}