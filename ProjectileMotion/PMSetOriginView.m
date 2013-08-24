//
//  PMSetOriginView.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/23/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMSetOriginView.h"

#import "PMButton.h"
#import "PMDraggablePoint.h"

@interface PMSetOriginView ()

@property (nonatomic, strong) PMDraggablePoint *point;

- (void)controlMoved:(id)sender withEvent:(UIEvent *)event;

@end

@implementation PMSetOriginView

@synthesize nextButton, point, floorLevel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        point = [[PMDraggablePoint alloc] initWithFrame:CGRectMake(200, 100, 45, 45)];
        [point setTarget:self action:@selector(controlMoved:withEvent:)];
        [self addSubview:point];
    }
    return self;
}

- (void)controlMoved:(id)sender withEvent:(UIEvent *)event
{
    [nextButton setEnabled:YES animated:YES];
    
    CGPoint location = [[[event allTouches] anyObject] locationInView:self];
    
    if (location.y >= floorLevel) {
        return;
    }
    
    UIControl *control = sender;
    control.center = location;
}

- (CGPoint)origin
{
    return point.center;
}

@end
