//
//  ViewController.m
//  Clock
//
//  Created by 刘盖 on 2017/7/13.
//  Copyright © 2017年 刘盖. All rights reserved.
//

#import "ViewController.h"
#import "LGClockView.h"
#import "NSDate+LGDateTools.h"

@interface ViewController ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) LGClockView *clockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.clockView = [LGClockView clockView];
    CGFloat tempH = ((667.-64.)/3.)/375.*SCREEN_WIDTH;
    self.clockView.frame = CGRectMake(0, 0, SCREEN_WIDTH, tempH);
    self.clockView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:self.clockView];
    [self beginTimer];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 时间
- (void)beginTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChanged:) userInfo:nil repeats:YES];
}

- (void)stopTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

NSInteger _animateTime = 0;
- (void)timeChanged:(NSTimer *)timer{
    self.clockView.arrayTimes = [NSDate arrayWithDate:[NSDate date]];
    
    
    
    //    self.labelTime.text = [NSDate stringFromDate:[NSDate date] withMode:@"yyyy年MM月dd日 HH:mm:ss"];
}



@end
