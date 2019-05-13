//
//  BaseAnimation.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/24.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "BaseAnimation.h"

@interface BaseAnimation()

@end

@implementation BaseAnimation


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
{
    return AnimationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    self.toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    self.containerView = transitionContext.containerView;
    self.transitionContext = transitionContext;
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    if (transitionCompleted) {
        if (self.completeBlock) {
            self.completeBlock();
        }
    }
}

-(void)dealloc
{
    NSLog(@"动画对象释放了");
}

@end
