//
//  ViewController.m
//  GolfMovie
//
//  Created by JQ on 16/5/6.
//  Copyright © 2016年 czbk. All rights reserved.
//

#import "ViewController.h"
#import "PlayerView.h"

#define VideoWidth  [UIScreen mainScreen].bounds.size.width    //视频宽度
#define VideoHeight ([UIScreen mainScreen].bounds.size.height-50)    //视频高度

#define VideoPath [DOCSFOLDER stringByAppendingPathComponent:@"test.mp4"]
#define DOCSFOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"

@interface ViewController ()
{
    UILabel *_currentLabel;
    
    UISlider *_sliderView;
    
    UIButton                *_playBtn; //播放按钮
    UIImageView             *_image;   //播放按钮图片
    UIImageView             *_thumbImgView; //抓取视频的图片
    
}

@property (nonatomic, strong)PlayerView *playerView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIButton *addMBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    
    addMBtn.backgroundColor = [UIColor orangeColor];
    [addMBtn setTitle:@"添加" forState:UIControlStateNormal];
    
    [self.view addSubview:addMBtn];
    
    [addMBtn addTarget:self action:@selector(addMovie:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)addMovie:(UIButton *)btn{
    
    self.playerView = [[PlayerView alloc]initWithFrame:CGRectMake(0, 50, VideoWidth,VideoHeight)];
    
    [self.view addSubview:self.playerView];
    
    _sliderView = [[UISlider alloc]initWithFrame:CGRectMake(0, 20, VideoWidth ,30)];
    
    [self.view addSubview:_sliderView];
    
    [_sliderView addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    //实例化一个媒体对象
//    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp4"]]];
    AVPlayer *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:@"http://sm.domob.cn/ugc/151397.mp4"]];
    //获取视频的第一帧图片
//    UIImage *videoThumbImg = [item ];
//        UIImage *videoThumbImg = [pc thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
    //    _thumbImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, VideoY, VideoWidth, VideoHeight)];
    //    [_thumbImgView setImage:videoThumbImg];
    //    [self.view addSubview:_thumbImgView];
   
    //设置播放器播放的媒体对象
    self.playerView.player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    
    //播放器播放的时间不能确定
    //KVO监测
    [self.playerView.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //设置播放按钮
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.backgroundColor = [UIColor clearColor];
    [_playBtn setFrame:CGRectMake(0.0f, VideoHeight, 50.0f, 50.0f)];
    [_playBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playBtn];
    
    //设置播放按钮的图片
    _image = [[UIImageView alloc]init];
    _image.frame = CGRectMake(0.0f, VideoHeight, 50.0f, 50.0f);
    [_image setImage:[UIImage imageNamed:@"2.png"]];
    [self.view addSubview:_image];
}
#pragma mark- KVO回调方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    //判断是否为观察的属性
    if (object == self.playerView.player.currentItem && [keyPath isEqualToString:@"status"]) {
        //判断状态
        if ([change[@"new"] integerValue] == AVPlayerItemStatusReadyToPlay) {
            
            NSLog(@"可以播放");
            
            //设置播放进度的最大值
            NSInteger totalSeconds = self.playerView.player.currentItem.duration.value / self.playerView.player.currentItem.duration.timescale;
            
            _sliderView.maximumValue = totalSeconds;
            
            //设置进度条跟随播放进度改变
            [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
                //usingBlock 回调block
                //time 当前播放的时间
                //设置当前播放的进度
                NSInteger currentSeconds = time.value / time.timescale;
                
                _sliderView.value = currentSeconds;
                
            }];
            
            
        }
        
    }
    
}

//播放视频
- (void) playVideo
{
    //根据视频播放状态，点击视频，出现播放按钮图片或者隐藏
    if (_image.hidden == YES) {
        
        [self.playerView.player pause];
        _image.hidden = NO;
        return;
    }else if (_image.hidden == NO) {
        _image.hidden = YES;
        [self.playerView.player play];
        return;
    }
    
    //界面刚显示播放按钮应显示，所以调用时播放图片应为隐藏
    //    _image.hidden = YES;
}
//修改播放进度
- (void)sliderAction:(UISlider *)sender {
    
    [self.playerView.player seekToTime:CMTimeMake(sender.value, 1)];
    
}
-(void)dealloc{
    
    //移除观察者
    [self.playerView.player.currentItem removeObserver:self forKeyPath:@"status"];
    
}
    
    //获取视频的第一帧图片
//    UIImage *videoThumbImg = [pc thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
//    _thumbImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, VideoY, VideoWidth, VideoHeight)];
//    [_thumbImgView setImage:videoThumbImg];
//    [self.view addSubview:_thumbImgView];
    



@end
