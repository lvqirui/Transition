//
//  PresentBaseAnimation.h
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/5/9.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "BaseAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface PresentBaseAnimation : BaseAnimation

@property (nonatomic,assign)  LQR_PresentAnimationOptions presentOption;
@property (nonatomic,assign)  BOOL presenting;  //YES是present动画，NO是Dismiss动画

-(instancetype)initWithPresentTransition:(LQR_PresentAnimationOptions)option completeBlock:(void(^)(void))completeBlock;
@end

NS_ASSUME_NONNULL_END
