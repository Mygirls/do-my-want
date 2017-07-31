////
////  MajqCycleScrollView.h
////  CycleScrollViewTest
////
////  Created by cfzq on 2017/6/30.
////  Copyright © 2017年 cfzq. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
//
//typedef enum {
//    MajqPageContolStyleClassic,        // 系统自带经典样式
//    MajqPageContolStyleAnimated,       // 动画效果pagecontrol
//    MajqPageContolStyleNone            // 不显示pagecontrol
//} MajqCycleScrollViewPageContolStyle;
//
//typedef enum {
//    MajqPageContolAlimentLeft,
//    MajqPageContolAlimentRight,
//    MajqPageContolAlimentCenter
//} MajqPageContolAliment;
//
//
//@class MajqCycleScrollView;
//
//@protocol MajqCycleScrollViewDelegate <NSObject>
//
//@optional
//
///** 点击图片回调 */
//- (void)cycleScrollView:(MajqCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
//
///** 图片滚动回调 */
//- (void)cycleScrollView:(MajqCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;
//
//// 不需要自定义轮播cell的请忽略以下两个的代理方法
//// ========== 轮播自定义cell ==========
//
///** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
//- (Class)customCollectionViewCellClassForCycleScrollView:(MajqCycleScrollView *)view;
//
///** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
//- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(MajqCycleScrollView *)view;
//
//@end
//
//
//
//
//@interface MajqCycleScrollView : UIView
//
//@property (nonatomic, weak) id<MajqCycleScrollViewDelegate> delegate;
//
//#pragma mark - CollectionView属性设置
//
///** 占位图，用于网络未加载到图片时 */
//@property (nonatomic, strong) UIImage *placeholderImage;
//
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
//
//
//#pragma mark - 数据源
//
///** 网络图片 url string 数组 */
//@property (nonatomic, strong) NSArray *imageURLStringsGroup;
//
///** 本地图片数组 */
//@property (nonatomic, strong) NSArray *localizationImageNamesGroup;
//
//
//#pragma mark - PageControl 属性设置
//
///** 是否在只有一张图时隐藏pagecontrol，默认为YES */
//@property(nonatomic) BOOL hidesForSinglePage;
//
///** 当前分页控件小圆标颜色 */
//@property (nonatomic, strong) UIColor *currentPageDotColor;
//
///** 其他分页控件小圆标颜色 */
//@property (nonatomic, strong) UIColor *pageDotColor;
//
///** 分页控件位置 */
//@property (nonatomic, assign) MajqPageContolAliment pageControlAliment;
//
///** pagecontrol 样式，默认为动画样式 */
//@property (nonatomic, assign) MajqCycleScrollViewPageContolStyle pageControlStyle;
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
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup;
//
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop imageNamesGroup:(NSArray *)imageNamesGroup;
//
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLsGroup;
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<MajqCycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;
//
//@end
