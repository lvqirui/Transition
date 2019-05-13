//
//  BaseAnimation.h
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/24.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransitionAnimationType.h"
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

@interface BaseAnimation : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property (nonatomic,strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic,copy)void(^completeBlock)(void);
@property (nonatomic,strong)  UIView *tempView;
@property (nonatomic,strong)  UIView *fromView;
@property (nonatomic,strong)  UIView *toView;
@property (nonatomic,strong)  UIView *containerView;

@property (nonatomic,strong)  UIViewController *fromViewController;
@property (nonatomic,strong)  UIViewController *toViewController;

@end

NS_ASSUME_NONNULL_END
