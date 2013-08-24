//
//  PMButton.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/20/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMButton.h"

@implementation PMButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    return self;
}

- (id)initWithColor:(UIColor *)color normalOpacity:(float)no highlightedOpacity:(float)ho
{
    if (self = [super init]) {
        _backgroundColor = color;
        _normalOpacity = no;
        _highlightedOpacity = ho;
        
        self.backgroundColor = [_backgroundColor colorWithAlphaComponent:_normalOpacity];
        
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:18];
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated
{
    [super setEnabled:enabled];
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^(void) {
            if (enabled) {
                self.alpha = 1.0;
            } else {
                self.alpha = 0.0;
            }
        }];
    } else {
        if (enabled) {
            self.alpha = 1.0;
        } else {
            self.alpha = 0.0;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.highlighted == YES)
        self.backgroundColor = [_backgroundColor colorWithAlphaComponent:_highlightedOpacity];
    else
        self.backgroundColor = [_backgroundColor colorWithAlphaComponent:_normalOpacity];
}

@end
