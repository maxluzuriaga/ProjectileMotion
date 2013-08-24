//
//  PMPathView.h
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/23/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMPathView : UIView

@property (nonatomic) CGFloat floorlevel;
@property (nonatomic) double scale;
@property (nonatomic) CGPoint origin;
@property (nonatomic) double angle;
@property (nonatomic) double initialVelocity;

- (void)launch;

@end
