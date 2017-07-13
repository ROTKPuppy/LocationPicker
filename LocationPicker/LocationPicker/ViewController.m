//
//  ViewController.m
//  LocationPicker
//
//  Created by 郑键 on 2017/7/11.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "ViewController.h"
#import "ZJLocationPickerViewController.h"
#import "PopPresentAnimation.h"
#import "PopDismissAnimation.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ZJLocationPickerViewController *locationPickerViewController = [ZJLocationPickerViewController locationPickerViewController:nil
                                                                                                                     closeImage:nil
                                                                                                      marginLineBackgroundColor:nil
                                                                                                              selectedTintColor:nil
                                                                                                                  selectedImage:nil
                                                                                                               selectedCallBack:^(NSString *address) {
                                                                                                                   
                                                                                                                   NSLog(@"%@", address);
                                                                                                                   
                                                                                                               }];
    locationPickerViewController.modalPresentationStyle = UIModalPresentationCustom;
    locationPickerViewController.transitioningDelegate = self;
    [self presentViewController:locationPickerViewController animated:YES completion:^{
        
    }];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [PopPresentAnimation new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [PopDismissAnimation new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
