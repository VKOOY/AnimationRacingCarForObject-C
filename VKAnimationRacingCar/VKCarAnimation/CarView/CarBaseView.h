//
//  CarBaseView.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/30.
//  E-mail:vkooys@163.com
//  Copyright © 2018年 VKOOY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetCarXBlock)(CGFloat x,NSInteger carIndex);


@interface CarBaseView : UIView

@property(nonatomic,assign)NSInteger index;             //  赛车类型编号
@property(nonatomic,assign)CGFloat releaseX;            //  真实x坐标

@property(nonatomic,strong)NSTimer *animationTimer;

@property(nonatomic,copy)GetCarXBlock carXBlock;

//  初始化
-(void)initAnimal:(NSInteger)number;

//  开始动画
-(void)speedStartAnimation;

//  加速动画
-(void)speedUPAnimation;

//  减速动画
-(void)speedDownAnimation;

//  停止动画(比赛结束后)
-(void)speedStopAnimation;

//  开启GIF动画
-(void)GIFAnimation;

@end
