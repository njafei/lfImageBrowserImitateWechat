//
//  LFPanVerticalGestureRecognizer.m
//  LFImageBrowserImitateWechat
//
//  Created by fei on 2018/8/11.
//  Copyright © 2018年 njafei. All rights reserved.
//

#import "LFPanVerticalGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation LFPanVerticalGestureRecognizer

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isMoving){
        UITouch *touch = [touches anyObject];
        CGPoint nowPoint = [touch locationInView:self.view];
        CGPoint prevPoint = [touch previousLocationInView:self.view];
        
        BOOL isHorzitional = prevPoint.x - nowPoint.x > 2;
        BOOL isVertical = nowPoint.y - prevPoint.y > 5;
        if (!isHorzitional && isVertical){
            self.isMoving = YES;
            self.isVerticalDownPan = YES;
        } else {
            self.isVerticalDownPan = NO;
            self.state = UIGestureRecognizerStateFailed;
        }
    }
    
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isMoving = NO;
    [super touchesEnded:touches withEvent:event];
}

@end
