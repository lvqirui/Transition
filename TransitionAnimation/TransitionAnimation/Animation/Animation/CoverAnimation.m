//
//  CoverAnimation.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/5/6.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "CoverAnimation.h"

@implementation CoverAnimation
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containView = [transitionContext containerView];

    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    

    
    if (self.presenting) {
        UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
        [containView addSubview:tempView];
        
        tempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
        tempView.alpha = 0.1;
        tempView.hidden = NO;
        
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            
            tempView.layer.transform = CATransform3DIdentity;
            tempView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            if ([transitionContext transitionWasCancelled]) {
                toVC.view.hidden = YES;
                [transitionContext completeTransition:NO];
            }else{
                toVC.view.hidden = NO;
                [transitionContext completeTransition:YES];
            }
            [tempView removeFromSuperview];
            
        }];
    } else {
        
        UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
        [containView addSubview:tempView];
        fromVC.view.hidden = YES;
        
        [UIView animateWithDuration:AnimationDuration animations:^{
            
            tempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
            tempView.alpha = 0.1;
            
        } completion:^(BOOL finished) {
            
            if ([transitionContext transitionWasCancelled]) {
                fromVC.view.hidden = YES;
                [transitionContext completeTransition:NO];
            }else{
                fromVC.view.hidden = NO;
                [transitionContext completeTransition:YES];
            }
            [tempView removeFromSuperview];
            
        }];
        
        
        
    }
    

}
@end
