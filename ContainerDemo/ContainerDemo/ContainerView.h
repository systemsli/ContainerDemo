//
//  ContainerView.h
//  ContainerDemo
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContainerViewDelegate <NSObject>


/**
 返回containerview 和index

 @param containerView subVC view 的parent view
 @param index <#index description#>
 */
- (void)containerView:(UIView *)containerView index:(NSInteger)index ;



/**
 已经结束显示的索引

 @param index <#index description#>
 */
- (void)didEndDisplayingIndex:(NSInteger)index;




/**
 滑动停止后当前显示的indexPath

 @param index 索引位置
 */
- (void)displayingIndex:(NSInteger)index;

@end




@interface ContainerView : UIView

@property (nonatomic, strong) NSArray *subVCArray;
@property (nonatomic, weak) id<ContainerViewDelegate>delegate;
@property (nonatomic, assign) NSInteger defaultIndex;

- (void)selectedIndex:(NSInteger)index;

@end
