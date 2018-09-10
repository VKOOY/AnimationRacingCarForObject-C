//
//  VKCarAnimationView.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/30.
//  E-mail:vkooys@163.com
//  Copyright © 2018年 VKOOY. All rights reserved.
//

#import "VKCarAnimationView.h"
#import "Masonry.h"
#import "CarBaseView.h"

@interface VKCarAnimationView()
@property(nonatomic,strong)UIImageView *headBackImageV;
@property(nonatomic,strong)UIImageView *headBackImageVTwo;
@property(nonatomic,strong)UIImageView *roadImageV;
@property(nonatomic,strong)UIImageView *roadImageVTwo;
@property(nonatomic,strong)UIImageView *finishersImageV;        //  终点线
@property(nonatomic,strong)NSMutableArray *carArray;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)CGRect roadRect;
@property(nonatomic,assign)CGRect headBackRect;
@property(nonatomic,assign)CGFloat minX;                        //  最小的x（最快的车）
@property(nonatomic,assign)CGFloat minTwoxX;                    //  第二小小的x（第二快的车）
@property(nonatomic,strong)NSMutableArray *topCarArray;         //  排行数组(里面是CarBaseViews)

@property(nonatomic,assign) BOOL isFinish;
@property(nonatomic,assign) BOOL isGameOver;

@end


@implementation VKCarAnimationView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _minX = self.frame.size.width;
        _minTwoxX = self.frame.size.width;
        
        [self creatBackUI];
        
        for (int i = 0; i<10; i++) {
            [self creatCarImage:i];
        }

    }
    
    return self;
}

/**
 *  开始比赛
 */
-(void)startRun{
    
    if (_timer != nil) {return;}
    
    NSLog(@"========❇️❇️❇️❇️====开始比赛====❇️❇️❇️❇️========");
    
    _isFinish = NO;
    _isGameOver = NO;
    
    //  归零，启动时候判断0喷射氮气
    CGRect frame = _roadRect;
    frame.origin.x = 0;
    _roadRect = frame;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(movieImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  结束比赛
 */
- (void)stopRun {
    _isFinish = YES;
    NSLog(@"========❇️❇️❇️❇️====结束比赛====❇️❇️❇️❇️========");
}

/**
 *  重置比赛
 */
- (void)resetRun {
    
    if (!_timer) {return;}
    
    NSLog(@"========❇️❇️❇️❇️====重置比赛====❇️❇️❇️❇️========");
    
    _isFinish = YES;
    _isGameOver = YES;
    
    [_timer invalidate];
    _timer = nil;
    
    self.finishersImageV.hidden = NO;
    
    
    for (int i = 0; i<10; i++) {
        CarBaseView *imageView = self.carArray[i];

        [imageView speedDownAnimation];

        CGFloat X = _finishersImageV.frame.origin.x + _finishersImageV.frame.size.width + -5.3 * (imageView.tag - 1000);
        
        [self isRetreatAnimation:NO movieX:X imageView:imageView index:i];
    }

}

-(void)movieImage{
    
    CGFloat movieX = 5;
    CGFloat refreshX = [UIScreen mainScreen].bounds.size.height==667.0?-22:0;
    if (self.roadImageV.frame.origin.x > -5 || self.headBackImageV.frame.origin.x > refreshX) {
        //  一圈后背景切换
        self.roadImageV.frame = _roadRect;
        self.headBackImageV.frame = _headBackRect;
    }
    if (!_roadRect.origin.x) {
        //  记录背景图起始点
        _roadRect = self.roadImageV.frame;
        _headBackRect = self.headBackImageV.frame;
        
        //  动画开始
        [self startAnimationNew:YES];
    }
    
    //  改变背景图位置
    self.headBackImageV.frame = CGRectMake(self.headBackImageV.frame.origin.x + movieX , self.headBackImageV.frame.origin.y, self.headBackImageV.frame.size.width, self.headBackImageV.frame.size.height);
    self.roadImageV.frame = CGRectMake(self.roadImageV.frame.origin.x + movieX , self.roadImageV.frame.origin.y, self.roadImageV.frame.size.width, self.roadImageV.frame.size.height);
    if (self.roadImageV.frame.origin.x<0) {
        self.finishersImageV.hidden = YES;
    }else{
        self.roadImageV.frame = CGRectMake(self.roadImageV.frame.origin.x + movieX , self.roadImageV.frame.origin.y, self.roadImageV.frame.size.width, self.roadImageV.frame.size.height);
    }

}



-(void)creatBackUI{
    __weak typeof(self) weakSelf = self;
    
    CGFloat headBackHeight = 50;
    UIImage *headBackImage = [UIImage imageNamed:@"scenery.jpg"];
    _headBackImageV = [[UIImageView alloc]initWithImage:headBackImage];
    [self addSubview:_headBackImageV];
    [_headBackImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(weakSelf);
        make.width.mas_equalTo(CGImageGetWidth(headBackImage.CGImage)/CGImageGetHeight(headBackImage.CGImage)*headBackHeight);
        make.height.mas_equalTo(headBackHeight);
    }];
    
    
    //  创建赛道
    CGFloat roadHeight = self.frame.size.height - headBackHeight;
    UIImage *roadImage = [UIImage imageNamed:@"road.jpg"];
    _roadImageV = [[UIImageView alloc]initWithImage:roadImage];
    [self addSubview:_roadImageV];
    [_roadImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headBackImageV.mas_bottom);
        make.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.width.mas_equalTo(CGImageGetWidth(roadImage.CGImage)/CGImageGetHeight(roadImage.CGImage)*roadHeight);
    }];
    
    UIImage *finishersImage = [UIImage imageNamed:@"finisher.png"];
    _finishersImageV = [[UIImageView alloc]initWithImage:finishersImage];
    [self addSubview:_finishersImageV];
    
    CGFloat ImageGetWidt = CGImageGetWidth(finishersImage.CGImage);
    CGFloat xx = roadHeight/(CGImageGetHeight(finishersImage.CGImage)/ImageGetWidt);
    
    [_finishersImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf).mas_offset(-5);
        make.top.mas_equalTo(self.roadImageV.mas_top).mas_equalTo(3);
        make.right.mas_equalTo(weakSelf).mas_offset(-55);
        make.width.mas_equalTo(xx);
    }];
    
    
}

-(void)creatCarImage:(NSInteger)index{
    __weak typeof(self) weakSelf = self;
    CarBaseView *carView = [[CarBaseView alloc]init];
    carView.tag = 1000+index;
    carView.index = index;
    [self addSubview:carView];
    CGFloat carHeight = 15;
    CGFloat carWidth = carHeight * 5.5;
    CGFloat hegith = (self.frame.size.height - 65)/9;
    [carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.roadImageV.mas_top).mas_offset(10+hegith*index);
        make.height.mas_equalTo(carHeight);
        make.width.mas_equalTo(carWidth);
        make.left.mas_equalTo(weakSelf.finishersImageV.mas_right).mas_offset(-5.3*index);
    }];
    
    carView.carXBlock = ^(CGFloat x, NSInteger carIndex) {
        
        [self calculationTop:x carIndex:carIndex];
    };
    
    [self.carArray addObject:carView];
    [self.topCarArray addObject:carView];
}

//  计算排行
-(void)calculationTop:(CGFloat)x carIndex:(NSInteger)carIndex{
    
    NSInteger index = 0;
    
    for (CarBaseView *carView in self.topCarArray) {
        CarBaseView *carLastView = self.topCarArray[index==0?0:index-1];
        if (index == 0) {
            if (x<carView.releaseX) {
                //  现在的和以前（index）的换位
                NSInteger nowIndex = [self.topCarArray indexOfObject:self.carArray[carIndex]];
                [self.topCarArray exchangeObjectAtIndex:nowIndex withObjectAtIndex:index];
                carLastView = carView;
                break;
            }
        } else {
            if (x<carView.releaseX&&x>carLastView.releaseX) {

                NSInteger nowIndex = [self.topCarArray indexOfObject:self.carArray[carIndex]];
                [self.topCarArray exchangeObjectAtIndex:nowIndex withObjectAtIndex:index];
                break;
            }
        }
        
        index++;
    }
    NSInteger inderNre = 0;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (CarBaseView *carView in self.topCarArray) {
        [array addObject:[NSString stringWithFormat:@"%ld",carView.index+1]];
        inderNre++;
    }
    if (_numberBlock) {
        self.numberBlock(array);
    }
    
    
    
}

//  动画开始
-(void)startAnimationNew:(BOOL)isFirst{

    //  开始后，随机设定位移距离
    //  再随机后退到某一点。(到屏幕边缘一点时，必定触发加速)

    for (int i = 0; i<10; i++) {
        CarBaseView *imageView = self.carArray[i];
        
        if (!_isFinish) {
            CGFloat movieX = 0;
            
            if (isFirst) {
                //  第一次启动,,全部加速
                [imageView speedUPAnimation];
                [imageView speedStartAnimation];
                movieX = [self getXLocal];
                [self isRetreatAnimation:NO movieX:movieX imageView:imageView index:i];
            }else{
                //  不是第一次启动,而且在前半段  后退
                if (imageView.frame.origin.x<self.frame.size.width/2.0f) {
                    movieX = [self getXRetreat];
                    if (movieX>self.frame.size.width) {
                        movieX = self.frame.size.width;
                    }
                    
                    [imageView speedDownAnimation];
                    [self isRetreatAnimation:YES movieX:movieX imageView:imageView index:i];
                }else{
                    //  在后半段  前进
                    BOOL isMovie = arc4random()%50>35?NO:YES;   //  是否移动
                    if (isMovie) {
                        movieX = [self getXLocal];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [imageView speedUPAnimation];
                        });
                    }else{
                        movieX = imageView.frame.origin.x - 10;
                        [imageView speedDownAnimation];
                    }
                    if (movieX<0) movieX = 5;
                    [self isRetreatAnimation:NO movieX:movieX imageView:imageView index:i];
                }
                
            }
            
        } else {
            
            if (_isGameOver) {
                NSLog(@"========❇️❇️❇️❇️====GameOver====❇️❇️❇️❇️========");
                return;
            }
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (CarBaseView *carView in self.topCarArray) {
                [array addObject:[NSString stringWithFormat:@"%ld",carView.index+1]];
            }
            
            NSString *resultStr = [array componentsJoinedByString:@","];
            
            if ([self.rankingsStr isEqualToString:resultStr]) {
                NSLog(@"========❇️❇️❇️❇️====GameFinish====❇️❇️❇️❇️========");
                _isGameOver = YES;

                return;
            }
            
            if ([@"" isEqualToString:self.rankingsStr]) {
                return;
            }
            
            NSArray *arr = [self.rankingsStr componentsSeparatedByString:@","];
            
            NSString *carStr = arr[i];
            
            CarBaseView *iv = self.carArray[[carStr integerValue] - 1];
            
            CGFloat mx = i * 20 + 50;
            
            if (mx > iv.frame.origin.x) {
                [imageView speedUPAnimation];
            } else {
                [imageView speedDownAnimation];
            }
            [imageView speedStartAnimation];
            
            [self isRetreatAnimation:NO movieX:mx imageView:iv index:i];
            
        }
                       
                       
    }
}


-(void)isRetreatAnimation:(BOOL)isRetreat movieX:(CGFloat)movieX imageView:(CarBaseView *)imageView index:(NSInteger)index{
    
    NSInteger timer = isRetreat?4:2;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:timer animations:^{
        imageView.frame = CGRectMake(movieX, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            CarBaseView *imageView = weakSelf.carArray[index];
            [imageView speedDownAnimation];
            
            
            if (self.isFinish) {
                if (imageView.animationTimer) {
                    [imageView speedStopAnimation];
                    
                    [imageView.animationTimer invalidate];
                    imageView.animationTimer = nil;
                }
            }
        }
        
        if (index==9 && !_isGameOver) {     //  最后一辆车   游戏没结束
            [weakSelf startAnimationNew:NO];
        }
    }];
}


#pragma mark -  getter
-(NSMutableArray *)carArray{
    if (!_carArray) {
        _carArray = [[NSMutableArray alloc]init];
    }
    return _carArray;
}

-(NSMutableArray *)topCarArray{
    if (!_topCarArray) {
        _topCarArray = [[NSMutableArray alloc]init];
    }
    return _topCarArray;
}

- (NSString *)rankingsStr {
    if (!_rankingsStr) {
        _rankingsStr = @"";
    }
    return _rankingsStr;
}

//  获取前进指定位置
-(CGFloat)getXLocal{
    return arc4random()%150 + 15;
}

//  获取指定后退位置
-(CGFloat)getXRetreat{
    return arc4random()%(int)(self.frame.size.width - 100);
}



@end
