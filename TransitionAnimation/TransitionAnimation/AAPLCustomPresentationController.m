/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A custom presentation controller which slides the presenting view controller
  upwards to reveal the presented view controller.
 */

#import "AAPLCustomPresentationController.h"

//应用于包含所述视图控制器的视图的角半径。
#define CORNER_RADIUS   16.f

@interface AAPLCustomPresentationController () <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *presentationWrappingView;
@end


@implementation AAPLCustomPresentationController

/*
 
 
 0.设置presentedController代理transitioningDelegate为self
 
 0.1. 实现代理- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
 0.2. - (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
 0.3. - (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
 
 0.4.动画实现 - (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
 
 0.5.动画时间 - (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
 
 1.初始化对象，设置modalPresentationStyle 为UIModalPresentationCustom
 重写下面方法:
 1.1  - (UIView*)presentedView 返回要展示的view
 
 1.2 - (void)presentationTransitionWillBegin 此方法添加独立与presentedViewController和presentingViewController的view,比如一个半透明的底部蒙层
 
 1.3 - (void)presentationTransitionDidEnd:(BOOL)completed
 
 1.4 - (void)dismissalTransitionWillBegin
 
 1.5 - (void)dismissalTransitionDidEnd:(BOOL)completed
 
 1.6   - (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container  presentedView的preferredContentSize改变时调用这个方法，
 方法实现:(调用[self.containerView setNeedsLayout];调用- (void)containerViewWillLayoutSubviews)
 
 1.7  - (void)containerViewWillLayoutSubviews 函数实现（修改 - (void)presentationTransitionWillBegin 函数里创建的view的布局）
 
 1.8 - (CGRect)frameOfPresentedViewInContainerView 设置resentedView的frame
 
 */



//| ----------------------------------------------------------------------------
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    if (self) {
        
//      被呈现的视图控制器必须具有modalPresentationStyle用于自定义表示控制器的UIModalPresentationCustom要使用。
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    
    return self;
}


//| ----------------------------------------------------------------------------
- (UIView*)presentedView
{
    
    NSLog(@"执行了------%s",__FUNCTION__);
    
    //返回在-presentationTransitionWillBegin中创建的包装视图。
    return self.presentationWrappingView;
}
- (void)presentationTransitionWillBegin
{
    NSLog(@"执行了------%s",__FUNCTION__);
    
    //默认self.presentedViewController.view
    UIView *presentedViewControllerView = [super presentedView];
    
    //将当前视图控制器的视图包装在中间层次结构中在左上角和右上角应用阴影和圆角边缘。最后的效果是使用三个中间视图构建的。
    // presentationWrapperView              <- shadow 阴影view
    //   |- presentationRoundedCornerView   <- rounded corners (masksToBounds) 圆角view
    //        |- presentedViewControllerWrapperView
    //             |- presentedViewControllerView (presentedViewController.view)
    //
    {
        
        //创建阴影view
        UIView *presentationWrapperView = [[UIView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
        presentationWrapperView.layer.shadowOpacity = 0.44f;
        presentationWrapperView.layer.shadowRadius = 13.f;
        presentationWrapperView.layer.shadowOffset = CGSizeMake(0, -6.f);
        self.presentationWrappingView = presentationWrapperView;
        
    
        UIView *presentationRoundedCornerView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, 0, -CORNER_RADIUS, 0))];
        presentationRoundedCornerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentationRoundedCornerView.layer.cornerRadius = CORNER_RADIUS;
        presentationRoundedCornerView.layer.masksToBounds = YES;
        
    
        UIView *presentedViewControllerWrapperView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 0, CORNER_RADIUS, 0))];
        presentedViewControllerWrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // Add presentedViewControllerView -> presentedViewControllerWrapperView.
        presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds;
        [presentedViewControllerWrapperView addSubview:presentedViewControllerView];
        
        // Add presentedViewControllerWrapperView -> presentationRoundedCornerView.
        [presentationRoundedCornerView addSubview:presentedViewControllerWrapperView];
        
        // Add presentationRoundedCornerView -> presentationWrapperView.
        [presentationWrapperView addSubview:presentationRoundedCornerView];
        
        
    }
    
    {
        UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        dimmingView.backgroundColor = [UIColor blackColor];
        dimmingView.opaque = NO;
        dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
        self.dimmingView = dimmingView;
        [self.containerView addSubview:dimmingView];
        

        id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
        
        self.dimmingView.alpha = 0.f;
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.dimmingView.alpha = 0.5f;
        } completion:NULL];
    }
}


//| ----------------------------------------------------------------------------
- (void)presentationTransitionDidEnd:(BOOL)completed
{
    NSLog(@"执行了------%s",__FUNCTION__);
    if (completed == NO)
    {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}


//| ----------------------------------------------------------------------------
- (void)dismissalTransitionWillBegin
{
    NSLog(@"执行了------%s",__FUNCTION__);
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}


//| ----------------------------------------------------------------------------
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    NSLog(@"执行了------%s",__FUNCTION__);
    if (completed == YES)
    {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}

#pragma mark -
#pragma mark Layout
  - (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    NSLog(@"执行了------%s",__FUNCTION__);
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController);
        [self.containerView setNeedsLayout];
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    NSLog(@"执行了------%s",__FUNCTION__);
    if (container == self.presentedViewController)
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}


//| ----------------------------------------------------------------------------
- (CGRect)frameOfPresentedViewInContainerView
{
    NSLog(@"执行了------%s",__FUNCTION__);
    //容器view大小
    CGRect containerViewBounds = self.containerView.bounds;
    //被弹出视图contentSize
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    return presentedViewControllerFrame;
}

- (void)containerViewWillLayoutSubviews
{
    NSLog(@"执行了------%s",__FUNCTION__);
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}

#pragma mark -
#pragma mark Tap Gesture Recognizer
- (IBAction)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    NSLog(@"执行了------%s",__FUNCTION__);
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark UIViewControllerAnimatedTransitioning


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"执行了------%s",__FUNCTION__);
    return [transitionContext isAnimated] ? 0.35 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"执行了------%s",__FUNCTION__);
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    CGRect __unused fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewController];

    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromViewController];
    
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toViewController];

    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    [containerView addSubview:toView];
    
    if (isPresenting) {
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        toViewInitialFrame.size = toViewFinalFrame.size;
        toView.frame = toViewInitialFrame;
    } else {
        fromViewFinalFrame = CGRectOffset(fromView.frame, 0, CGRectGetHeight(fromView.frame));
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting)
            toView.frame = toViewFinalFrame;
        else
            fromView.frame = fromViewFinalFrame;
        
    } completion:^(BOOL finished) {

        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSLog(@"执行了------%s",__FUNCTION__);
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    
    return self;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NSLog(@"执行了------%s",__FUNCTION__);
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NSLog(@"执行了------%s",__FUNCTION__);
    return self;
}

@end
