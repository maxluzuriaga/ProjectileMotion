//
//  PMButton.h
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/20/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMButton : UIButton {
    UIColor *_backgroundColor;
    float _normalOpacity;
    float _highlightedOpacity;
}

- (id)initWithColor:(UIColor *)color normalOpacity:(float)no highlightedOpacity:(float)ho;
- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated;

@end
