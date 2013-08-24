//
//  PMSetFloorLevelView.h
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/22/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMButton;

@interface PMSetFloorLevelView : UIView

@property (nonatomic, strong) PMButton *nextButton;

- (float)floorLevel;

@end
