//
//  UIPlaceHolderTextView.h
//  DDFindGoods
//
//  Created by zhangkai on 2/26/16.
//  Copyright © 2016 JSOSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
