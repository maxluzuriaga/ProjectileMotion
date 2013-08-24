//
//  PMDraggablePoint.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/21/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMDraggablePoint.h"

@implementation PMDraggablePoint

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
        self.alpha = 0.95;
    }
    return self;
}

- (void)setTarget:(id)target action:(SEL)selector
{
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchDown];
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchDragInside];
}

@end
