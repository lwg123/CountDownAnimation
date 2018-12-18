//
//  CountDownView.m
//  倒计时动画
//
//  Created by weiguang on 2018/12/18.
//  Copyright © 2018年 duia. All rights reserved.
//

#import "CountDownView.h"
#import <pop/POP.h>

@interface CountDownView()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *bjView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic,strong) NSTimer *countTimer;
@property (nonatomic,assign) NSInteger currentCount;

@end


@implementation CountDownView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.currentCount = 5;
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld",_currentCount];
}

#pragma mark - 计时器相关
- (void)startAni {
    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startCountDown) userInfo:nil repeats:YES];
}

// 计时器方法
- (void)startCountDown {
    _currentCount--;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",_currentCount];
    
    if (_currentCount == 0) {
        [self cancelAni];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.fillMode = kCAFillModeForwards;
        animationGroup.removedOnCompletion = NO;
        animationGroup.autoreverses = NO;
        animationGroup.delegate = self;
        animationGroup.duration = 0.5;
        animationGroup.repeatCount = 0;

        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:10];

        //透明度
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [self.bjView.layer addAnimation:animationGroup forKey:@"plulsing"];
        
    }else {
        [self popAni];
    }
    
}

// 暂停
- (void)pauseAni {
    [self.countTimer setFireDate:[NSDate distantFuture]];
}

// 继续
- (void)continueAni {
    [self.countTimer setFireDate:[NSDate date]];
}

// 取消
- (void)cancelAni {
    if (self.countTimer && [self.countTimer isValid]) {
        [self.countTimer invalidate];
        self.countTimer = nil;
    }
}

#pragma mark - pop动画
- (void)popAni {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    //它会先缩小到(0.5,0.5),然后再去放大到(1.0,1.0)
    springAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.6, 0.6)];
    springAnimation.toValue =[NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    springAnimation.springBounciness = 20;
    //动画结束之后的回调方法
    [springAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        NSLog(@"ani finished");
        
    }];
    [self.bjView.layer pop_addAnimation:springAnimation forKey:@"SpringAnimation"];
}


#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(popAniFinished)]) {
        [self.delegate popAniFinished];
    }
}

@end
