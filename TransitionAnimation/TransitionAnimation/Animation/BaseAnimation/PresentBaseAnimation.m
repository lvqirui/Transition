//
//  PresentBaseAnimation.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/5/9.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "PresentBaseAnimation.h"

@implementation PresentBaseAnimation

-(instancetype)initWithPresentTransition:(LQR_PresentAnimationOptions)option completeBlock:(void(^)(void))completeBlock;
{
    if (self = [super init]) {
        self.presentOption = option;
        self.completeBlock = completeBlock;
    }
    return self;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
     BOOL isPresenting = (self.toViewController.presentingViewController == self.fromViewController);
    self.presenting  =isPresenting;
    
}

@end
