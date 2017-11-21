//
//  ViewController.m
//  ExcelView
//
//  Created by cao longjian on 2017/11/21.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "XTExcelView.h"


@interface ViewController () <XTExcelViewDataSource>

@property (nonatomic, strong) XTExcelView *excelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.excelView];
    
    [self.excelView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view.mas_top);
        }
        make.left.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - XTExcelViewDataSource
/**返回表头第一个大小*/
- (CGSize)excelHeaderSizeInExcelView {
    return CGSizeMake(100 * displayScale, 35 * displayScale);
}

/**返回表格列的宽度（不包括第一列）*/
- (CGFloat)widthOfColumInExcelViewIndex:(NSInteger)index {
    
    return ([UIScreen mainScreen].bounds.size.width -100 * displayScale) / 2.0;
}

/**返回表格行的高度（不包括第一行）*/
- (CGFloat)heightOfRowInExcelViewIndex:(NSInteger)index {
    return 35 * displayScale;
}

/**返回表格头部属性*/
- (NSArray<NSString *> *)titlesOfColumInExcelView{
    return @[@"关键指标",@"销售整体",@"会员整体",@"会员整体",@"会员整体"];
}

/**返回表格行数*/
- (NSInteger)numberOfRowsInExcelView {
    return 10;
}

- (XTExcelView *)excelView {
    if (!_excelView) {
        _excelView = [[XTExcelView alloc] initWithFrame:CGRectZero dataSource:self];
    }
    return _excelView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
