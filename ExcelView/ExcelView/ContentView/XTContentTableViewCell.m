//
//  XTContentTableVIewCell.m
//  XiaotuBoss
//
//  Created by cao longjian on 2017/11/20.
//  Copyright © 2017年 ChuangChuang. All rights reserved.
//

#import "XTContentTableViewCell.h"
#import "XTContentTableViewCellItem.h"
#import "XTExcel.h"

@interface XTContentTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIScrollView *keyScrollView;

@end

@implementation XTContentTableViewCell

static NSString *cellIdentify = @"XTContentTableViewCellItem";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.leftTextLab = [[UILabel alloc] init];
        self.leftTextLab.textAlignment = NSTextAlignmentCenter;
        self.leftTextLab.font = FONT_SIZE(12 * displayScale);
        self.leftTextLab.textColor = RGB(76, 90, 103);
        [self.contentView addSubview:self.leftTextLab];
        
        [self.contentView addSubview:self.collectionView];
        
        UIView *topLine = [[UIView alloc] init];
        topLine.backgroundColor = RGB(236, 236, 236);
        [self.contentView addSubview:topLine];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = RGB(236, 236, 236);
        [self.contentView addSubview:bottomLine];
        
        [self.leftTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.width.mas_equalTo(100 * displayScale);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftTextLab.mas_right);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0.25);
        }];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0.25);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topScroll:) name:N_TopCollectionViewScroll object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellCollectionScroll:) name:N_ContentTableViewCellCollectionViewScroll object:nil];
        
    }
    return self;
}

#pragma mark - notification
- (void)topScroll:(NSNotification *)noti {
//    NSValue *pointValue = noti.object;
//    self.collectionView.contentOffset = pointValue.CGPointValue;
    UIScrollView *scrollView = noti.object;
    self.keyScrollView = scrollView;
    self.collectionView.contentOffset = scrollView.contentOffset;
    
}

- (void)cellCollectionScroll:(NSNotification *)noti {
//    NSValue *pointValue = noti.object;
//    self.collectionView.contentOffset = pointValue.CGPointValue;
    
    UIScrollView *scrollView = noti.object;
    self.keyScrollView = scrollView;
    self.collectionView.contentOffset = scrollView.contentOffset;
}

#pragma mark - Setter
- (void)setDataSource:(id<XTExcelViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self.collectionView reloadData];
}

#pragma mark - collectionViewDataSource&&collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesOfColumInExcelView)]) {
        NSArray *titleArr = [self.dataSource titlesOfColumInExcelView];
        return titleArr.count - 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XTContentTableViewCellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.textLab.text = @"hehe";
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    
    if (self.dataSource) {
        CGFloat w = 0;
        CGFloat h = 0;
        if ([self.dataSource respondsToSelector:@selector(widthOfColumInExcelViewIndex:)]) {
            w = [self.dataSource widthOfColumInExcelViewIndex:indexPath.row];
        }
        if ([self.dataSource respondsToSelector:@selector(widthOfColumInExcelViewIndex:)]) {
            h = [self.dataSource heightOfRowInExcelViewIndex:indexPath.row];
        }
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.keyScrollView = scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([self.keyScrollView isEqual:scrollView]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:N_ContentTableViewCellCollectionViewScroll object:scrollView];
    }
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = YES;
        
        [_collectionView registerClass:[XTContentTableViewCellItem class] forCellWithReuseIdentifier:cellIdentify];
    }
    return _collectionView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
