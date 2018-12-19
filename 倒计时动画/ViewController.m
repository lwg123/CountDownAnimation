//
//  ViewController.m
//  倒计时动画
//
//  Created by weiguang on 2018/12/18.
//  Copyright © 2018年 duia. All rights reserved.
//

#import "ViewController.h"
#import "CountDownView.h"

@interface ViewController ()<CountDownViewDelegate>

@property (nonatomic,strong) CountDownView *countDownView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)dealloc {
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 不自动锁屏
   // [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    // 自动锁屏
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    
    [self setUpCountDownView];
}

// 设置倒计时页面
- (void)setUpCountDownView {
    self.countDownView = [[NSBundle mainBundle] loadNibNamed:@"CountDownView" owner:nil options:nil].lastObject;
    self.countDownView.frame = self.view.bounds;
    self.countDownView.delegate = self;
    [self.view addSubview:self.countDownView];
    
    [self.countDownView startAni];
}


- (void)popAniFinished {
    
    NSLog(@"动画结束");
}

@end
