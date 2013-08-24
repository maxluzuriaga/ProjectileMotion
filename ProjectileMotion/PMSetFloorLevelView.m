//
//  PMSetFloorLevelView.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/22/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMSetFloorLevelView.h"

#import "PMButton.h"
#import "PMDraggablePoint.h"

@interface PMSetFloorLevelView ()

@property (nonatomic, strong) PMDraggablePoint *control;

- (void)controlMoved:(id)sender withEvent:(UIEvent *)event;

@end

@implementation PMSetFloorLevelView

@synthesize nextButton, control;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        control = [[PMDraggablePoint alloc] initWithFrame:CGRectMake(217, 150, 45, 45)];
        [control setTarget:self action:@selector(controlMoved:withEvent:)];
        [self addSubview:control];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)controlMoved:(id)sender withEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    control.center = CGPointMake(control.center.x, point.y);
    
    [nextButton setEnabled:YES animated:YES];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 5.0);
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 0.6);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, [self floorLevel]);
    CGContextAddLineToPoint(ctx, 480, [self floorLevel]);
    
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];
}

- (float)floorLevel
{
    return control.center.y;
}

@end
