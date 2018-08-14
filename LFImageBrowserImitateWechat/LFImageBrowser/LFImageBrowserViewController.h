//
//  LFImageBrowserViewController.h
//  LFImageBrowserImitateWechat
//
//  Created by fei on 2018/8/11.
//  Copyright © 2018年 njafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFImageBrowserViewController : UIViewController

+ (void)showInViewController:(UIViewController *)vc WithImages:(NSArray *)images startIndex:(NSInteger)index;

@end
