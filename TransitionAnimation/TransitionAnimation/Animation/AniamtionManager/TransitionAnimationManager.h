//
//  TransitonAnimationManager.h
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/24.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransitionAnimationType.h"
@import UIKit;
NS_ASSUME_NONNULL_BEGIN

@interface TransitionAnimationManager : NSObject<UINavigationControllerDelegate>
+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
