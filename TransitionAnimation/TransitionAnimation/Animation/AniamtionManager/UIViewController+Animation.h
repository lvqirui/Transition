//
//  UIViewController+PresentAnimation.h
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/24.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionAnimationType.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Animation)<UIViewControllerTransitioningDelegate>

@property (nonatomic,copy) void(^animationComplete)(void);

@property (nonatomic,assign) LQR_PushAnimationOptions pushOption;
@property (nonatomic,assign) LQR_PresentAnimationOptions presentOption;

-(void)presentViewController:(UIViewController *)targetVC animationType:(LQR_PresentAnimationOptions)option complete:(void(^)(void))complete;

-(void)pushViewController:(UIViewController *)targetVC animationType:(LQR_PushAnimationOptions)option complete:(void(^)(void))complete;

@end

NS_ASSUME_NONNULL_END
