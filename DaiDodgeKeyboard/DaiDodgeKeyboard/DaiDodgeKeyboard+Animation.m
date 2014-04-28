//
//  DaiDodgeKeyboard+Animation.m
//  DaiDodgeKeyboard
//
//  Created by 啟倫 陳 on 2014/4/28.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "DaiDodgeKeyboard+Animation.h"

#import "DaiDodgeKeyboard+AccessObject.h"

@implementation DaiDodgeKeyboard (Animation)

+(void) changeFirstResponder : (UIView*) newFirstResponderView {
    if ([self isKeyboardShow]) {
        [self dodgeNewView:newFirstResponderView];
        [self setFristResponderView:newFirstResponderView];
    } else {
        [self setFristResponderView:newFirstResponderView];
    }
}

+(void) dodgeKeyboardAnimation {
    
    UIView *currentFirstResponder = [self firstResponderView];

    CGRect currentKeyboardRect = [[self observerView] convertRect:[self keyboardRect]
                                                         fromView:nil];
    
    CGPoint objectLeftBottom = [currentFirstResponder convertPoint:CGPointMake(0, currentFirstResponder.frame.size.height)
                                                            toView:[self observerView]];
    
    float shiftHeight = objectLeftBottom.y - currentKeyboardRect.origin.y;

    
    if (shiftHeight > 0) {
        [UIView animateWithDuration:[self keyboardAnimationDutation]
                         animations:^{
                             CGRect newFrame = [self observerView].frame;
                             newFrame.origin.y = 0 - shiftHeight;
                             [[self observerView] setFrame:newFrame];
                         }];
    } else {
        [UIView animateWithDuration:[self keyboardAnimationDutation]
                         animations:^{
                             [[self observerView] setFrame:[self originalViewFrame]];
                         }];
    }
    
}

+(void) dodgeNewView : (UIView*) newView {

    CGRect currentKeyboardRect = [[self observerView] convertRect:[self keyboardRect]
                                                         fromView:nil];

    CGPoint newObjectLeftBottom = [newView convertPoint:CGPointMake(0, newView.frame.size.height)
                                                 toView:[self observerView]];
    
    float newShiftHeight = newObjectLeftBottom.y - currentKeyboardRect.origin.y;
    
    CGRect newFrame = [self observerView].frame;
    
    if (newFrame.origin.y - newShiftHeight < 0) {
        
        [UIView animateWithDuration:[self keyboardAnimationDutation]
                         animations:^{
                             CGRect newFrame = [self observerView].frame;
                             newFrame.origin.y -= newShiftHeight;
                             [[self observerView] setFrame:newFrame];
                         }];
        
    } else {
        
        [UIView animateWithDuration:[self keyboardAnimationDutation]
                         animations:^{
                             [[self observerView] setFrame:[self originalViewFrame]];
                         }];
        
    }
    
}


@end