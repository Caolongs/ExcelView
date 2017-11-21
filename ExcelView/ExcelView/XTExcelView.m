//
//  XTExcelView.m
//  XiaotuBoss
//
//  Created by cao longjian on 2017/11/16.
//  Copyright © 2017年 ChuangChuang. All rights reserved.
//

#import "XTExcelView.h"
#import "XTTopCollectionView.h"
#import "XTContentTableView.h"

@interface XTExcelView ()

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) XTTopCollectionView *topCollectionView;
@property (nonatomic, strong) XTContentTableView *contentTableView;



@property (nonatomic, assign) CGSize headerSize;


@end

@implementation XTExcelView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<XTExcelViewDataSource>)dataSource {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(246, 246, 246);
        _dataSource = dataSource;
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(excelHeaderSizeInExcelView)]) {
            self.headerSize = [self.dataSource excelHeaderSizeInExcelView];
        }
        NSArray *titleArr;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesOfColumInExcelView)]) {
            titleArr = [self.dataSource titlesOfColumInExcelView];
        }
        
        self.headerLabel.text = titleArr.firstObject;
        [self addSubview:self.headerLabel];

        self.topCollectionView.dataSource = self.dataSource;
        [self addSubview: self.topCollectionView];
        
        [self addSubview:self.contentTableView];
        self.contentTableView.dataSource = self.dataSource;
        
        [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.width.mas_equalTo(self.headerSize.width);
            make.height.mas_equalTo(self.headerSize.height);
        }];
        
        [self.topCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerLabel.mas_right);
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(self.headerLabel.mas_height);
        }];
        
        [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.headerLabel.mas_bottom).offset(0.5);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];

    }
    return self;
}




- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _headerLabel.backgroundColor = [UIColor whiteColor];
        _headerLabel.textColor = RGB(153, 153, 153);
        _headerLabel.font = FONT_SIZE(11 * displayScale);
        _headerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _headerLabel;
}

- (XTTopCollectionView *)topCollectionView {
    if (!_topCollectionView) {
        _topCollectionView = [[XTTopCollectionView alloc] initWithFrame:CGRectZero];
    }
    return _topCollectionView;
}

- (XTContentTableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[XTContentTableView alloc] initWithFrame:CGRectZero];
    }
    return _contentTableView;
}


@end
