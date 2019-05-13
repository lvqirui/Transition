//
//  TransitonAnimationManager.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/24.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "TransitionAnimationManager.h"
#import "PushAnimation.h"

#import "UIViewController+Animation.h"

@interface TransitionAnimationManager()

@property (nonatomic,copy)void(^completeBlock)(void);

@end

@implementation TransitionAnimationManager

+(instancetype)shareInstance
{
    static TransitionAnimationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TransitionAnimationManager alloc] init];
    });
    return manager;
}

#pragma mark----动画代理


//通过导航栏 push pop 控制器
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        if (toVC.pushOption != LQR_TransitionTypeSysPushNone) {
           return [[PushAnimation alloc] initWithPushTransition:toVC.pushOption completeBlock:^{
               if (fromVC.animationComplete) {
                   fromVC.animationComplete();
               }
            }];
        } else {
            return nil;
        }

    } else if (operation == UINavigationControllerOperationPop) {
        if (fromVC.pushOption != LQR_TransitionTypeSysPushNone) {
            return [[PushAnimation alloc] initWithPushTransition:fromVC.pushOption completeBlock:^{
                NSLog(@"dismiss动画执行完毕");
            }];
        }
    }
    return nil;
}


@end
