//
//  TableViewCell.m
//  1233
//
//  Created by cfzq on 2017/3/24.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subView in self.subviews) {
        
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            
            // 拿到subView之后再获取子控件
            
            // 因为上面删除按钮是第二个加的所以下标是1
            UIView *deleteConfirmationView = subView.subviews[1];
            //改背景颜色
            deleteConfirmationView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:42.0/255.0 blue:62.0/255.0 alpha:1.0];
            for (UIView *deleteView in deleteConfirmationView.subviews) {
                NSLog(@"%@",deleteConfirmationView.subviews);
                UIImageView *deleteImage = [[UIImageView alloc] init];
                deleteImage.contentMode = UIViewContentModeScaleAspectFit;
                deleteImage.image = [UIImage imageNamed:@""];
                deleteImage.frame = CGRectMake(0, 0, deleteView.frame.size.width, deleteView.frame.size.height);
                [deleteView addSubview:deleteImage];
            }
            
            // 这里是右边的
            UIView *shareConfirmationView = subView.subviews[0];
            shareConfirmationView.backgroundColor = [UIColor colorWithRed:142.0/255.0 green:201.0/255.0 blue:75.0/255.0 alpha:1.0];
            for (UIView *shareView in shareConfirmationView.subviews) {
                UIImageView *shareImage = [[UIImageView alloc] init];
                shareImage.contentMode = UIViewContentModeScaleAspectFit;
                shareImage.image = [UIImage imageNamed:@""];
                shareImage.frame = CGRectMake(0, 0, shareView.frame.size.width, shareView.frame.size.height);
                [shareView addSubview:shareImage];
            }
        }
    }

}
//看图层发现加了很多图片的，因为layoutSubviews会调用多次，可以把控件懒加载就行了，或者其实UITableViewCellDeleteConfirmationView里的控件本质上是UIButton，直接设置图片。

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
