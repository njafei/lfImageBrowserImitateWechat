//
//  LFImageBrowserView.h
//  LFImageBrowserImitateWechat
//
//  Created by fei on 2018/8/11.
//  Copyright © 2018年 njafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFImageBrowserViewDelegate <NSObject>

- (void)removeSelf;

@end

@interface LFImageBrowserView : UIView

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<LFImageBrowserViewDelegate> delegate;

@end
