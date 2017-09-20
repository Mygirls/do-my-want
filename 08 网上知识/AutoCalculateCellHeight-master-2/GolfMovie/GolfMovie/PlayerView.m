//
//  PlayerView.m
//  RecScreen
//
//  Created by JQ on 16/5/5.
//  Copyright © 2016年 czbk. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView


//由于只有AVPlayerLayer上才能安置AVPlayer播放器,所以必须重写以下方法返回AVPlayerLayer
+ (Class)layerClass{
    return [AVPlayerLayer class];
}

-(void)setPlayer:(AVPlayer *)player{
    
    //主要目的是想把这个播放器安置到AVPlayerLayer上
    AVPlayerLayer *layer = (AVPlayerLayer *)self.layer;
    
    //安置播放器
    layer.player = player;
}

-(AVPlayer *)player{
    
    //主要目的是想把这个播放器从图层上取出来
    AVPlayerLayer *layer = (AVPlayerLayer *)self.layer;
    
    return layer.player;
    
}


@end
