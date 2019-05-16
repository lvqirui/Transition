//
//  PageAnimation.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/5/6.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "PageAnimation.h"

@implementation PageAnimation

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = nil;
    if (self.presenting) {
        tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        
    } else {
        tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    }

    
    UIView *containerView = [transitionContext containerView];

    if (self.presenting) {
        
        [containerView addSubview:toVC.view];
        [containerView addSubview:tempView];
        [containerView insertSubview:toVC.view atIndex:0];
        
        tempView.frame = fromVC.view.frame;
        fromVC.view.hidden = YES;
        CGPoint point = CGPointMake(0, 0.5);
        tempView.frame = CGRectOffset(tempView.frame, (point.x - tempView.layer.anchorPoint.x) * tempView.frame.size.width, (point.y - tempView.layer.anchorPoint.y) * tempView.frame.size.height);
        tempView.layer.anchorPoint = point;
        CATransform3D transfrom3d = CATransform3DIdentity;
        transfrom3d.m34 = -0.002;
        containerView.layer.sublayerTransform = transfrom3d;
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
            
        } completion:^(BOOL finished) {
            
            if ([transitionContext transitionWasCancelled]) {
                [tempView removeFromSuperview];
                
                [transitionContext completeTransition:NO];
            }else{
                [transitionContext completeTransition:YES];
            }
            fromVC.view.hidden = NO;
        }];
    } else {
        [containerView addSubview:fromVC.view];
        [containerView addSubview:tempView];
        
        tempView.frame = fromVC.view.frame;
        CGPoint point = CGPointMake(0, 0.5);
        tempView.frame = CGRectOffset(tempView.frame, (point.x - tempView.layer.anchorPoint.x) * tempView.frame.size.width, (point.y - tempView.layer.anchorPoint.y) * tempView.frame.size.height);
        tempView.layer.anchorPoint = point;
        tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            
            tempView.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
           
        } completion:^(BOOL finished) {
            
            [containerView addSubview:toVC.view];
            
            if ([transitionContext transitionWasCancelled]) {
                [tempView removeFromSuperview];
                
                [transitionContext completeTransition:NO];
            }else{
                NSLog(@"tempView=====%@",tempView);
                [transitionContext completeTransition:YES];
            }
        }];
    }
    

}



@end
