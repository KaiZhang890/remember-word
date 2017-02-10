//
//  MainViewController.h
//  RememberWord
//
//  Created by zhangkai on 10/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *labelDays;
@property (weak, nonatomic) IBOutlet UILabel *labelProgress;
@property (weak, nonatomic) IBOutlet UILabel *labelTips;
@property (weak, nonatomic) IBOutlet UIButton *buttonStart;

@end
