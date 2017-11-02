//
//  ContainerViewController.m
//  ContainerDemo
//
//  Created by admin on 2017/10/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ContainerViewController.h"
#import "Masonry.h"
#import "ContainerView.h"
#import "Sub1ViewController.h"
#import "Sub2ViewController.h"
#import "Sub3ViewController.h"
#import "HeaderView.h"
#import "HeaderTitleView.h"
#import "HeaderTitleModel.h"

@interface ContainerViewController ()<ContainerViewDelegate, HeaderViewDelegate, HeaderTitleViewDelegate>

@property (nonatomic, strong) HeaderTitleView *headerView;
@property (nonatomic, strong) ContainerView *containerView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    
    HeaderTitleModel *titleModel = [[HeaderTitleModel alloc] init];
//    titleModel.titleArray = [NSMutableArray arrayWithArray:@[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6", @"标题7", @"标题8", @"标题9"]];
    titleModel.titleArray = [NSMutableArray arrayWithArray:@[@"标题1", @"标题2", @"标题3", @"标题4"]];
    titleModel.defaultIndex = 5;
    _headerView = [[HeaderTitleView alloc] initWithModel:titleModel];
//    _headerView.backgroundColor = [UIColor grayColor];
    _headerView.delegate = self;
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(40));
    }];
    
    
    
    
    
    
//    _dataSource = [NSMutableArray arrayWithArray:@[@"", @"", @"", @"", @"", @"", @"", @"", @""]];
    _dataSource = [NSMutableArray arrayWithArray:@[@"", @"", @"", @""]];
    _containerView = [[ContainerView alloc] init];
    _containerView.delegate = self;
    [self.view addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom);
    }];
    _containerView.subVCArray = _dataSource;
    _containerView.defaultIndex = 0;

}


- (void)containerView:(UIView *)containerView index:(NSInteger)index {
    if(index % 3 == 0) {
        if(![_dataSource[index] isKindOfClass: [Sub1ViewController class]]) {
            Sub1ViewController *sub1VC = [[Sub1ViewController alloc] init];
            [_dataSource replaceObjectAtIndex:index withObject:sub1VC];
        }
    } else if (index % 3 == 1) {
        if(![_dataSource[index] isKindOfClass: [Sub2ViewController class]]) {
            Sub2ViewController *sub2VC = [[Sub2ViewController alloc] init];
            [_dataSource replaceObjectAtIndex:index withObject:sub2VC];
        }
    } else {
        if(![_dataSource[index] isKindOfClass: [Sub3ViewController class]]) {
            Sub3ViewController *sub3VC = [[Sub3ViewController alloc] init];
            [_dataSource replaceObjectAtIndex:index withObject:sub3VC];
        }
    }
    
    /**
     添加subVC
     */
    UIViewController *subVC = _dataSource[index];
    [self addChildViewController:subVC];
    subVC.view.frame = containerView.frame;
    [containerView addSubview:subVC.view];
}

- (void)didEndDisplayingIndex:(NSInteger)index {
    /**
     移除subVC
     */
    UIViewController *suvVC = _subVCArray[index];
    [suvVC.view removeFromSuperview];
    [suvVC removeFromParentViewController];
}


- (void)displayingIndex:(NSInteger)index {
    [_headerView selectedIndex:index];
}


- (void)headerViewSelectedIndex:(NSInteger)index {
    [_containerView selectedIndex:index];
}

- (void)headerTitleViewSelectedIndex:(NSInteger)index {
    NSLog(@"滑动到:%ld", index);
    [_containerView selectedIndex:index];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

}


@end
