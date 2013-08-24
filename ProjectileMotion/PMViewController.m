//
//  PMViewController.m
//  ProjectileMotion
//
//  Created by Max Luzuriaga on 4/20/13.
//  Copyright (c) 2013 Max Luzuriaga. All rights reserved.
//

#import "PMViewController.h"

#import "PMCameraOverlayView.h"
#import "PMButton.h"
#import "PMSetScaleView.h"
#import "PMSetFloorLevelView.h"
#import "PMPathView.h"
#import "PMSetOriginView.h"
#import "PMGetOptionsView.h"

@interface PMViewController () {
    UIFont *_instructionFont;
}

@property (nonatomic, strong) PMPathView *pathView;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UILabel *instructionLabel;
@property (nonatomic, strong) PMButton *nextButton;

@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) PMButton *takePictureButton;

@property (nonatomic, strong) PMSetScaleView *scaleView;

@property (nonatomic, strong) PMSetFloorLevelView *floorLevelView;

@property (nonatomic, strong) PMSetOriginView *setOriginView;

@property (nonatomic, strong) PMGetOptionsView *getOptionsView;

- (void)setInstruction:(NSString *)info;
- (void)hideInstructions;

@end

@implementation PMViewController

@synthesize pathView, picker, backgroundImageView, takePictureButton, instructionLabel, nextButton, scaleView, floorLevelView, setOriginView, getOptionsView;

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        pathView = [[PMPathView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
        pathView.alpha = 0.0;
        
        picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls = NO;
        picker.cameraViewTransform = CGAffineTransformMakeScale(1.25, 1.25);
        picker.toolbarHidden = YES;
        picker.navigationBarHidden = YES;
        picker.wantsFullScreenLayout = YES;
        picker.delegate = self;
        
        PMCameraOverlayView *overlay = [[PMCameraOverlayView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        overlay.picker = picker;
        
        picker.cameraOverlayView = overlay;
        
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 480, 360)];
        
        takePictureButton = [[PMButton alloc] initWithColor:[UIColor orangeColor] normalOpacity:0.7 highlightedOpacity:0.9];
        takePictureButton.frame = CGRectMake(190, 140, 100, 40);
        [takePictureButton setTitle:@"Take Picture" forState:UIControlStateNormal];
        [takePictureButton addTarget:self action:@selector(takePictureButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        
        _instructionFont = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:18];
        
        instructionLabel = [[UILabel alloc] init];
        instructionLabel.font = _instructionFont;
        instructionLabel.textAlignment = NSTextAlignmentCenter;
        instructionLabel.textColor = [UIColor whiteColor];
        instructionLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        nextButton = [[PMButton alloc] initWithColor:[UIColor greenColor] normalOpacity:0.7 highlightedOpacity:0.9];
        nextButton.frame = CGRectMake(410, 135, 70, 50);
        [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
    [self.view addSubview:backgroundImageView];
    [self.view addSubview:nextButton];
    
    [self setupTakePicture];
}

#pragma mark - 1. Taking Picture

- (void)setupTakePicture {
    [self setInstruction:@"1. Take Picture"];
    
    [self.view addSubview:takePictureButton];
    
    [nextButton setEnabled:NO animated:NO];
    [nextButton addTarget:self action:@selector(endTakePicture) forControlEvents:UIControlEventTouchUpInside];
}

- (void)takePictureButtonTapped
{
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    backgroundImageView.alpha = 0.0;
    backgroundImageView.frame = CGRectMake(0, 360, 480, 360);
    
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    backgroundImageView.image = image;
    
    [nextButton setEnabled:YES animated:YES];
    
    [UIView animateWithDuration:1.0 animations:^(void) {
        backgroundImageView.alpha = 1.0;
        backgroundImageView.frame = CGRectMake(0, -20, 480, 360);
    }];
}

- (void)endTakePicture
{
    [nextButton removeTarget:self action:@selector(endTakePicture) forControlEvents:UIControlEventTouchUpInside];
    [takePictureButton removeFromSuperview];
    
    [self setupSetScale];
}

#pragma mark - 2. Setting scale

- (void)setupSetScale
{
    [self setInstruction:@"2. Set Scale"];
    
    [nextButton setEnabled:NO animated:YES];
    [nextButton addTarget:self action:@selector(endSetScale) forControlEvents:UIControlEventTouchUpInside];
    
    scaleView = [[PMSetScaleView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    scaleView.nextButton = nextButton;
    scaleView.alpha = 0.0;
    [self.view insertSubview:scaleView belowSubview:nextButton];
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        scaleView.alpha = 1.0;
    }];
}

- (void)endSetScale
{
    [nextButton removeTarget:self action:@selector(endTakePicture) forControlEvents:UIControlEventTouchUpInside];
    
    pathView.scale = [scaleView computedScale];
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        scaleView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [scaleView removeFromSuperview];
    }];
    
    [self setupFloorLevel];
}

#pragma mark - 3. Setting Ground

- (void)setupFloorLevel
{
    [self setInstruction:@"3. Set Floor Level"];
    
    [nextButton setEnabled:NO animated:YES];
    [nextButton addTarget:self action:@selector(endFloorLevel) forControlEvents:UIControlEventTouchUpInside];
    
    floorLevelView = [[PMSetFloorLevelView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    floorLevelView.nextButton = nextButton;
    floorLevelView.alpha = 0.0;
    [self.view insertSubview:floorLevelView belowSubview:nextButton];
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        floorLevelView.alpha = 1.0;
    }];
}

- (void)endFloorLevel
{
    [nextButton removeTarget:self action:@selector(endFloorLevel) forControlEvents:UIControlEventTouchUpInside];
    
    pathView.floorlevel = [floorLevelView floorLevel];
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        floorLevelView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [floorLevelView removeFromSuperview];
    }];
    
    [self setupSetOrigin];
}

#pragma mark - 4. Placing Origin

- (void)setupSetOrigin
{
    [self setInstruction:@"4. Set Origin"];
    
    [self.view insertSubview:pathView aboveSubview:backgroundImageView];
    
    [nextButton setEnabled:NO animated:YES];
    [nextButton addTarget:self action:@selector(endSetOrigin) forControlEvents:UIControlEventTouchUpInside];
    
    setOriginView = [[PMSetOriginView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    setOriginView.nextButton = nextButton;
    setOriginView.floorLevel = [floorLevelView floorLevel];
    setOriginView.alpha = 0.0;
    [self.view insertSubview:setOriginView belowSubview:nextButton];

    // MUST BE ABOVE THE GROUND
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        pathView.alpha = 1.0;
        setOriginView.alpha = 1.0;
    }];
}

- (void)endSetOrigin
{
    [nextButton removeTarget:self action:@selector(endSetOrigin) forControlEvents:UIControlEventTouchUpInside];
    
    pathView.origin = [setOriginView origin];
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        setOriginView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [setOriginView removeFromSuperview];
    }];
    
    [self setupGetOptions];
}

#pragma mark - 5. Setting options

- (void)setupGetOptions
{
    [self setInstruction:@"5. Set Options"];
    
    [nextButton setEnabled:NO animated:YES];
    [nextButton addTarget:self action:@selector(endGetOptions) forControlEvents:UIControlEventTouchUpInside];
    
    getOptionsView = [[PMGetOptionsView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    getOptionsView.nextButton = nextButton;
    getOptionsView.alpha = 0.0;
    [self.view insertSubview:getOptionsView belowSubview:nextButton];
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        getOptionsView.alpha = 1.0;
    }];
}

- (void)endGetOptions
{
    pathView.angle = [getOptionsView angle];
    pathView.initialVelocity = [getOptionsView initialVelocity];
    
    [nextButton removeTarget:self action:@selector(endGetOptions) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        getOptionsView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [getOptionsView removeFromSuperview];
    }];
    
    [self setupLaunch];
}

#pragma mark - 6. Launching!

- (void)setupLaunch
{
    [self hideInstructions];
    
    [nextButton setTitle:@"Launch!" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(launch) forControlEvents:UIControlEventTouchUpInside];
}

- (void)launch
{
    [UIView animateWithDuration:0.5 animations:^(void) {
        nextButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        [nextButton removeFromSuperview];
    }];
    
    [pathView launch];
}

#pragma mark -

- (void)setInstruction:(NSString *)info {
    CGSize size = [info sizeWithFont:_instructionFont];
    
    float width = size.width + 20;
    float height = size.height + 20;
    
    float speed = 0.5;
    
    if ([instructionLabel superview] != nil) {
        [UIView animateWithDuration:speed animations:^(void) {
            [instructionLabel setFrame:CGRectMake(instructionLabel.frame.origin.x, -instructionLabel.frame.size.height, instructionLabel.frame.size.width, instructionLabel.frame.size.height)];
        } completion:^(BOOL finished) {
            instructionLabel.text = info;
            [instructionLabel setFrame:CGRectMake((480-width)/2, -height, width, height)];
            [UIView animateWithDuration:speed animations:^(void) {
                [instructionLabel setFrame:CGRectMake((480-width)/2, 0, width, height)];
            }];
        }];
    } else {
        instructionLabel.text = info;
        [instructionLabel setFrame:CGRectMake((480-width)/2, -height, width, height)];
        
        [self.view addSubview:instructionLabel];
        
        [UIView animateWithDuration:speed animations:^(void) {
            [instructionLabel setFrame:CGRectMake((480-width)/2, 0, width, height)];
        }];
    }
}

- (void)hideInstructions
{
    [UIView animateWithDuration:0.5 animations:^(void) {
        instructionLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [instructionLabel removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight);
}

@end
