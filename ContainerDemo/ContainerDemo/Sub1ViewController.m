//
//  Sub1ViewController.m
//  ContainerDemo
//
//  Created by admin on 2017/10/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "Sub1ViewController.h"
#import "Masonry.h"

@interface Sub1ViewController ()

@end

@implementation Sub1ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"Sub1ViewController viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"Sub1ViewController viewDidAppear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = _bkColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(50));
    }];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(50));
    }];
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

//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    
//    if(@available(iOS 11.0, *)) {
//        self.view.safeAreaLayoutGuide = self.parentViewController.view.safeAreaLayoutGuide;
//    } else {
//        self.topGuideConstraint = self.parentViewController.topLayoutGuide;
//    }
//    
//}

@end
