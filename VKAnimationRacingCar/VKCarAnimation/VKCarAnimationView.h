//
//  VKCarAnimationView.h
//  VKOOY_iOS
//
//  Created by Mike on 18/8/30.
//  E-mail:vkooys@163.com
//  Copyright © 2018年 VKOOY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WinNumberBlock)(NSMutableArray *array);

@interface VKCarAnimationView : UIView

@property(nonatomic,copy)WinNumberBlock numberBlock;

//  最终排行Str
@property(nonatomic,copy)NSString *rankingsStr;

- (void)startRun;

- (void)stopRun;

- (void)resetRun;

@end
