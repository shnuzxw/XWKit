//
//  XWCalendarTransition.m
//  Pods
//
//  Created by smile.zhang on 16/6/16.
//
//

#import "XWCalendarTransition.h"

@interface XWCalendarTransition ()<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL                     isDismiss;
@property (nonatomic, assign) XWCalendarTransitionType type;

@end

@implementation XWCalendarTransition

- (instancetype)initWithType:(XWCalendarTransitionType)type {

    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isDismiss = NO;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isDismiss = YES;
    return self;
}

//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
//
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
//
//}
//
//- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
//
//}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    CGRect toFrame = toViewController.view.frame;
    CGRect fromFrameForPresent = CGRectMake(0, toFrame.size.height, toFrame.size.width, toFrame.size.height);
//    CGRect fromFrameForZoom = CGRectMake(toFrame.size.width / 2, toFrame.size.height / 2, 0, 0);
    if (!self.isDismiss) {//present

        if (_type == XWCalendarTransitionTypePresent) {
            toViewController.view.frame = fromFrameForPresent;
        } else if (_type == XWCalendarTransitionTypeZoom) {
            toViewController.view.alpha = 0;
        }

        [containerView addSubview:toViewController.view];
        if (toViewController.modalPresentationStyle == UIModalPresentationCustom) {

            [fromViewController beginAppearanceTransition:NO animated:YES];
        }

        [UIView animateWithDuration:duration animations:^{

            if (_type == XWCalendarTransitionTypePresent) {
                toViewController.view.frame = toFrame;
            } else if (_type == XWCalendarTransitionTypeZoom) {
                toViewController.view.alpha = 1;
            }

        } completion:^(BOOL finished) {

            if (toViewController.modalPresentationStyle == UIModalPresentationCustom) {

                [fromViewController endAppearanceTransition];
            }
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];

    } else {//dismiss

        [containerView bringSubviewToFront:fromViewController.view];

        if (fromViewController.modalPresentationStyle == UIModalPresentationCustom) {

            [toViewController beginAppearanceTransition:YES animated:YES];
        }

        [UIView animateWithDuration:duration animations:^{

            if (_type == XWCalendarTransitionTypePresent) {
                fromViewController.view.frame = fromFrameForPresent;;
            } else if (_type == XWCalendarTransitionTypeZoom) {
                fromViewController.view.alpha = 0;
            }

        } completion:^(BOOL finished) {

            [fromViewController.view removeFromSuperview];
            fromViewController.view = nil;

            if (fromViewController.modalPresentationStyle == UIModalPresentationCustom) {

                [toViewController endAppearanceTransition];
            }
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSLog(@"动画结束");
}

@end
