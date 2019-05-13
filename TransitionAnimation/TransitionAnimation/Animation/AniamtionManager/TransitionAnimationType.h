//
//  TransitionType.h
//  TransitionAnimation
//
//  Created by 吕其瑞 on 2018/4/28.
//  Copyright © 2018年 吕其瑞. All rights reserved.
//

#ifndef TransitionType_h
#define TransitionType_h

#define AnimationDuration 0.3

//push动画类型
typedef enum : NSUInteger {
    LQR_TransitionTypeSysPushNone = 0,
    //系统动画
    LQR_TransitionTypeSysPushFromRight = 1,
    LQR_TransitionTypeSysPushFromLeft,
    LQR_TransitionTypeSysPushFromTop,
    LQR_TransitionTypeSysPushFromBottom,//Push
    
    LQR_TransitionTypeSysRevealFromRight,
    LQR_TransitionTypeSysRevealFromLeft,
    LQR_TransitionTypeSysRevealFromTop,
    LQR_TransitionTypeSysRevealFromBottom,//揭开
    
    LQR_TransitionTypeSysMoveInFromRight,
    LQR_TransitionTypeSysMoveInFromLeft,
    LQR_TransitionTypeSysMoveInFromTop,
    LQR_TransitionTypeSysMoveInFromBottom,//覆盖
    
    LQR_TransitionTypeSysCubeFromRight,
    LQR_TransitionTypeSysCubeFromLeft,
    LQR_TransitionTypeSysCubeFromTop,
    LQR_TransitionTypeSysCubeFromBottom,//立方体

    
    LQR_TransitionTypeSysOglFlipFromRight,
    LQR_TransitionTypeSysOglFlipFromLeft,
    LQR_TransitionTypeSysOglFlipFromTop,
    LQR_TransitionTypeSysOglFlipFromBottom, //翻转
    
    LQR_TransitionTypeSysPageCurlFromRight,
    LQR_TransitionTypeSysPageCurlFromLeft,
    LQR_TransitionTypeSysPageCurlFromTop,
    LQR_TransitionTypeSysPageCurlFromBottom,//翻页
    
    LQR_TransitionTypeSysCameraIrisHollow,  //开镜头
    
} LQR_PushAnimationOptions;


//present动画
typedef enum : NSUInteger {
    LQR_TransitionTypeNone = 0,

    LQR_TransitionPresentTypeSpreadFromRight = 1,
    LQR_TransitionPresentTypeSpreadFromLeft,
    LQR_TransitionPresentTypeSpreadFromTop,
    LQR_TransitionPresentTypeSpreadFromBottom,
    
    LQR_TransitionPresentTypePage,
    LQR_TransitionPresentTypeCover,
    
    LQR_TransitionPresentTypeCrossDissolve,
    LQR_TransitionPresentTypeCheckerboard,
    
} LQR_PresentAnimationOptions;


#endif /* TransitionType_h */




