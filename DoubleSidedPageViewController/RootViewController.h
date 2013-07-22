//
//  RootViewController.h
//  DoubleSidedPageViewController
//
//  Created by Mateus Abras on 7/22/13.
//  Copyright (c) 2013 Mateus Abras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
