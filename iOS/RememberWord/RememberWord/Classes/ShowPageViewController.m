//
//  ShowPageViewController.m
//  RememberWord
//
//  Created by zhangkai on 08/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "ShowPageViewController.h"
#import "PageView.h"
#import "PageViewController.h"

#define TagPagesView 100

@interface ShowPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
    UIPageViewController *_pageController;
    UIScrollView *_scrollView;
    int _pageCount;
    int _currentPage;
}

@end

@implementation ShowPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CGFloat offsetLeft = 20;
    
    UILabel *labelDays = [[UILabel alloc] init];
    labelDays.text = @"已练习 0 天";
    labelDays.textColor = UIColorFromRGB(0x333333);
    labelDays.font = font;
    [self.view addSubview:labelDays];
    [labelDays mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UILabel *labelRemain = [[UILabel alloc] init];
    labelRemain.text = @"今日剩余 10 次练习机会";
    labelRemain.textColor = UIColorFromRGB(0x333333);
    labelRemain.font = font;
    [self.view addSubview:labelRemain];
    [labelRemain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelDays.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UILabel *labelDuration = [[UILabel alloc] init];
    labelDuration.text = @"要在 400 秒内翻完 200 页";
    labelDuration.textColor = UIColorFromRGB(0x333333);
    labelDuration.font = font;
    [self.view addSubview:labelDuration];
    [labelDuration mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelRemain.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UILabel *labelIndex = [[UILabel alloc] init];
    labelIndex.text = @"只看每页第 1 个单词";
    labelIndex.textColor = UIColorFromRGB(0x333333);
    labelIndex.font = font;
    [self.view addSubview:labelIndex];
    [labelIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelDuration.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UILabel *labelSound = [[UILabel alloc] init];
    labelSound.text = @"发音：";
    labelSound.textColor = UIColorFromRGB(0x333333);
    labelSound.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:labelSound];
    [labelSound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelIndex.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UISwitch *switchSound = [[UISwitch alloc] init];
    switchSound.on = YES;
    [self.view addSubview:switchSound];
    [switchSound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelSound.mas_right);
        make.centerY.equalTo(labelSound.mas_centerY);
    }];
    
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                    options:nil];
    _pageController.delegate = self;
    _pageController.dataSource = self;
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    [_pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelSound.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    [_pageController didMoveToParentViewController:self];
    
    _pageCount = 200;
    PageViewController *page = [[PageViewController alloc] init];
    page.number = 1;
    page.count = _pageCount;
    page.words = [self loadWordsWithPage:page.number];
    page.selectIndex = 0;
    
    [_pageController setViewControllers:@[page]
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
}

#pragma mark - Private methods

- (NSArray *)loadWordsWithPage:(int)page {
    NSAssert(page >= 1, @"page is %d, should >= 1", page);
    int count = 5; // 5 words each page
    int offset = (page - 1) * count;
    NSMutableArray *words = [NSMutableArray array];
    // not consider cross plist files
    NSString *path = nil;
    if (offset < 100) {
        path = [[NSBundle mainBundle] pathForResource:@"Words01" ofType:@"plist"];
    } else if (offset < 200) {
        offset -= 100;
        path = [[NSBundle mainBundle] pathForResource:@"Words02" ofType:@"plist"];
    } else if (offset < 300) {
        offset -= 200;
        path = [[NSBundle mainBundle] pathForResource:@"Words03" ofType:@"plist"];
    } else if (offset < 400) {
        offset -= 300;
        path = [[NSBundle mainBundle] pathForResource:@"Words04" ofType:@"plist"];
    } else if (offset < 500) {
        offset -= 400;
        path = [[NSBundle mainBundle] pathForResource:@"Words05" ofType:@"plist"];
    } else if (offset < 600) {
        offset -= 500;
        path = [[NSBundle mainBundle] pathForResource:@"Words06" ofType:@"plist"];
    } else if (offset < 700) {
        offset -= 600;
        path = [[NSBundle mainBundle] pathForResource:@"Words07" ofType:@"plist"];
    } else if (offset < 800) {
        offset -= 700;
        path = [[NSBundle mainBundle] pathForResource:@"Words08" ofType:@"plist"];
    } else if (offset < 900) {
        offset -= 800;
        path = [[NSBundle mainBundle] pathForResource:@"Words09" ofType:@"plist"];
    } else if (offset < 1000) {
        offset -= 900;
        path = [[NSBundle mainBundle] pathForResource:@"Words10" ofType:@"plist"];
    }
    
    if (path) {
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        int limit = offset + count;
        for (int i = offset; i < limit; i++) {
            if (i < array.count) {
                NSDictionary *dict = [array objectAtIndex:i];
                WordInfo *wInfo = [[WordInfo alloc] init];
                wInfo.word = [dict objectForKey:@"word"];
                wInfo.phoneticSymbol = [dict objectForKey:@"phoneticSymbol"];
                NSString *oldString = [dict objectForKey:@"translation"];
                NSString *newString = [oldString stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
                wInfo.translation = newString;
                
                [words addObject:wInfo];
            }
        }
    }
    
    return words;
}

- (void)loadMorePages {
    int loadedCount = roundf(_scrollView.contentSize.width / (_scrollView.frame.size.width));
    if (loadedCount >= _pageCount) {
        return;
    }
    
    int count = 3; // default load count every time
    if (_pageCount - loadedCount < count) {
        count = _pageCount - loadedCount;
    }
    
    UIView *pagesView = [_scrollView viewWithTag:TagPagesView];
    PageView *lastView = nil;
    if (pagesView.subviews.count > 0) {
        lastView = pagesView.subviews.lastObject;
    }
    if (pagesView.subviews.count > 1) {
        UIView *preView = pagesView.subviews[pagesView.subviews.count - 2];
        [lastView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(pagesView);
            make.left.equalTo(preView.mas_right).offset(20);
            make.width.equalTo(_scrollView).offset(-20);
        }];
    }

    count += loadedCount;
    for (int i = loadedCount; i < count; i++) {
        NSArray *words = [self loadWordsWithPage:i];
        
        PageView *pView = [[PageView alloc] initWithWords:words selectIndex:0];
        pView.labelPage.text = [NSString stringWithFormat:@"Page %d of %d", i+1, _pageCount];
        [pagesView addSubview:pView];
        [pView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(pagesView);
            if (lastView) {
                make.left.equalTo(lastView.mas_right).offset(20);
            } else {
                make.left.equalTo(pagesView).offset(10);
            }
            make.width.equalTo(_scrollView).offset(-20);
        }];
        
        lastView = pView;
    }
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pagesView.mas_right).offset(-10);
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)resetShowCover:(UIScrollView *)scrollView {
    int count = roundf(scrollView.contentSize.width / (scrollView.frame.size.width));
    int pageNumber = roundf(scrollView.contentOffset.x / (scrollView.frame.size.width));
    if (count < _pageCount && pageNumber >= count - 2) {
        [self loadMorePages];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self resetShowCover:scrollView];
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    PageViewController *prePage = (PageViewController *)viewController;
    if (prePage.number > 1) {
        PageViewController *page = [[PageViewController alloc] init];
        page.number = prePage.number - 1;
        page.count = _pageCount;
        page.words = [self loadWordsWithPage:page.number];
        page.selectIndex = 0;
        
        return page;
    } else {
        return nil;
    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    PageViewController *prePage = (PageViewController *)viewController;
    if (prePage.number < _pageCount) {
        PageViewController *page = [[PageViewController alloc] init];
        page.number = prePage.number + 1;
        page.count = _pageCount;
        page.words = [self loadWordsWithPage:page.number];
        page.selectIndex = 0;
        
        return page;
    } else {
        return nil;
    }
}

#pragma mark - UIPageViewControllerDelegate

@end
