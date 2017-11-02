//
//  HeaderTitleModel.m
//  ContainerDemo
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HeaderTitleModel.h"

@implementation HeaderTitleModel

- (instancetype)initWithNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor titleFont:(CGFloat)titleFont {
    self = [super init];
    if(self) {
        _normalColor = normalColor;
        _selectedColor = selectedColor;
        _titleFont = titleFont;
        _lineViewWidth = 0;
        _btnWidth = 0;
        _defaultIndex = 0;
    }
    return self;
}

- (instancetype)init {
    return [self initWithNormalColor:[UIColor blackColor] selectedColor:[UIColor blueColor] titleFont:14];
}

- (CGFloat)lineViewWidth {
    if(_lineViewWidth == 0 && _titleArray.count > 2) {
       
        _lineViewWidth = _titleArray.count > 5 ? ([UIScreen mainScreen].bounds.size.width / 5.0) : ([UIScreen mainScreen].bounds.size.width / _titleArray.count);
        _lineViewWidth -= 10;
    }
    
    return _lineViewWidth;
}

- (CGFloat)btnWidth {
    if(_titleArray.count > 0) {
        _btnWidth = _titleArray.count > 5 ? ([UIScreen mainScreen].bounds.size.width / 5.0) : ([UIScreen mainScreen].bounds.size.width / _titleArray.count);
    }
    return _btnWidth;
}

- (NSInteger)defaultIndex {
    if(_defaultIndex >= _titleArray.count) {
        return 0;
    }
    return _defaultIndex;
}


@end
