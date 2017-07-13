//
//  LGClockView.h
//  MyTools
//
//  Created by 刘盖 on 2017/7/5.
//  Copyright © 2017年 刘盖. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH  SCREEN_BOUNDS.size.width
#define SCREEN_HEIGHT  SCREEN_BOUNDS.size.height
#define NAVBAR_HEIGHT 44
#define NAV_STATUS_HEIGHT 64
#define STATUSBAR_HEIGHT 20
#define TABBAR_HEIGHT 49

#define IPHONE_6_WIDTH 375.
#define IPHONE_6_HEIGHT 667.

#define LG_FONT(a) [UIFont systemFontOfSize:a]

#define LG_LEFT_GAP 10
#define LG_CENTRE_SUB_GAP 5

#define LG_GAP_RIGHT 16
#define LG_GAP_LEFT 16

@interface LGClockView : UIView
@property (nonatomic,strong) NSArray *arrayTimes;
+ (instancetype)clockView;

@end
