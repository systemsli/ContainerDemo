//
//  HeaderTitleView.h
//  ContainerDemo
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeaderTitleModel;

@protocol HeaderTitleViewDelegate <NSObject>

- (void)headerTitleViewSelectedIndex:(NSInteger)index;

@end

@interface HeaderTitleView : UIView

@property (nonatomic, strong) HeaderTitleModel *titleModel;
//@property (nonatomic, assign) NSInteger defauleIndex;
//@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, weak) id<HeaderTitleViewDelegate>delegate;

- (instancetype)initWithModel:(HeaderTitleModel *)model;

- (void)selectedIndex:(NSInteger)index;

@end
