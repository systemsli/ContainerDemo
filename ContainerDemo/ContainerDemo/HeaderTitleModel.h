//
//  HeaderTitleModel.h
//  ContainerDemo
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTitleModel : NSObject

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat titleFont;
@property (nonatomic, assign) CGFloat lineViewWidth;
@property (nonatomic, assign) CGFloat btnWidth;
@property (nonatomic, assign) NSInteger defaultIndex;
@property (nonatomic, copy) NSArray *titleArray;

- (instancetype)initWithNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor titleFont:(CGFloat)titleFont;


@end
