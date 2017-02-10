//
//  MainViewController.m
//  RememberWord
//
//  Created by zhangkai on 10/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "MainViewController.h"
#import "ShowPageViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_buttonStart addTarget:self action:@selector(buttonStartClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Private methods

- (void)buttonStartClicked {
    ShowPageViewController *vc = [[ShowPageViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
