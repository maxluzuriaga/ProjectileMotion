//
//  PMSetScaleView.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/21/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMSetScaleView.h"

#import "PMDraggablePoint.h"
#import "PMButton.h"
#import "PMTextField.h"

@interface PMSetScaleView() {
    BOOL _typing;
}

@property (nonatomic, strong) PMDraggablePoint *point1;
@property (nonatomic, strong) PMDraggablePoint *point2;

@property (nonatomic, strong) PMTextField *textField;

- (void)scalePointMoved:(id)sender withEvent:(UIEvent *)event;
- (void)positionTextField;
- (void)dismissKeyboard;

@end

@implementation PMSetScaleView

@synthesize nextButton, point1, point2, textField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        point1 = [[PMDraggablePoint alloc] initWithFrame:CGRectMake(200, 100, 45, 45)];
        [point1 setTarget:self action:@selector(scalePointMoved:withEvent:)];
        [self addSubview:point1];
        
        point2 = [[PMDraggablePoint alloc] initWithFrame:CGRectMake(300, 200, 45, 45)];
        [point2 setTarget:self action:@selector(scalePointMoved:withEvent:)];
        [self addSubview:point2];
        
        textField = [[PMTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        textField.delegate = self;
        [textField setUnits:@"cm"];
        
        [self positionTextField];
        [self addSubview:textField];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self addGestureRecognizer:tap];
        
        _typing = NO;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dismissKeyboard
{
    [textField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)tf
{
    if (textField.frame.origin.y > 59) {
        UIView *view = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
        
        [UIView animateWithDuration:0.25 animations:^(void) {
            view.frame = CGRectMake(59 - textField.frame.origin.y, 0, view.frame.size.width, view.frame.size.height);
        }];
    }
    
    _typing = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)aTextField
{
    UIView *view = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }];
    
    _typing = NO;
    
    BOOL enabled = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] != nil &&  ![[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqual:@""];
    [nextButton setEnabled:enabled animated:YES];
}

- (void)scalePointMoved:(id)sender withEvent:(UIEvent *)event
{
    if (_typing) {
        return;
    }
    
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    UIControl *control = sender;
    control.center = point;
    
    [self positionTextField];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 5.0);
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 0.6);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, point1.center.x, point1.center.y);
    CGContextAddLineToPoint(ctx, point2.center.x, point2.center.y);
    
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];
}

- (void)positionTextField
{
    CGPoint centerPoint = CGPointMake((point1.center.x + point2.center.x)/2, (point1.center.y + point2.center.y)/2);
    CGSize size = textField.frame.size;
    [textField setFrame:CGRectMake(centerPoint.x - (size.width/2), centerPoint.y - (size.height/2), size.width, size.height)];
}

- (double)computedScale
{
    double meters = [[textField text] doubleValue] / 100.0;
    double pixels = sqrt(pow((point1.center.x - point2.center.x), 2) + pow((point1.center.y - point2.center.y), 2));
    
    return pixels / meters;
}

@end
