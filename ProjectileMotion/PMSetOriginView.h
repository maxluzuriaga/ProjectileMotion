//
//  PMSetOriginView.h
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/23/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMButton;

@interface PMSetOriginView : UIView

@property (nonatomic, strong) PMButton *nextButton;
@property (nonatomic) float floorLevel;

- (CGPoint)origin;

@end
