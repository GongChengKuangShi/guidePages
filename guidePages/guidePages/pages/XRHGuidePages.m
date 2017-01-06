//
//  XRHGuidePages.m
//  guidePages
//
//  Created by Apple on 2017/1/6.
//  Copyright © 2017年 mgjr. All rights reserved.
//

#import "XRHGuidePages.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface XRHGuidePages ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIButton      *actionButton;

@end

@implementation XRHGuidePages

- (instancetype)init {
    return [self initWithImageDatas:nil completion:nil];
}

- (instancetype)initWithImageDatas:(NSArray *)imageDatas completion:(void (^)(void))buttonAction {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [self scrollView];
        [self pageControl];
        [self setImageDatas:imageDatas];
        _buttonAction = buttonAction;
        
    }
    return self;
}

#pragma mark - setImageDatas
- (void)setImageDatas:(NSArray *)imageDatas {
    _imageDatas = imageDatas;
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initContentView];
}

#pragma mark - ViewUI
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 30, SCREEN_WIDTH, 10)];
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (void)initContentView {
    if (_imageDatas.count) {
        
        _pageControl.numberOfPages = _imageDatas.count;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _imageDatas.count, SCREEN_HEIGHT);
        for (int i = 0; i < _imageDatas.count; i++) {
            
            NSString *imageName = [_imageDatas objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            imageView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [self.scrollView addSubview:imageView];
            [self setButtonWithIndex:i imageView:imageView];
        }
    }
}

- (void)setButtonWithIndex:(int)index  imageView:(UIImageView *)imageView {
    if (index == _imageDatas.count - 1) {
        _actionButton.frame = CGRectMake(SCREEN_WIDTH / 2 - 70, SCREEN_HEIGHT - 70, 140, 35);
        _actionButton.layer.cornerRadius = 5;
        _actionButton.layer.masksToBounds = YES;
        [_actionButton setTitle:@"进  入" forState:UIControlStateNormal];
        _actionButton.tintColor = [UIColor whiteColor];
        _actionButton.backgroundColor = [UIColor cyanColor];
        [_actionButton addTarget:self action:@selector(enterButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:_actionButton];
        imageView.userInteractionEnabled = YES;//交互
    }
}

#pragma mark - action 
- (void)enterButtonClick {
    if (_buttonAction) {
        _buttonAction();
    }
}

#pragma mark UIScrollView delegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = (_scrollView.contentOffset.x + SCREEN_WIDTH / 2) / SCREEN_WIDTH;
}

@end
