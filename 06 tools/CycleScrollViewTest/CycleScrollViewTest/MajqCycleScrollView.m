////
////  MajqCycleScrollView.m
////  CycleScrollViewTest
////
////  Created by cfzq on 2017/6/30.
////  Copyright © 2017年 cfzq. All rights reserved.
////
//
//#import "MajqCycleScrollView.h"
//#import "MajqCycleScrollViewCell.h"
//#import "UIImageView+WebCache.h"
//#import "UIView+SDExtension.h"
//#define kCycleScrollViewInitialPageControlDotSize CGSizeMake(10, 10)
//NSString * const ID = @"SDCycleScrollViewCell";
//
//@interface MajqCycleScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>
//
//@property (nonatomic, strong) UICollectionView *mainView; // 显示图片的collectionView
//@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
//@property (nonatomic, strong) NSArray *imagePathsGroup;
//@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, assign) NSInteger totalItemsCount;
//
//@property (nonatomic, strong) UIControl *pageControl;
//
//@property (nonatomic, strong) UIImageView *backgroundImageView; // 当imageURLs为空时的背景图
//@end
//
//@implementation MajqCycleScrollView
//
//#pragma mark - 初始化方法
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setUpInitConfig];
//        [self setUpScrollView];
//    }
//    return self;
//}
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    [self setUpInitConfig];
//    [self setUpScrollView];
//}
//
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        [self setUpInitConfig];
//        [self setUpScrollView];
//    }
//    return self;
//}
//
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup
//{
//    MajqCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
//    cycleScrollView.localizationImageNamesGroup = [NSMutableArray arrayWithArray:imageNamesGroup];
//    return cycleScrollView;
//}
//
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop imageNamesGroup:(NSArray *)imageNamesGroup
//{
//    MajqCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
//    cycleScrollView.infiniteLoop = infiniteLoop;
//    cycleScrollView.localizationImageNamesGroup = [NSMutableArray arrayWithArray:imageNamesGroup];
//    return cycleScrollView;
//}
//
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLsGroup
//{
//    MajqCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
//    cycleScrollView.imageURLStringsGroup = [NSMutableArray arrayWithArray:imageURLsGroup];
//    return cycleScrollView;
//}
//
//+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<MajqCycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage
//{
//    MajqCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
//    cycleScrollView.delegate = delegate;
//    cycleScrollView.placeholderImage = placeholderImage;
//    
//    return cycleScrollView;
//}
//
//#pragma mark - 配置信息
//- (void)setUpInitConfig {
//    
//    self.backgroundColor = [UIColor lightGrayColor];
//
//    _autoScrollTimeInterval = 2.0;
//    _autoScroll = YES;
//    _infiniteLoop = YES;
//    
//    _hidesForSinglePage = YES;
//    _currentPageDotColor = [UIColor whiteColor];
//    _pageDotColor = [UIColor lightGrayColor];
//}
//
//- (void)setUpScrollView {
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.minimumLineSpacing = 0;
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    _flowLayout = flowLayout;
//    
//    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
//    mainView.backgroundColor = [UIColor clearColor];
//    mainView.pagingEnabled = YES;
//    mainView.showsHorizontalScrollIndicator = NO;
//    mainView.showsVerticalScrollIndicator = NO;
//    [mainView registerClass:[MajqCycleScrollViewCell class] forCellWithReuseIdentifier:ID];
//    
//    mainView.dataSource = self;
//    mainView.delegate = self;
//    mainView.scrollsToTop = NO;
//    [self addSubview:mainView];
//    _mainView = mainView;
//}
//
//- (void)setUpPageControl {
//
//    if (_pageControl) [_pageControl removeFromSuperview]; // 重新加载数据时调整
//    
//    if ((self.imagePathsGroup.count == 1) && self.hidesForSinglePage) return;
//    
//    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:[self currentIndex]];
//    UIPageControl *pageControl = [[UIPageControl alloc] init];
//    pageControl.numberOfPages = self.imagePathsGroup.count;
//    pageControl.currentPageIndicatorTintColor = self.currentPageDotColor;
//    pageControl.pageIndicatorTintColor = self.pageDotColor;
//    pageControl.userInteractionEnabled = NO;
//    pageControl.currentPage = indexOnPageControl;
//    pageControl.backgroundColor = [UIColor orangeColor];
//    [self addSubview:pageControl];
//    _pageControl = pageControl;
//}
//
//#pragma mark - UICollectionView DataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return _totalItemsCount;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    MajqCycleScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    
//    long itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
//    
//    //如果有自定义的cell,那么 就用自定义的cell，而不会用默认的cell
//    if ([self.delegate respondsToSelector:@selector(setupCustomCell:forIndex:cycleScrollView:)] &&
//        [self.delegate respondsToSelector:@selector(customCollectionViewCellClassForCycleScrollView:)] &&
//        [self.delegate customCollectionViewCellClassForCycleScrollView:self]) {
//        [self.delegate setupCustomCell:cell forIndex:itemIndex cycleScrollView:self];
//        return cell;
//    }
//
//    NSString *imagePath = self.imagePathsGroup[itemIndex];
//    
//    if ([imagePath isKindOfClass:[NSString class]]) {
//        if ([imagePath hasPrefix:@"http"]) {
//            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
//        } else {
//            UIImage *image = [UIImage imageNamed:imagePath];
//            if (!image) {
//                [UIImage imageWithContentsOfFile:imagePath];
//            }
//            cell.imageView.image = image;
//        }
//    } else if ( [imagePath isKindOfClass:[UIImage class]]) {
//        cell.imageView.image = (UIImage *)imagePath;
//    }
//    
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
//        [self.delegate cycleScrollView:self didSelectItemAtIndex:[self pageControlIndexWithCurrentCellIndex:indexPath.item]];
//    }
//    if (self.clickItemOperationBlock) {
//        self.clickItemOperationBlock([self pageControlIndexWithCurrentCellIndex:indexPath.item]);
//    }
//}
//
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
//    int itemIndex = [self currentIndex];
//    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
//    
//    
//    UIPageControl *pageControl = (UIPageControl *)_pageControl;
//    pageControl.currentPage = indexOnPageControl;
//   
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    if (self.autoScroll) {
//        [self invalidateTimer];
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (self.autoScroll) {
//        [self setupTimer];
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self scrollViewDidEndScrollingAnimation:self.mainView];
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
//    int itemIndex = [self currentIndex];
//    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
//    
//    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didScrollToIndex:)]) {
//        [self.delegate cycleScrollView:self didScrollToIndex:indexOnPageControl];
//    } else if (self.itemDidScrollOperationBlock) {
//        self.itemDidScrollOperationBlock(indexOnPageControl);
//    }
//}
//
//#pragma mark - 定时器
//
//- (void)setupTimer
//{
//    [self invalidateTimer]; // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
//    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
//    _timer = timer;
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//}
//
//- (void)invalidateTimer
//{
//    NSLog(@"销毁定时器 ");
//    [_timer invalidate];
//    _timer = nil;
//}
//
//- (void)automaticScroll
//{
//    if (0 == _totalItemsCount) return;
//    int currentIndex = [self currentIndex];
//    int targetIndex = currentIndex + 1;
//    [self scrollToIndex:targetIndex];
//}
//
//- (void)scrollToIndex:(int)targetIndex
//{
//    if (targetIndex >= _totalItemsCount) {
//        if (self.infiniteLoop) {
//            targetIndex = _totalItemsCount * 0.5;
//            [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
//        }
//        return;
//    }
//    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//}
//
//#pragma mark - layoutSubviews
//
//- (void)layoutSubviews
//{
//    self.delegate = self.delegate;
//    
//    [super layoutSubviews];
//    
//    _flowLayout.itemSize = self.frame.size;
//    
//    _mainView.frame = self.bounds;
//    
//    //默认滑动偏移到collectionView的中间cell位置
//    if (_mainView.contentOffset.x == 0 &&  _totalItemsCount) {
//        int targetIndex = 0;
//        if (self.infiniteLoop) {
//            targetIndex = _totalItemsCount * 0.5;
//        }else{
//            targetIndex = 0;
//        }
//        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
//    }
//    
//    
//    CGSize size = CGSizeZero;
//    size = CGSizeMake(200, 10);
//    CGFloat x = (self.sd_width - size.width) * 0.5;
//    if (self.pageControlAliment == MajqPageContolAlimentRight) {
//        x = self.mainView.sd_width - size.width - 10;
//    }
//    CGFloat y = self.mainView.sd_height - size.height - 10;
//    
//    CGRect pageControlFrame = CGRectMake(x, y, size.width, size.height);
//    self.pageControl.frame = pageControlFrame;
//    self.pageControl.backgroundColor = [UIColor clearColor];
//    
//    if (self.backgroundImageView) {
//        self.backgroundImageView.frame = self.bounds;
//    }
//    
//}
//
////解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
//- (void)willMoveToSuperview:(UIView *)newSuperview
//{
//    if (!newSuperview) {
//        [self invalidateTimer];
//    }
//}
//
////解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
//- (void)dealloc {
//    _mainView.delegate = nil;
//    _mainView.dataSource = nil;
//}
//
//
//
//#pragma mark - 工具方法
//- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
//{
//    return (int)index % self.imagePathsGroup.count;
//}
//
//- (int)currentIndex
//{
//    if (_mainView.sd_width == 0 || _mainView.sd_height == 0) {
//        return 0;
//    }
//    
//    int index = 0;
//    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//        index = (_mainView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
//    } else {
//        index = (_mainView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
//    }
//    
//    return MAX(0, index);
//}
//
//#pragma mark - CollectionView属性设置
//- (void)setDelegate:(id<MajqCycleScrollViewDelegate>)delegate
//{
//    _delegate = delegate;
//    
//    if ([self.delegate respondsToSelector:@selector(customCollectionViewCellClassForCycleScrollView:)] && [self.delegate customCollectionViewCellClassForCycleScrollView:self]) {
//        [self.mainView registerClass:[self.delegate customCollectionViewCellClassForCycleScrollView:self] forCellWithReuseIdentifier:ID];
//    }
//}
//
//
//- (void)setPlaceholderImage:(UIImage *)placeholderImage
//{
//    _placeholderImage = placeholderImage;
//    
//    if (!self.backgroundImageView) {
//        UIImageView *bgImageView = [UIImageView new];
//        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
//        [self insertSubview:bgImageView belowSubview:self.mainView];
//        self.backgroundImageView = bgImageView;
//    }
//    
//    self.backgroundImageView.image = placeholderImage;
//}
//
//-(void)setAutoScroll:(BOOL)autoScroll{
//    _autoScroll = autoScroll;
//    
//    [self invalidateTimer];
//    
//    if (_autoScroll) {
//        [self setupTimer];
//    }
//}
//
//- (void)setInfiniteLoop:(BOOL)infiniteLoop
//{
//    _infiniteLoop = infiniteLoop;
//    
//    if (self.imagePathsGroup.count) {
//        self.imagePathsGroup = self.imagePathsGroup;
//    }
//}
//
//- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
//{
//    _autoScrollTimeInterval = autoScrollTimeInterval;
//    
//    [self setAutoScroll:self.autoScroll];
//}
//
//- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
//{
//    _scrollDirection = scrollDirection;
//    
//    _flowLayout.scrollDirection = scrollDirection;
//}
//
//#pragma mark - pageControl属性设置
//
//- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
//    _hidesForSinglePage = hidesForSinglePage;
//}
//
//- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor
//{
//    _currentPageDotColor = currentPageDotColor;
//    UIPageControl *pageControl = (UIPageControl *)_pageControl;
//    pageControl.currentPageIndicatorTintColor = currentPageDotColor;
//    
//}
//
//- (void)setPageDotColor:(UIColor *)pageDotColor
//{
//    _pageDotColor = pageDotColor;
//    
//    if ([self.pageControl isKindOfClass:[UIPageControl class]]) {
//        UIPageControl *pageControl = (UIPageControl *)_pageControl;
//        pageControl.pageIndicatorTintColor = pageDotColor;
//    }
//}
//
//#pragma mark - 数据源 传递
//
//- (void)setLocalizationImageNamesGroup:(NSArray *)localizationImageNamesGroup
//{
//    _localizationImageNamesGroup = localizationImageNamesGroup;
//    self.imagePathsGroup = [localizationImageNamesGroup copy];
//}
//
//- (void)setImagePathsGroup:(NSArray *)imagePathsGroup
//{
//    [self invalidateTimer];
//    
//    _imagePathsGroup = imagePathsGroup;
//    
//    //设置cell.row
//    _totalItemsCount = self.infiniteLoop ? self.imagePathsGroup.count * 100 : self.imagePathsGroup.count;
//    
//    if (imagePathsGroup.count > 1) { // 由于 !=1 包含count == 0等情况
//        self.mainView.scrollEnabled = YES;
//        [self setAutoScroll:self.autoScroll];
//    } else {
//        self.mainView.scrollEnabled = NO;
//        [self setAutoScroll:NO];
//    }
//    [self setUpPageControl];
//
//    [self.mainView reloadData];
//}
//
//- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
//{
//    _imageURLStringsGroup = imageURLStringsGroup;
//    
//    NSMutableArray *temp = [NSMutableArray new];
//    [_imageURLStringsGroup enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * stop) {
//        NSString *urlString;
//        if ([obj isKindOfClass:[NSString class]]) {
//            urlString = obj;
//        } else if ([obj isKindOfClass:[NSURL class]]) {
//            NSURL *url = (NSURL *)obj;
//            urlString = [url absoluteString];
//        }
//        if (urlString) {
//            [temp addObject:urlString];
//        }
//    }];
//    self.imagePathsGroup = [temp copy];
//}
//
//
//
//
//@end
