//
//  TranslationAnimation.m
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/28.
//  Copyright © 2018年 吕其瑞. All rights reserved.
// 

#import "PushAnimation.h"

@implementation PushAnimation

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
    
    [self.containerView addSubview:self.fromView];
    [self.containerView addSubview:self.toView];
        
    if (self.pushing) {
        //如果是push动画
        [self performPushAniamtion];
    } else {
        //如果是Pop动画
        [self performPopAnimation];
    }
    
}

-(void)performPushAniamtion
{
    
    CATransition *transiton = [CATransition animation];
    switch (self.pushOption) {
        case LQR_TransitionTypeSysPushFromRight:
            transiton.type = kCATransitionPush;
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysPushFromLeft:
            transiton.type = kCATransitionPush;
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysPushFromTop:
            transiton.type = kCATransitionPush;
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysPushFromBottom:
            transiton.type = kCATransitionPush;
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysRevealFromRight:
            transiton.type = kCATransitionReveal;
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysRevealFromLeft:
            transiton.type = kCATransitionReveal;
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysRevealFromTop:
            transiton.type = kCATransitionReveal;
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysRevealFromBottom:
            transiton.type = kCATransitionReveal;
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysMoveInFromRight:
            transiton.type = kCATransitionMoveIn;
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysMoveInFromLeft:
            transiton.type = kCATransitionMoveIn;
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysMoveInFromTop:
            transiton.type = kCATransitionMoveIn;
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysMoveInFromBottom:
            transiton.type = kCATransitionMoveIn;
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysCubeFromRight:
            transiton.type = @"cube";
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysCubeFromLeft:
            transiton.type = @"cube";
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysCubeFromTop:
            transiton.type = @"cube";
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysCubeFromBottom:
            transiton.type=@"cube";
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysOglFlipFromRight:
            transiton.type=@"oglFlip";
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysOglFlipFromLeft:
            transiton.type=@"oglFlip";
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysOglFlipFromTop:
            transiton.type=@"oglFlip";
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysOglFlipFromBottom:
            transiton.type=@"oglFlip";
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysPageCurlFromRight:
            transiton.type=@"pageCurl";
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysPageCurlFromLeft:
            transiton.type=@"pageCurl";
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysPageCurlFromTop:
            transiton.type=@"pageCurl";
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysPageCurlFromBottom:
            transiton.type=@"pageCurl";
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysCameraIrisHollow:
            transiton.type=@"cameraIrisHollowOpen";
            break;
        default:
            break;
    }
    transiton.duration = AnimationDuration;
    [self.containerView.layer addAnimation:transiton forKey:@"AnimationKey"];
    [self.transitionContext completeTransition:YES];
}

-(void)performPopAnimation
{
    
    CATransition *transiton = [CATransition animation];
    switch (self.pushOption) {
        case LQR_TransitionTypeSysPushFromRight:
            transiton.type = kCATransitionPush;
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysPushFromLeft:
            transiton.type = kCATransitionPush;
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysPushFromTop:
            transiton.type = kCATransitionPush;
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysPushFromBottom:
            transiton.type = kCATransitionPush;
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysRevealFromRight:
            transiton.type = kCATransitionReveal;
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysRevealFromLeft:
            transiton.type = kCATransitionReveal;
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysRevealFromTop:
            transiton.type = kCATransitionReveal;
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysRevealFromBottom:
            transiton.type = kCATransitionReveal;
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysMoveInFromRight:
            transiton.type = kCATransitionMoveIn;
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysMoveInFromLeft:
            transiton.type = kCATransitionMoveIn;
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysMoveInFromTop:
            transiton.type = kCATransitionMoveIn;
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysMoveInFromBottom:
            transiton.type = kCATransitionMoveIn;
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysCubeFromRight:
            transiton.type = @"cube";
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysCubeFromLeft:
            transiton.type = @"cube";
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysCubeFromTop:
            transiton.type = @"cube";
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysCubeFromBottom:
            transiton.type=@"cube";
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysOglFlipFromRight:
            transiton.type=@"oglFlip";
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysOglFlipFromLeft:
            transiton.type=@"oglFlip";
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysOglFlipFromTop:
            transiton.type=@"oglFlip";
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysOglFlipFromBottom:
            transiton.type=@"oglFlip";
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysPageCurlFromRight:
            transiton.type=@"pageUnCurl";
            transiton.subtype=kCATransitionFromRight;
            break;
        case LQR_TransitionTypeSysPageCurlFromLeft:
            transiton.type=@"pageUnCurl";
            transiton.subtype=kCATransitionFromLeft;
            break;
        case LQR_TransitionTypeSysPageCurlFromTop:
            transiton.type=@"pageUnCurl";
            transiton.subtype=kCATransitionFromTop;
            break;
        case LQR_TransitionTypeSysPageCurlFromBottom:
            transiton.type=@"pageUnCurl";
            transiton.subtype=kCATransitionFromBottom;
            break;
        case LQR_TransitionTypeSysCameraIrisHollow:
            transiton.type=@"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    transiton.duration = AnimationDuration;
    [self.containerView.layer addAnimation:transiton forKey:@"AnimationKey"];
    [self.transitionContext completeTransition:YES];
}




@end
