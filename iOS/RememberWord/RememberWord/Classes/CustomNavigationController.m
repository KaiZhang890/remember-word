//
//  CustomNavigationController.m
//  DailyReport
//
//  Created by zhangkai on 07/11/2016.
//  Copyright © 2016 Calle Zhang. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

#pragma mark - UIViewControllerRotation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

@end
