//
//  PushBaseAnimation.h
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/5/9.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import "BaseAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface PushBaseAnimation : BaseAnimation

@property (nonatomic,assign)  LQR_PushAnimationOptions pushOption;
@property (nonatomic,assign)  BOOL pushing;

-(instancetype)initWithPushTransition:(LQR_PushAnimationOptions)option completeBlock:(void(^)(void))completeBlock;

@end

NS_ASSUME_NONNULL_END
