//
//  PMCameraOverlayView.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/20/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMCameraOverlayView.h"

#import "PMButton.h"

@implementation PMCameraOverlayView

@synthesize picker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *overlay = [[UIImageView alloc] initWithFrame:self.frame];
        overlay.image = [UIImage imageNamed:@"cameraOverlay"];
        
        [self addSubview:overlay];
        
        PMButton *button = [[PMButton alloc] initWithColor:[UIColor whiteColor] normalOpacity:0.2 highlightedOpacity:0.5];
        button.frame = CGRectMake(30, 350, 260, 100);
        [button addTarget:picker action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
    return self;
}


@end
