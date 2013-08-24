//
//  PMGetOptionsView.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/23/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMGetOptionsView.h"

#import "PMTextField.h"
#import "PMButton.h"

@interface PMGetOptionsView ()

@property (nonatomic, strong) PMTextField *angleField;
@property (nonatomic, strong) PMTextField *velocityField;

- (void)dismissKeyboard;

@end

@implementation PMGetOptionsView

@synthesize nextButton, angleField, velocityField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        angleField = [[PMTextField alloc] initWithFrame:CGRectMake(130, 80, 100, 40)];
        angleField.delegate = self;
        [angleField setUnits:@"°"];
        [self addSubview:angleField];
        
        velocityField = [[PMTextField alloc] initWithFrame:CGRectMake(250, 80, 100, 40)];
        velocityField.delegate = self;
        [velocityField setUnits:@"cm/s"];
        [self addSubview:velocityField];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)dismissKeyboard
{
    [angleField resignFirstResponder];
    [velocityField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self angle] > 0.0 && [self initialVelocity] > 0.0) {
        [nextButton setEnabled:YES animated:YES];
    }
}

- (double)angle
{
    return [[angleField text] doubleValue];
}

- (double)initialVelocity
{
    return [[velocityField text] doubleValue] / 100.0;
}

@end
