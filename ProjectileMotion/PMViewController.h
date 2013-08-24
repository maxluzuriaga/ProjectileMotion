//
//  PMViewController.h
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/20/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void)setupTakePicture;
- (void)takePictureButtonTapped;
- (void)endTakePicture;

- (void)setupSetScale;
- (void)endSetScale;

- (void)setupFloorLevel;
- (void)endFloorLevel;

- (void)setupSetOrigin;
- (void)endSetOrigin;

- (void)setupGetOptions;
- (void)endGetOptions;

- (void)setupLaunch;

@end
