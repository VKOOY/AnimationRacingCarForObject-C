//
//  ViewController.m
//  VKOOY_iOS
//
//  Created by Mike on 18/8/30.
//  E-mail:vkooys@163.com
//  Copyright © 2018年 VKOOY. All rights reserved.
//

#import "ViewController.h"
#import "VKCarAnimationView.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) VKCarAnimationView *carAniView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI {
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 50)];
    [self.view addSubview:_lab = lab];
    
    [self animationView];
    
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 350, 100, 45)];
    [startBtn setTitle:@"Start" forState:(UIControlStateNormal)];
    startBtn.backgroundColor = [UIColor blueColor];
    startBtn.tag = 1000;
    [self.view addSubview:startBtn];
    [startBtn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(140, 350, 100, 45)];
    [stopBtn setTitle:@"Stop" forState:(UIControlStateNormal)];
    stopBtn.backgroundColor = [UIColor brownColor];
    stopBtn.tag = 2000;
    [self.view addSubview:stopBtn];
    [stopBtn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 425, 100, 45)];
    [resetBtn setTitle:@"Reset" forState:(UIControlStateNormal)];
    resetBtn.backgroundColor = [UIColor grayColor];
    resetBtn.tag = 3000;
    [self.view addSubview:resetBtn];
    [resetBtn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)btnAction:(UIButton *)button {
    if (button.tag == 1000) {           //  Start
        
        [_carAniView startRun];
    } else if (button.tag == 2000) {    //  Stop
        _carAniView.rankingsStr = @"1,2,3,4,5,6,7,8,9,10";
//        _carAniView.rankingsStr = @"8,2,7,5,1,10,6,4,9,3";
        
        [_carAniView stopRun];
    } else {                            //  Reset
        [_carAniView resetRun];
    }
}

- (void)animationView {
    VKCarAnimationView *view = [[VKCarAnimationView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 200)];

    view.numberBlock = ^(NSMutableArray *array) {
        _lab.text = @"";
        for (NSString *str in array) {
            _lab.text = [_lab.text stringByAppendingString:[NSString stringWithFormat:@"++%@",str]];
        }
    };
    [self.view addSubview:_carAniView = view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"===============================================================");
}




@end
