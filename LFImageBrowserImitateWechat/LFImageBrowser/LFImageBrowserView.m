//
//  LFImageBrowserView.m
//  LFImageBrowserImitateWechat
//
//  Created by fei on 2018/8/11.
//  Copyright © 2018年 njafei. All rights reserved.
//

#import "LFImageBrowserView.h"
#import "LFPanVerticalGestureRecognizer.h"
#import "UIView+Positioning.h"

@interface LFImageBrowserView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGSize beginSize;

@end

const CGFloat minScale = 0.5;

@implementation LFImageBrowserView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor  = [UIColor blackColor];
        
        [self setUpImageView];
    }
    return self;
}

- (void)setUpImageView
{
    [self addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"avatar"];
    [self.imageView sizeToFit];
    
    self.imageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height /2);
    
    LFPanVerticalGestureRecognizer *panGestureRecognizer = [[LFPanVerticalGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognize:)];
    panGestureRecognizer.delegate = self;
    [self.imageView addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecongnize:)];
    singleTapGesture.numberOfTapsRequired = 1;
    [self.imageView addGestureRecognizer:singleTapGesture];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleSingleGestureRecongnize:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:doubleTapGesture];
    
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
}

#pragma mark - single tap

- (void)singleTapGestureRecongnize:(UITapGestureRecognizer *)recognize
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(removeSelf)]) {
        [self.delegate removeSelf];
    }
}

#pragma mark - double tap

- (void)doubleSingleGestureRecongnize: (UITapGestureRecognizer *)recongnize
{
    NSLog(@"double tap");
}

#pragma mark - pan

-(void)panGestureRecognize:(UIPanGestureRecognizer *)recognize{
    switch (recognize.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.beginPoint = self.imageView.tnorigin;
            self.beginSize = self.imageView.size;
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translationPoint = [recognize translationInView:self.imageView];
            
            CGFloat scale = translationPoint.y > 0 ? 1 - translationPoint.y/1000 : 1;
            scale = scale >= minScale ? scale : minScale;
            self.imageView.width = self.beginSize.width *scale;
            self.imageView.height = self.beginSize.height * scale;
            
            self.imageView.x = translationPoint.x + self.beginPoint.x;
            self.imageView.y = translationPoint.y + self.beginPoint.y;
            
           self.backgroundColor =    [UIColor colorWithRed:0 green:0 blue:0 alpha:1 - translationPoint.y/500];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            CGPoint translationPoint = [recognize translationInView:self.imageView];
            if (translationPoint.y > 80) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(removeSelf)]) {
                    [self.delegate removeSelf];
                }
            }
            
            [self resetImageViewOrigin];
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        {
            [self resetImageViewOrigin];
        }
            break;
            
        case UIGestureRecognizerStateFailed:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)resetImageViewOrigin
{
    self.imageView.x = self.beginPoint.x;
    self.imageView.y = self.beginPoint.y;
    
    self.imageView.width = self.beginSize.width;
    self.imageView.height = self.beginSize.height;
}

#pragma mark - lazy init

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

@end
