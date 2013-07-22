//
//  BackViewController.m
//  DoubleSidedPageViewController
//
//  Created by Mateus Abras on 7/22/13.
//  Copyright (c) 2013 Mateus Abras. All rights reserved.
//

#import "BackViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BackViewController ()

@property (nonatomic, assign) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *backgroundImage;

- (UIImage *)captureView:(UIView *)view;

@end

@implementation BackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [_imageView setImage:_backgroundImage];
    [_imageView setAlpha:0.5];
}

- (void)updateWithViewController:(UIViewController *)viewController {
    self.backgroundImage = [self captureView:viewController.view];
}

- (UIImage *)captureView:(UIView *)view {
    CGRect rect = view.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGAffineTransform transform = CGAffineTransformMake(-1.0, 0.0, 0.0, 1.0, rect.size.width, 0.0);
    CGContextConcatCTM(context,transform);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end