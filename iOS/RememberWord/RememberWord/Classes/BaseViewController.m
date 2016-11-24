//
//  BaseViewController.m
//  DailyReport
//
//  Created by zhangkai on 07/11/2016.
//  Copyright © 2016 Calle Zhang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        DLOGINFO(@"%@", NSStringFromClass([self class]));
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Private methods


#pragma mark - Public methods


#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    DLOGINFO(@"%@", NSStringFromClass([self class]));
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    DLOGINFO(@"%@", NSStringFromClass([self class]));
}

@end
