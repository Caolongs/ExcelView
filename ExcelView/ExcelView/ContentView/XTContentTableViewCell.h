//
//  XTContentTableVIewCell.h
//  XiaotuBoss
//
//  Created by cao longjian on 2017/11/20.
//  Copyright © 2017年 ChuangChuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTExcelViewDataSource.h"

@interface XTContentTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *leftTextLab;

@property (nonatomic, weak) id<XTExcelViewDataSource> dataSource;

@end
