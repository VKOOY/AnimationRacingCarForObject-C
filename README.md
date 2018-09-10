# AnimationRacingCarForObject-C
赛车动画iOS版

![image](https://github.com/VKOOY/AnimationRacingCarForObject-C/blob/master/VKAnimationRacingCar.gif)

-------------------------------------------------- Enlish --------------------------------------------------

For some time ago, because the company needed to write a racing animation, I searched for ideas on the Internet and accidentally saw a code written by someone else, which met my needs, so I changed it. Original author GitHub: ete8652/AnimationRacingCar.Respect the original author and only communicate.

### Requirements:

1. The car has an accelerated animation, wheels rolling, air and flame effects
2. Real-time display of the car's ranking according to the location of the car.
3. The background image is always scrolling


-------------------------------------------------- 中文 --------------------------------------------------

为前段时间因公司需要写个赛车动画，于是在网上搜索思路，无意间看到一个别人写的代码，正好符合我的需求，于是便拿来改了改。原作者GitHub：ete8652/AnimationRacingCar,尊重原作者，仅作交流。

### 需求：

1.赛车有加速动画，轮子滚动，有空气、火焰效果；

2.能实时根据赛车位置，展示赛车排行；

3.背景图一直循环滚动。

### 使用：

```
VKCarAnimationView *view = [[VKCarAnimationView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 200)];

    view.numberBlock = ^(NSMutableArray *array) {
        //  实时排行
    };
    [self.view addSubview:_carAniView = view];

//  Start
[_carAniView startRun];

//  Stop
_carAniView.rankingsStr = @"1,2,3,4,5,6,7,8,9,10";  //  排行
[_carAniView stopRun];

//  Reset
[_carAniView resetRun];

```


