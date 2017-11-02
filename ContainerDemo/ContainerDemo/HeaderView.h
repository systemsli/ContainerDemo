//
//  HeaderView.h
//  ContainerDemo
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

- (void)headerViewSelectedIndex:(NSInteger)index;

@end

@interface HeaderView : UIView

@property (nonatomic, assign) NSInteger defauleIndex;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, weak) id<HeaderViewDelegate>delegate;

- (void)setTitleColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;
- (void)setTitleFont:(CGFloat)font;
- (void)selectedIndex:(NSInteger)index;

@end
