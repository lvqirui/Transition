//
//  UIViewController+PresentAnimation.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/24.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "UIViewController+Animation.h"
#import "TransitionAnimationManager.h"
#import <objc/runtime.h>
#import "SpreadAnimation.h"
#import "PageAnimation.h"
#import "CoverAnimation.h"
#import "CrossDissolveAnimation.h"
#import "CheckerboardAnimation.h"

@implementation UIViewController (Animation)

-(void)setAnimationComplete:(void (^)(void))animationComplete
{
    objc_setAssociatedObject(self, @"animationComplete", animationComplete, OBJC_ASSOCIATION_COPY);
}

-(void (^)(void))animationComplete
{
    return objc_getAssociatedObject(self, @"animationComplete");
}

-(void)setPushOption:(LQR_PushAnimationOptions)pushOption
{
    objc_setAssociatedObject(self, @"pushOption", @(pushOption), OBJC_ASSOCIATION_ASSIGN);
}

-(LQR_PushAnimationOptions)pushOption
{
    return [objc_getAssociatedObject(self, @"pushOption") integerValue];
}

-(void)setPresentOption:(LQR_PresentAnimationOptions)presentOption
{
    objc_setAssociatedObject(self, @"presentOption", @(presentOption), OBJC_ASSOCIATION_ASSIGN);
}

-(LQR_PresentAnimationOptions)presentOption
{
    return [objc_getAssociatedObject(self, @"presentOption") integerValue];
}

-(void)presentViewController:(UIViewController *)targetVC animationType:(LQR_PresentAnimationOptions)option complete:(void(^)(void))complete
{
    if (option != LQR_TransitionTypeNone) {
        self.presentOption = option;
        self.animationComplete = complete;
        targetVC.transitioningDelegate = self;
    }

    [self presentViewController:targetVC animated:YES completion:nil];
}

//make transition With Completion
-(void)pushViewController:(UIViewController *)targetVC animationType:(LQR_PushAnimationOptions)option complete:(void(^)(void))complete {
    
    if (option != LQR_TransitionTypeSysPushNone) {
        self.animationComplete = complete;
        targetVC.pushOption = option;
        if (!self.navigationController.delegate) {
            self.navigationController.delegate = [TransitionAnimationManager shareInstance];
        }
    }

    [self.navigationController pushViewController:targetVC animated:YES];
}

//present动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [self loadAnimationWithSource:source];
}

//dismiss动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [self loadAnimationWithSource:nil];
}

-(id<UIViewControllerAnimatedTransitioning>)loadAnimationWithSource:(UIViewController *)source
{
    
    NSArray *array = @[@"SpreadAnimation",
                       @"PageAnimation",
                       @"CoverAnimation",
                       @"CrossDissolveAnimation",
                       @"CheckerboardAnimation"];
    NSString *classString = nil;
    
    switch (self.presentOption) {
        case LQR_TransitionPresentTypeSpreadFromRight:
        case LQR_TransitionPresentTypeSpreadFromLeft:
        case LQR_TransitionPresentTypeSpreadFromTop:
        case LQR_TransitionPresentTypeSpreadFromBottom:
        {
            classString = array[0];
        }
            break;
        case LQR_TransitionPresentTypePage:
        {
            classString = array[1];
        }
            break;
        case LQR_TransitionPresentTypeCover:
        {
            classString = array[2];
        }
            break;
        case LQR_TransitionPresentTypeCrossDissolve:
        {
            classString = array[3];
        }
            break;
        case LQR_TransitionPresentTypeCheckerboard:
        {
            classString = array[4];
        }
            break;
        default:
            return nil;
            break;
    }
    
    if ([NSClassFromString(classString) isSubclassOfClass:[PresentBaseAnimation class]]) {
        return [[NSClassFromString(classString) alloc] initWithPresentTransition:self.presentOption completeBlock:^{
            if (source.animationComplete) {
                source.animationComplete();
            }
        }];
    }
    
    return nil;
}





@end
