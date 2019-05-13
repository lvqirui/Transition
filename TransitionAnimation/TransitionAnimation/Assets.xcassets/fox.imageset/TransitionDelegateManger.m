//
//  TransitionDelegateManger.m
//  TransitionAnimation
//
//  Created by ouyang feng on 2019/4/26.
//  Copyright © 2019年 ouyang feng. All rights reserved.
//

#import "TransitionDelegateManger.h"
#import "CustomAnimation.h"
#import "SystemAnimation.h"
@interface TransitionDelegateManger()

@property (nonatomic,assign) PushOrPresentTransitionType transitionType;

@end


@implementation TransitionDelegateManger

-(instancetype)initWithTransitionType:(NSIndexPath *)indexPath
{
    if (self = [super init]) {
        
        NSInteger selectIndex = indexPath.row;
        if (selectIndex <=9) {
            self.transitionType = 1 << selectIndex;
        } else if (selectIndex>=10 && selectIndex <= 13) {
            self.transitionType = (selectIndex - 10) << 16;
        } else if (selectIndex ) {
            self.transitionType = (selectIndex - 14) << 20;;
        }
    }
    return self;
}



-(id<UIViewControllerAnimatedTransitioning>)loadAnimation
{
    switch (self.transitionType) {
        case LQR_PushFromLeftToRight:
        case LQR_PushFromRightToLeft:
        case LQR_PushFromTopToBottom:
        case LQR_PushFromBottomToTop:{
            return [[CustomAnimation alloc] initWithTransitionType:self.transitionType];
        }
            break;
            
        default:{
            return [[SystemAnimation alloc] initWithTransitionType:self.transitionType];
        }
            break;
    }
}




@end



#pragma mark-----BasicAnimation.keypath


