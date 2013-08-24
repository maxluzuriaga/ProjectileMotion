//
//  PMPathView.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/23/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMPathView.h"

@interface PMPathView ()

@property (nonatomic) float time;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSMutableArray *points;

@end

@implementation PMPathView

@synthesize floorlevel, scale, origin, angle, initialVelocity, time, timer, points;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        time = 0.0;
        points = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setOrigin:(CGPoint)o
{
    origin = o;
    [self setNeedsDisplay];
}

- (void)launch
{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

- (void)updateTime
{
    time += 0.02;
    
    float xVelocity = cosf(angle/360.0f * 2*M_PI) * initialVelocity * scale;
    float yVelocity = sinf(angle/360.0f * 2*M_PI) * initialVelocity * scale;
    
    float x = origin.x + time * xVelocity;
    float y = origin.y - time * yVelocity + (0.5) * (9.81 * scale) * powf(time, 2.0);
    
    if (y >= floorlevel) {
        [timer invalidate];
    }
    
    [points addObject:@[[NSNumber numberWithFloat:x], [NSNumber numberWithFloat:y]]];
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 5.0);
    CGContextSetRGBFillColor(ctx, 1.0, 0.3, 0.3, 0.8);
    
    if (origin.x != 0 && origin.y != 0) {
        if (time > 0.0) {
            CGContextSetRGBStrokeColor(ctx, 0.3, 1.0, 0.3, 0.8);
            
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, origin.x, origin.y);
            
            for (NSArray *point in points) {
                float x = [(NSNumber *)point[0] floatValue];
                float y = [(NSNumber *)point[1] floatValue];
                
                CGContextAddLineToPoint(ctx, x, y);
            }
            
            CGContextStrokePath(ctx);
        }
        
        float radius = 10.0;
        CGContextFillEllipseInRect(ctx, CGRectMake(origin.x-radius, origin.y-radius, radius*2, radius*2));
    }
    
    CGContextSetRGBFillColor(ctx, 0.3, 0.3, 1.0, 0.8);
    CGContextFillRect(ctx, CGRectMake(0, floorlevel, 480, 320-floorlevel));
    
    [super drawRect:rect];
}

@end
