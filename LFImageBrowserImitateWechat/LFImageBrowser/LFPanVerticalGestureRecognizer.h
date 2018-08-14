//
//  LFPanVerticalGestureRecognizer.h
//  LFImageBrowserImitateWechat
//
//  Created by fei on 2018/8/11.
//  Copyright © 2018年 njafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFPanVerticalGestureRecognizer : UIPanGestureRecognizer


@property (nonatomic, assign) BOOL isVerticalDownPan;

@property (nonatomic, assign) BOOL isMoving;

@end
