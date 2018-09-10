//
//  CarBaseView.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/30.
//  E-mail:vkooys@163.com
//  Copyright © 2018年 VKOOY. All rights reserved.
//

#import "CarBaseView.h"
#import "Masonry.h"
#import "UIImage+GIF.h"
@interface CarBaseView()

@property(nonatomic,strong)UIImageView *carImageV;          //  汽车
@property(nonatomic,strong)UIImageView *airImageV;          //  空气
@property(nonatomic,strong)UIImageView *fireImageV;         //  喷火
@property(nonatomic,assign)BOOL isSpeedUP;                  //  是否是加速状态
@property(nonatomic,assign)NSInteger animationPicIndex;     //  图片index
@property(nonatomic,strong)NSArray *arrayAir;               //  空气图片数组
@property(nonatomic,strong)NSArray *arrayFire;              //  火焰图片数组
@property(nonatomic,strong)NSArray *arrayCar;               //  赛车图片数组

@end

@implementation CarBaseView

-(void)initAnimal:(NSInteger)number{
    
    _animationPicIndex = 0;
    
    self.carImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"car%ld-1.png",number + 1]];
    [self.carImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.carImageV.mas_height).multipliedBy(3.48);
    }];
    [self.airImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(-2);
        make.bottom.mas_equalTo(self).mas_offset(0);
        make.height.mas_equalTo(15);
        make.width.mas_offset(30);
    }];
    
    [self.fireImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(10);
        make.left.mas_equalTo(self.carImageV.mas_right);
    }];
        
}

-(void)speedStartAnimation{
    //  一直切换图片
    if (_animationTimer) {
        [_animationTimer invalidate];
        _animationTimer = nil;
    }
    [self GIFAnimation];
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(GIFAnimation) userInfo:nil repeats:YES];
}

-(void)GIFAnimation{
    if (_isSpeedUP) {
        //  加速状态,切换火焰和空气
        self.airImageV.hidden = NO;
        self.fireImageV.hidden = NO;
        self.airImageV.image = self.arrayAir[_animationPicIndex];
        self.fireImageV.image = self.arrayFire[_animationPicIndex];
    }else{
        //  减速状态，隐藏火焰和空气
        self.airImageV.hidden = YES;
        self.fireImageV.hidden = YES;
    }
    self.carImageV.image = self.arrayCar[_animationPicIndex];
    _animationPicIndex++;
    if (_animationPicIndex == self.arrayCar.count) _animationPicIndex = 0;
    if (self.carXBlock) {
        self.carXBlock(self.layer.presentationLayer.frame.origin.x, self.index);
    }
}

//  加速状态
-(void)speedUPAnimation{
    //  开启火焰和空气
    self.isSpeedUP = YES;

}

//  减速状态
-(void)speedDownAnimation{
    //  隐藏火焰和空气
    self.isSpeedUP = NO;
}

-(void)speedStopAnimation{
    self.airImageV.hidden = YES;
    self.fireImageV.hidden = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self initAnimal:self.index];
}

-(CGFloat)releaseX{
    return self.layer.presentationLayer.frame.origin.x;
}

-(NSArray *)arrayCar{
    if (!_arrayCar) {
        _arrayCar = @[[UIImage imageNamed:[NSString stringWithFormat:@"car%ld-1.png",(long)_index+1]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"car%ld-2.png",(long)_index+1]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"car%ld-3.png",(long)_index+1]],
                      [UIImage imageNamed:[NSString stringWithFormat:@"car%ld-4.png",(long)_index+1]],];
    }
    return _arrayCar;
}
-(NSArray *)arrayAir{
    if (!_arrayAir) {
        _arrayAir = @[[UIImage imageNamed:@"air-1.png"],
                      [UIImage imageNamed:@"air-2.png"],
                      [UIImage imageNamed:@"air-3.png"],
                      [UIImage imageNamed:@"air-4.png"],];
    }
    return _arrayAir;
}

-(NSArray *)arrayFire{
    if (!_arrayFire) {
        _arrayFire = @[[UIImage imageNamed:@"fire-1.png"],
                       [UIImage imageNamed:@"fire-2.png"],
                       [UIImage imageNamed:@"fire-3.png"],
                       [UIImage imageNamed:@"fire-3.png"],];
    }
    return _arrayFire;
}


-(UIImageView *)carImageV{
    if (!_carImageV) {
        _carImageV = [[UIImageView alloc]init];
        [self addSubview:_carImageV];
    }
    return _carImageV;
}

-(UIImageView *)airImageV{
    if (!_airImageV) {
        _airImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wind"]];
        _airImageV.hidden = YES;
        [self addSubview:_airImageV];
    }
    return _airImageV;
}

-(UIImageView *)fireImageV{
    if (!_fireImageV) {
        _fireImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flame"]];
        _fireImageV.hidden = YES;
        [self addSubview:_fireImageV];
    }
    return _fireImageV;
}


@end
