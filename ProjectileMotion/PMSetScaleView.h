//
//  PMSetScaleView.h
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/21/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMButton;

@interface PMSetScaleView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) PMButton *nextButton;

- (double)computedScale;

@end
