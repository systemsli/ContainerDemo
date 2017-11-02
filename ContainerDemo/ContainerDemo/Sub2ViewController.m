//
//  Sub2ViewController.m
//  ContainerDemo
//
//  Created by admin on 2017/10/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "Sub2ViewController.h"
#import "Masonry.h"

@interface Sub2ViewController ()

@end

@implementation Sub2ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"Sub2ViewController");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
