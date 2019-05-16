//
//  TransitionAnimation.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/29.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "SpreadAnimation.h"

@implementation SpreadAnimation

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
    
    self.transitionContext = transitionContext;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    if (self.presenting) {
        UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
        self.tempView = tempView;
        [containerView addSubview:toVC.view];
        [containerView addSubview:fromVC.view];
        [containerView addSubview:tempView];
    } else {
        UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
        self.tempView = tempView;
        [containerView addSubview:fromVC.view];
        [containerView addSubview:toVC.view];
        [containerView addSubview:tempView];
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect rect0 ;
    CGRect rect1 ;
    
    if (self.presenting) {
        rect1 = CGRectMake(0, 0, screenWidth, screenHeight);
        switch (self.presentOption) {
            case LQR_TransitionPresentTypeSpreadFromRight:
                rect0 = CGRectMake(screenWidth, 0, 2, screenHeight);
                break;
            case LQR_TransitionPresentTypeSpreadFromLeft:
                rect0 = CGRectMake(0, 0, 2, screenHeight);
                break;
            case LQR_TransitionPresentTypeSpreadFromTop:
                rect0 = CGRectMake(0, 0, screenWidth, 2);
                break;
            default:
                rect0 = CGRectMake(0, screenHeight , screenWidth, 2);
                break;
        }
    } else {
        rect0 = CGRectMake(0, 0, screenWidth, screenHeight);
        switch (self.presentOption) {
            case LQR_TransitionPresentTypeSpreadFromRight:
                rect1 = CGRectMake(screenWidth, 0, 1, screenHeight);
                break;
            case LQR_TransitionPresentTypeSpreadFromLeft:
                rect1 = CGRectMake(0, 0, 1, screenHeight);
                break;
            case LQR_TransitionPresentTypeSpreadFromTop:
                rect1 = CGRectMake(0, 0, screenWidth, 1);
                break;
            default:
                rect1 = CGRectMake(0, screenHeight, screenWidth, 1);
                break;
        }
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:rect0];
    UIBezierPath *endPath =[UIBezierPath bezierPathWithRect:rect1];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath; //动画结束后的值
    self.tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = AnimationDuration;
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:@"NextPath"];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [self.transitionContext completeTransition:YES];
        [self.tempView removeFromSuperview];
    }
}

@end
