//
//  XTContentTableView.m
//  XiaotuBoss
//
//  Created by cao longjian on 2017/11/20.
//  Copyright © 2017年 ChuangChuang. All rights reserved.
//

#import "XTContentTableView.h"
#import "XTContentTableViewCell.h"

@interface XTContentTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XTContentTableView

static NSString *contentCellIdentify = @"XTContentTableViewCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    return self;
}

- (void)setDataSource:(id<XTExcelViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

#pragma mark - UITbaleView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInExcelView)]) {
        return [self.dataSource numberOfRowsInExcelView];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellIdentify];
    cell.leftTextLab.text = @"--";
    cell.dataSource = self.dataSource;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(heightOfRowInExcelViewIndex:)]) {
        return [self.dataSource heightOfRowInExcelViewIndex:indexPath.row];
    }
    return 44 ;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[XTContentTableViewCell class] forCellReuseIdentifier:contentCellIdentify];
    }
    return _tableView;
}

@end
