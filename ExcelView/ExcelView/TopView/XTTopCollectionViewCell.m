//
//  XTTopCollectionViewCell.m
//  XiaotuBoss
//
//  Created by cao longjian on 2017/11/16.
//  Copyright © 2017年 ChuangChuang. All rights reserved.
//

#import "XTTopCollectionViewCell.h"

@interface XTTopCollectionViewCell ()


@end

@implementation XTTopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = FONT_SIZE(11 * displayScale);
        _textLabel.textColor = RGB(153, 153, 153);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_textLabel];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

@end
