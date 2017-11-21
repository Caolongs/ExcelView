//
//  XTExcelView.h
//  XiaotuBoss
//
//  Created by cao longjian on 2017/11/16.
//  Copyright © 2017年 ChuangChuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTExcelViewDataSource.h"

@interface XTExcelView : UIView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<XTExcelViewDataSource>)dataSource;

@property (nonatomic, weak) id<XTExcelViewDataSource> dataSource;

@end
