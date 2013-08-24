//
//  PMTextField.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/23/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMTextField.h"

@implementation PMTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.font = [UIFont fontWithName:@"AvenirNext-Medium" size:18];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:18];
        label.frame = CGRectMake(0, 0, 0, 45);
        label.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        label.textAlignment = NSTextAlignmentRight;
        
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = label;
    }
    return self;
}

- (void)setUnits:(NSString *)units
{
    UILabel *label = (UILabel *)self.rightView;
    label.text = units;
    
    label.frame = CGRectMake(0, 0, [label.text sizeWithFont:label.font].width, 45);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
