//
//  XTExcelViewDataSource.h
//  XiaotuBoss
//
//  Created by cao longjian on 2017/11/20.
//  Copyright © 2017年 ChuangChuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XTExcelView;
@protocol XTExcelViewDataSource <NSObject>

/**返回表头第一个大小*/
- (CGSize)excelHeaderSizeInExcelView;

/**返回表格列的宽度（不包括第一列）*/
- (CGFloat)widthOfColumInExcelViewIndex:(NSInteger)index;

/**返回表格行的高度（不包括第一行）*/
- (CGFloat)heightOfRowInExcelViewIndex:(NSInteger)index;

/**返回表格头部属性*/
- (NSArray<NSString *> *)titlesOfColumInExcelView;

/**返回表格行数*/
- (NSInteger)numberOfRowsInExcelView;


@optional
//- (UITableViewCell *)excelView:(XTExcelView *)excelView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
