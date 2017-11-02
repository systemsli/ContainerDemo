//
//  ViewController.m
//  ContainerDemo
//
//  Created by admin on 2017/10/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "ContainerViewController.h"
#import "Sub1ViewController.h"
#import "Sub2ViewController.h"
#import "Sub3ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushContainer:(id)sender {
    ContainerViewController *containerVC = [[ContainerViewController alloc] init];
    Sub1ViewController *sub1VC = [[Sub1ViewController alloc] init];
    Sub2ViewController *sub2VC = [[Sub2ViewController alloc] init];
    Sub3ViewController *sub3VC = [[Sub3ViewController alloc] init];
    containerVC.subVCArray = @[sub1VC, sub2VC, sub3VC, sub1VC, sub2VC, sub3VC, sub1VC, sub2VC, sub3VC];
    [self.navigationController pushViewController:containerVC animated:YES];
}


@end
