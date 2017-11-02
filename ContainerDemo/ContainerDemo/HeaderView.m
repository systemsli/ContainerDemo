//
//  HeaderView.m
//  ContainerDemo
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HeaderView.h"
#import "Masonry.h"

@interface HeaderView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *headerCollectionView;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat font;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation HeaderView

- (instancetype)init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _cellWidth = 0;
        _font = 14;
        _normalColor = [UIColor blackColor];
        _selectedColor = [UIColor blueColor];
        _defauleIndex = 0;
        _selectedIndex = _defauleIndex;
        
        _headerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _headerCollectionView.backgroundColor = [UIColor whiteColor];
        _headerCollectionView.scrollEnabled = NO;
        [self addSubview:_headerCollectionView];
        _headerCollectionView.dataSource = self;
        _headerCollectionView.delegate = self;
        _headerCollectionView.showsHorizontalScrollIndicator = NO;
        [_headerCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"headerTitle"];

        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor purpleColor];
        [_headerCollectionView addSubview:_lineView];
        [_headerCollectionView bringSubviewToFront:_lineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_headerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_headerCollectionView bringSubviewToFront:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_headerCollectionView);
        make.width.equalTo(@75);
        make.height.equalTo(@10);
        make.left.equalTo(_headerCollectionView);
    }];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headerTitle" forIndexPath:indexPath];
    if(cell.contentView.subviews.count == 1) {
        UIButton *btn = (UIButton *)cell.contentView.subviews[0];
        [btn setTitle:_titleArray[indexPath.row] forState:UIControlStateNormal];
        btn.selected = indexPath.row == _selectedIndex ? YES : NO;
    } else {
        UIButton *btn = [self p_createBtnWithIndexPath:indexPath];
        [cell.contentView addSubview:btn];
        btn.frame = cell.contentView.bounds;
        btn.selected = indexPath.row == _selectedIndex ? YES : NO;
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if(cell.contentView.subviews.count == 1) {
        UIButton *btn = (UIButton *)cell.contentView.subviews[0];
        [btn setTitle:_titleArray[indexPath.row] forState:UIControlStateNormal];
        btn.selected = indexPath.row == _selectedIndex ? YES : NO;
    }
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select indexpath %ld", indexPath.row);
    _selectedIndex = indexPath.row;
    [self p_indexPath:indexPath select:YES];
    if([_delegate respondsToSelector:@selector(headerViewSelectedIndex:)]) {
        [_delegate headerViewSelectedIndex:indexPath.row];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Deselect indexpath %ld", indexPath.row);
    [self p_indexPath:indexPath select:NO];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_cellWidth, self.frame.size.height);
}

- (UIButton *)p_createBtnWithIndexPath:(NSIndexPath *)indexPath {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:_titleArray[indexPath.row] forState:UIControlStateNormal];
    [btn setTitleColor:_normalColor forState:UIControlStateNormal];
    [btn setTitleColor:_selectedColor forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:_font];
    btn.userInteractionEnabled = NO;
    return btn;
}

- (void)setTitleColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    _normalColor = normalColor;
    _selectedColor = selectedColor;
    [_headerCollectionView reloadData];
}
- (void)setTitleFont:(CGFloat)font {
    _font = font;
    [_headerCollectionView reloadData];
}

- (void)setTitleArray:(NSArray *)titleArray {
    if(_titleArray != titleArray) {
        _titleArray = titleArray;
        _cellWidth = _titleArray.count > 5 ? ([UIScreen mainScreen].bounds.size.width / 5.0) : ([UIScreen mainScreen].bounds.size.width / _titleArray.count);
        [_headerCollectionView reloadData];
        _headerCollectionView.scrollEnabled = _titleArray.count > 5 ? YES : NO;
        [self layoutIfNeeded];
        [self selectedIndex:_defauleIndex];
    }
}

- (void)selectedIndex:(NSInteger)index {
    if(index < _titleArray.count) {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:_selectedIndex inSection:0];
        [self p_indexPath:lastIndexPath select:NO];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [_headerCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [_headerCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        _selectedIndex = index;
        [self p_indexPath:indexPath select:YES];
    }
}

- (void)p_indexPath:(NSIndexPath *)indexPath select:(BOOL)select {
    UICollectionViewCell *cell = [_headerCollectionView cellForItemAtIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        if([subView isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subView;
            subBtn.selected = select;
        }
    }
}



- (void)setDefauleIndex:(NSInteger)defauleIndex {
    if(_defauleIndex != defauleIndex) {
        _defauleIndex = defauleIndex;
        if(_titleArray.count > _defauleIndex) {
            [self layoutIfNeeded];
            [self selectedIndex:_defauleIndex];

        }
    }
}


@end
