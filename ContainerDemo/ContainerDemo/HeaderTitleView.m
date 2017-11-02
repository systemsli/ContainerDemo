//
//  HeaderTitleView.m
//  ContainerDemo
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HeaderTitleView.h"
#import "HeaderTitleModel.h"
#import "Masonry.h"

@interface HeaderTitleView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *btnArray;

@end
@implementation HeaderTitleView

- (instancetype)initWithModel:(HeaderTitleModel *)model {
    self = [super init];
    if(self) {
        _titleModel = model;
        [self p_createSubView];
    }
    return self;
}

- (instancetype)init {
    return [self initWithModel:[HeaderTitleModel new]];
}

- (void)p_createSubView {
    
    if(_titleModel.titleArray.count <= 0) {
        return;
    }
    
    [self p_createScrollView];
    [self p_createBtns];
}

- (void)p_createScrollView {
    /**
     为解决内容偏移问题，特意添加一个背景View
     */
    UIView *bkView = [[UIView alloc] init];
    [self addSubview:bkView];
    [bkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
}

- (void)p_createBtns {
    
    _btnArray = [NSMutableArray array];
    
    UIView *containerView = [[UIView alloc] init];
    [_scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.height.equalTo(_scrollView);
    }];
    
    UIButton *lastBtn = nil;
    for (NSString *title in _titleModel.titleArray) {
        UIButton *btn = [self p_createBtnWithTitle:title];
        [containerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if(lastBtn) {
                make.left.equalTo(lastBtn.mas_right);
            } else {
                make.left.equalTo(containerView);
            }
            make.top.bottom.equalTo(containerView);
            make.width.equalTo(@(_titleModel.btnWidth));
        }];
        [btn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        lastBtn = btn;
        [_btnArray addObject:btn];
    }
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastBtn);
    }];
    [containerView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor purpleColor];
    [containerView addSubview:_lineView];
    UIButton *defaultBtn = _btnArray[_titleModel.defaultIndex];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containerView);
        make.width.equalTo(@(_titleModel.lineViewWidth));
        make.height.equalTo(@(2));
        make.centerX.equalTo(defaultBtn);
    }];
    
    [self layoutIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_titleModel.defaultIndex < _btnArray.count) {
            [self p_selectedBtn:_btnArray[_titleModel.defaultIndex] callBack:NO];
        }
    });
}



- (UIButton *)p_createBtnWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:_titleModel.normalColor forState:UIControlStateNormal];
    [btn setTitleColor:_titleModel.selectedColor forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:_titleModel.titleFont];
    [btn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (void)setTitleModel:(HeaderTitleModel *)titleModel {
    if(_titleModel != titleModel) {
        _titleModel = titleModel;
        [self p_createSubView];
    }
}



- (void)clickTitleBtn:(UIButton *)btn {
    [self p_selectedBtn:btn callBack:YES];
}

- (void)p_selectedBtn:(UIButton *)btn callBack:(BOOL)callBack {
    for (UIButton *titleBtn in _btnArray) {
        titleBtn.selected = NO;
    }
    btn.selected = YES;
    if(callBack && [_delegate respondsToSelector:@selector(headerTitleViewSelectedIndex:)]) {
        NSInteger index = [_btnArray indexOfObject:btn];
        [_delegate headerTitleViewSelectedIndex:index];
    }
    
    [self p_scrollViewScrollWithBtn:btn];
}


- (void)p_scrollViewScrollWithBtn:(UIButton *)btn {
    
    CGRect lineFrame = _lineView.frame;
    lineFrame.origin.x = btn.frame.origin.x + (btn.frame.size.width - lineFrame.size.width) / 2.0;
    if(lineFrame.size.width > 0) {
        [UIView animateWithDuration:0.2 animations:^{
            _lineView.frame = lineFrame;
        }];
    }

    
    if(btn.frame.origin.x + btn.frame.size.width / 2.0 <= _scrollView.frame.size.width / 2.0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return;
    }

    CGPoint offset;
    if(btn.frame.origin.x + (btn.frame.size.width + _scrollView.frame.size.width) / 2.0 - 10 >= _scrollView.contentSize.width) { //不滑动scrollview的条件
        offset.x = _scrollView.contentSize.width - _scrollView.frame.size.width;
        offset.y = 0;
        [_scrollView setContentOffset:offset animated:YES];
        return;
    }

    offset.x = btn.frame.origin.x + btn.frame.size.width / 2.0 - _scrollView.frame.size.width/2.0;
    offset.y = 0;
    [_scrollView setContentOffset:offset animated:YES];
    

}


- (void)selectedIndex:(NSInteger)index {
    if(index < _titleModel.titleArray.count) {
        UIButton *btn = _btnArray[index];
        [self p_selectedBtn:btn callBack:NO];
    }
}



@end
