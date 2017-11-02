//
//  ContainerView.m
//  ContainerDemo
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ContainerView.h"
#import "Masonry.h"

@interface ContainerView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *containerCollecionView;
@property (nonatomic, assign) NSInteger currentIndex;

@end


@implementation ContainerView


- (instancetype)init {
    self = [super init];
    if(self) {
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.backgroundColor = [UIColor whiteColor];

        _containerCollecionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[self p_flowLayout]];
        _containerCollecionView.backgroundColor = [UIColor whiteColor];
        _containerCollecionView.pagingEnabled = YES;
        _containerCollecionView.bounces = YES;
        _containerCollecionView.alwaysBounceHorizontal = YES;
        [self addSubview:_containerCollecionView];
        _containerCollecionView.dataSource = self;
        _containerCollecionView.delegate = self;
        [_containerCollecionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"subVC"];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [_containerCollecionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _containerCollecionView.collectionViewLayout = [self p_flowLayout]; //重新设置layout，强制collectionView重新布局（由于topLayoutGuide的影响，导致SubVC的View的frame超出collectionView的大小，需要在布局时强制刷新）
    [_containerCollecionView reloadData];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _subVCArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"subVC" forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    if(_delegate && [_delegate respondsToSelector:@selector(containerView:index:)]) {
        [_delegate containerView:cell.contentView index:indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if(_delegate && [_delegate respondsToSelector:@selector(didEndDisplayingIndex:)]) {
        [_delegate didEndDisplayingIndex:indexPath.row];
    }
}


- (void)setSubVCArray:(NSArray *)subVCArray {
    if(_subVCArray != subVCArray) {
        _subVCArray = subVCArray;
        [_containerCollecionView reloadData];
    }
}

- (void)setDefaultIndex:(NSInteger)defaultIndex {
    _defaultIndex = defaultIndex;
    [self p_srcollCollectionViewToDefaultIndex];
}

- (void)p_srcollCollectionViewToDefaultIndex {
    if(_containerCollecionView) {
        if(_defaultIndex >= 0 && _subVCArray.count > _defaultIndex) {
            [self layoutIfNeeded];
            [self p_scrollCollectionViewToIndex:_defaultIndex animated:YES];
        }
    }
}


- (void)selectedIndex:(NSInteger)index {
    if(_subVCArray.count > index) {
        [self p_scrollCollectionViewToIndex:index animated:NO];
    }
}

- (void)p_scrollCollectionViewToIndex:(NSInteger)index animated:(BOOL)animated{
    _currentIndex = index;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [_containerCollecionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self p_scrollViewScroll];
}

- (void)p_scrollViewScroll {
    CGPoint offset = _containerCollecionView.contentOffset;
    CGFloat indexF = offset.x / _containerCollecionView.frame.size.width;
    NSInteger index = round(indexF); //四舍五入
    if(index >= 0 && index < _subVCArray.count) {
        if(_currentIndex != index) {
            _currentIndex = index;
            if(_delegate && [_delegate respondsToSelector:@selector(displayingIndex:)]) {
                [_delegate displayingIndex:_currentIndex];
            }
        }
    }
}



- (UICollectionViewFlowLayout *)p_flowLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = self.bounds.size;
    return layout;
}


@end
