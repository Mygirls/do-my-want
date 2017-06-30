////
////  MajqCycleAnyScrollView.h
////  CycleScrollViewTest
////
////  Created by cfzq on 2017/6/30.
////  Copyright © 2017年 cfzq. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
//
//
//@class MajqCycleAnyScrollView;
//
//@protocol MajqCycleAnyScrollViewDelegate <NSObject>
//
//
///** 自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
//- (Class)customCollectionViewCellClassForCycleScrollView:(MajqCycleAnyScrollView *)view;
//
///** 自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
//- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(MajqCycleAnyScrollView *)view;
//
//
//@optional
//
///** 点击图片回调 */
//- (void)cycleScrollView:(MajqCycleAnyScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
//
///** 图片滚动回调 */
//- (void)cycleScrollView:(MajqCycleAnyScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;
//
//
//@end
//
//
//@interface MajqCycleAnyScrollView : UIView
//
//@property (nonatomic, weak) id<MajqCycleAnyScrollViewDelegate> delegate;
//
//#pragma mark - CollectionView属性设置
///** 是否自动滚动,默认Yes */
//@property (nonatomic,assign) BOOL autoScroll;
//
///** 是否无限循环,默认Yes */
//@property (nonatomic,assign) BOOL infiniteLoop;
//
///** 自动滚动间隔时间,默认2s */
//@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
//
///** 图片滚动方向，默认为水平滚动 */
//@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
//
//
//#pragma mark - 数据源个数
//@property(nonatomic,assign)NSInteger dataListCount;
//
//
//
//#pragma mark - 监听 点击 和滚动
///** block方式监听点击 */
//@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);
//
///** block方式监听滚动 */
//@property (nonatomic, copy) void (^itemDidScrollOperationBlock)(NSInteger currentIndex);
//
//
//
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame DataCount:(NSInteger)dataCount;
//
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop DataCount:(NSInteger)dataCount;
//
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<MajqCycleAnyScrollViewDelegate>)delegate DataCount:(NSInteger)dataCount;
//
//
//@end
