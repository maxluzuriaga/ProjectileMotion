//
//  PMGetOptionsView.h
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/23/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMButton;

@interface PMGetOptionsView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) PMButton *nextButton;

- (double)angle;
- (double)initialVelocity;

@end
