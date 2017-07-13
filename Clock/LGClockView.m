//
//  LGClockView.m
//  MyTools
//
//  Created by 刘盖 on 2017/7/5.
//  Copyright © 2017年 刘盖. All rights reserved.
//

#import "LGClockView.h"

@interface LGClockView()




@end

@implementation LGClockView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)clockView{
    return [[self alloc] initWithFrame:CGRectZero];
}

- (void)setArrayTimes:(NSArray *)arrayTimes{
    _arrayTimes = arrayTimes;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.arrayTimes.count<4) {
        return;
    }
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //绘制大圆环
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGFloat maxD = MIN(rect.size.width, rect.size.height);
    
    //大圆直径
    CGFloat diameter = maxD - LG_LEFT_GAP*2;
    CGPoint centreTemp = CGPointMake(LG_LEFT_GAP*2+diameter/2, rect.size.height/2);
    CGContextAddArc(context, centreTemp.x, centreTemp.y, diameter/2, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    
    //绘制小圆环
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddArc(context, centreTemp.x, centreTemp.y, 4, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    
    
    //绘制当前时间
    NSInteger temp = 0;
    CGFloat orX = centreTemp.x+diameter/2+LG_GAP_LEFT*2;
    CGFloat orY = centreTemp.y-diameter/2;
    CGFloat orW = 0;
    CGFloat orH = 0;
    NSDictionary *attrDict = @{NSFontAttributeName:LG_FONT(15),NSForegroundColorAttributeName:[UIColor orangeColor]};
    for (NSString * str in self.arrayTimes) {
        CGSize sizeStr = [str sizeWithAttributes:attrDict];
        orW = sizeStr.width;
        orH = sizeStr.height;
        [str drawInRect:CGRectMake(orX, orY, orW, orH) withAttributes:attrDict];
        if (temp==0) {
            orX = orX;
            orY = orY+orH;
        }
        else{
            orX = orX+orW;
        }
        temp++;
    }
    
    
    //绘制刻度
    CGContextSetLineWidth(context, 1);
    attrDict = @{NSFontAttributeName:LG_FONT(10),NSForegroundColorAttributeName:[UIColor blueColor]};
    double angelBig = M_PI*2/12;
    double angelSmall = angelBig/5;
    double angelTemp = 0;
    CGFloat temS = sin(angelTemp);
    CGFloat temC = cos(angelTemp);
    
    CGFloat radius = (diameter-4)/2;
    CGFloat minX = centreTemp.x-radius;
    CGFloat minY = centreTemp.y-radius;
    
    CGFloat oX = minX+radius-temC*radius;
    CGFloat oY = minY+radius-temS*radius;
    
    CGFloat radiusTemp = 0;
    CGFloat minXTemp = 0;
    CGFloat minYTemp = 0;
    CGFloat dX = 0;
    CGFloat dY = 0;
    CGFloat wTemp = 6;
    
    
    CGFloat minXStr = 0;
    CGFloat minYStr = 0;
    CGFloat strCentreX = 0;
    CGFloat strCentreY = 0;
    CGSize sizeStr = [@"14" sizeWithAttributes:attrDict];
    CGFloat tempSizeW = MAX(sizeStr.width, sizeStr.height);
    sizeStr = CGSizeMake(tempSizeW, tempSizeW);
    CGFloat radiusStr = radius-6-3-sizeStr.width/2;
   
    
    temp = 9;
    
    for (NSInteger i = 0; i<60; i++) {
        BOOL isIntegra = i%5== 0;
        wTemp = isIntegra?6:3;
        radiusTemp = radius-wTemp;
        
        minXTemp = centreTemp.x-radiusTemp;
        minYTemp = centreTemp.y-radiusTemp;
        dX = minXTemp+radiusTemp-temC*radiusTemp;
        dY = minYTemp+radiusTemp-temS*radiusTemp;
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(context, oX, oY);
        CGContextAddLineToPoint(context, dX, dY);
        CGContextDrawPath(context, kCGPathStroke);
        
        
        if (isIntegra) {
            minXStr = centreTemp.x-radiusStr;
            minYStr = centreTemp.y-radiusStr;
            strCentreX = minXStr+radiusStr-temC*radiusStr;
            strCentreY = minYStr+radiusStr-temS*radiusStr;
            
            
            
            NSString *str = [NSString stringWithFormat:@"%ld",(long)temp];
            CGSize sizeTemp = [str sizeWithAttributes:attrDict];
            CGFloat marginTop = (sizeStr.height-sizeTemp.height)/2;
            CGFloat marginLeft = (sizeStr.width-sizeTemp.width)/2;
            [str drawInRect:CGRectMake(strCentreX-sizeStr.width/2+marginLeft, strCentreY-sizeStr.height/2+marginTop, sizeStr.width, sizeStr.height) withAttributes:attrDict];
            temp += 1;
            if (temp>12) {
                temp = 1;
            }
        }
        
        
        
        
        angelTemp += angelSmall;
        temS = sin(angelTemp);
        temC = cos(angelTemp);
        oX = minX+radius-temC*radius;
        oY = minY+radius-temS*radius;
        
        
    }

    CGFloat radiusPointerO = 0;
    CGFloat radiusPointerD = 0;

    
    NSInteger currentHour = [self.arrayTimes[1] integerValue];
    currentHour = currentHour<9?currentHour+12:currentHour;
    currentHour = currentHour-9;
    
    NSInteger currentMinute = [self.arrayTimes[2] integerValue];
    currentMinute = currentMinute>=45?(currentMinute-45):(currentMinute+15);
    NSInteger currentSecond = [self.arrayTimes[3] integerValue];
    currentSecond = currentSecond>=45?(currentSecond-45):(currentSecond+15);
    
    //    绘制秒针
    angelTemp = M_PI*2/60*currentSecond;
    temS = sin(angelTemp);
    temC = cos(angelTemp);
    radiusPointerO = (diameter-4)/2-6;
    radiusPointerD = 2.;
    [self drawPointer:context angel:angelTemp oR:radiusPointerO dR:radiusPointerD centre:centreTemp];
    
    //    绘制分针
    angelTemp = M_PI*2/60*currentMinute;
    temS = sin(angelTemp);
    temC = cos(angelTemp);
    radiusPointerO = radiusPointerO*2/3;
    radiusPointerD = 2.;
    [self drawPointer:context angel:angelTemp oR:radiusPointerO dR:radiusPointerD centre:centreTemp];
    
    //    绘制时针
    angelTemp = M_PI*2/12*currentHour;
    temS = sin(angelTemp);
    temC = cos(angelTemp);
    radiusPointerO = radiusPointerO*3/2/2;
    radiusPointerD = 2.;
    [self drawPointer:context angel:angelTemp oR:radiusPointerO dR:radiusPointerD centre:centreTemp];
    
    
    
}
- (void)drawPointer:(CGContextRef)context angel:(double)angel oR:(CGFloat)oR dR:(CGFloat)dR centre:(CGPoint)centre{
    double temS = sin(angel);
    double temC = cos(angel);
    CGFloat minPointerOX = centre.x-oR;
    CGFloat minPointerOY = centre.y-oR;
    CGFloat pointerOX = minPointerOX+oR-temC*oR;
    CGFloat pointerOY = minPointerOY+oR-temS*oR;
    
    
    CGFloat minPointerDX = centre.x-dR;
    CGFloat minPointerDY = centre.y-dR;
    CGFloat pointerDX = minPointerDX+dR-temC*dR;
    CGFloat pointerDY = minPointerDY+dR-temS*dR;
    
    
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, pointerOX, pointerOY);
    CGContextAddLineToPoint(context, pointerDX, pointerDY);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
