//
//  CountDownView.h
//  倒计时动画
//
//  Created by weiguang on 2018/12/18.
//  Copyright © 2018年 duia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CountDownViewDelegate <NSObject>

- (void)popAniFinished;

@end


@interface CountDownView : UIView

@property (nonatomic,weak) id<CountDownViewDelegate> delegate;

// 倒计时方法
- (void)startAni;       // 开始
- (void)pauseAni;       // 暂停
- (void)continueAni;    // 继续
- (void)cancelAni;      // 取消

- (void)popAni;         // 放大缩小动画

@end

NS_ASSUME_NONNULL_END
