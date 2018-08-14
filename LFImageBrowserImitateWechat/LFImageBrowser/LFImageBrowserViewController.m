//
//  LFImageBrowserViewController.m
//  LFImageBrowserImitateWechat
//
//  Created by fei on 2018/8/11.
//  Copyright © 2018年 njafei. All rights reserved.
//

#import "LFImageBrowserViewController.h"
#import "LFImageBrowserView.h"

@interface LFImageBrowserViewController ()<LFImageBrowserViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) NSInteger startIndex;
@property (strong, nonatomic) NSArray *images;

@end

@implementation LFImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpScrollView];
    
    [self setUpImages];
}

- (void)setUpScrollView
{
    [self.view addSubview: self.scrollView];
    self.scrollView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20);
}

- (void)setUpImages
{
    CGFloat width = self.scrollView.bounds.size.width;
    CGFloat height = self.scrollView.bounds.size.height;
    
    for (NSInteger i = 0; i < 3; i ++) {
        
        LFImageBrowserView *imageView = [[LFImageBrowserView alloc]initWithFrame:CGRectMake(width * i , 0, width ,height                              )];
        imageView.delegate = self;
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(width * 3, height);
    
    [self.scrollView scrollRectToVisible:CGRectMake(self.startIndex * width , 0, width, height) animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public methods
+ (void)showInViewController:(UIViewController *)vc WithImages:(NSArray *)images startIndex:(NSInteger)index;
{
    LFImageBrowserViewController *controller = [LFImageBrowserViewController new];
    controller.images = images;
    controller.startIndex = index;
    [vc addChildViewController: controller];
    [vc.view addSubview:controller.view];
    [controller didMoveToParentViewController:vc];
}

- (void)dismissSelf
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark - LFImageView Deleagte

- (void)removeSelf
{
    [self dismissSelf];
}

#pragma mark - lazy init
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        _scrollView.showsHorizontalScrollIndicator = YES;
    }
    return _scrollView;
}

@end
