//
//  ModelController.h
//  DoubleSidedPageViewController
//
//  Created by Mateus Abras on 7/22/13.
//  Copyright (c) 2013 Mateus Abras. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
