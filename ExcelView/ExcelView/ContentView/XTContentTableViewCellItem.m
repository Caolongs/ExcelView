//
//  XTContentTableViewCellItem.m
//  XiaotuBoss
//
//  Created by cao longjian on 2017/11/20.
//  Copyright © 2017年 ChuangChuang. All rights reserved.
//

#import "XTContentTableViewCellItem.h"
#import "Masonry.h"

@implementation XTContentTableViewCellItem


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.textLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        self.textLab.backgroundColor = [UIColor clearColor];
        self.textLab.textAlignment = NSTextAlignmentCenter;
        self.textLab.font = [UIFont systemFontOfSize:12];
        self.textLab.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.textLab];
        
        [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
        }];
        
    }
    return self;
}

@end
