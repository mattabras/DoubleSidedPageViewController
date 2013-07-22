//
//  ModelController.m
//  DoubleSidedPageViewController
//
//  Created by Mateus Abras on 7/22/13.
//  Copyright (c) 2013 Mateus Abras. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"
#import "BackViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface ModelController()
@property (readonly, strong, nonatomic) NSArray *pageData;
@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation ModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        _pageData = [[dateFormatter monthSymbols] copy];
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = self.pageData[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{   
     // Return the index of the given data view controller.
     // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if([viewController isKindOfClass:[DataViewController class]]) {
        self.currentViewController = viewController;
        
        BackViewController *backViewController = [_currentViewController.storyboard instantiateViewControllerWithIdentifier:@"BackViewController"];
        [backViewController updateWithViewController:viewController];
        return backViewController;
    }
    
    
    NSUInteger index = [self indexOfViewController:(DataViewController *)_currentViewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:_currentViewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if([viewController isKindOfClass:[DataViewController class]]) {
        self.currentViewController = viewController;
        
        BackViewController *backViewController = [_currentViewController.storyboard instantiateViewControllerWithIdentifier:@"BackViewController"];
        [backViewController updateWithViewController:viewController];
        return backViewController;
    }
    
    NSUInteger index = [self indexOfViewController:(DataViewController *)_currentViewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:_currentViewController.storyboard];
}

@end
