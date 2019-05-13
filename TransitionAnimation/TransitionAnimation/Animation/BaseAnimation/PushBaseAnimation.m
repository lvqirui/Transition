//
//  PushBaseAnimation.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/5/9.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "PushBaseAnimation.h"

@implementation PushBaseAnimation

-(instancetype)initWithPushTransition:(LQR_PushAnimationOptions)option completeBlock:(void(^)(void))completeBlock
{
    if (self = [super init]) {
        self.pushOption = option;
        self.completeBlock = completeBlock;
    }
    return self;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
    
    BOOL isPush = ([self.toViewController.navigationController.viewControllers indexOfObject:self.toViewController] > [self.fromViewController.navigationController.viewControllers indexOfObject:self.fromViewController]);
    
    self.pushing = isPush;
}

@end
