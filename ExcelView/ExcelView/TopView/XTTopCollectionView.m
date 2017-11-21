//
//  XTTopCollectionView.m
//  XiaotuBoss
//
//  Created by cao longjian on 2017/11/16.
//  Copyright © 2017年 ChuangChuang. All rights reserved.
//

#import "XTTopCollectionView.h"
#import "XTTopCollectionViewCell.h"
#import "XTExcel.h"
#import "Masonry.h"

@interface XTTopCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSString *> *dataArray;

@property (nonatomic, strong) UIScrollView *keyScrollView;


@end

@implementation XTTopCollectionView

static NSString *topCellIdentify = @"XTTopCollectionViewCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellCollectionScroll:) name:N_ContentTableViewCellCollectionViewScroll object:nil];
        
    }
    return self;
}

#pragma mark - notification
- (void)cellCollectionScroll:(NSNotification *)noti {
    UIScrollView *scrollView = noti.object;
    self.keyScrollView = scrollView;
    self.collectionView.contentOffset = scrollView.contentOffset;
}

#pragma mark - Setter
- (void)setDataSource:(id<XTExcelViewDataSource>)dataSource {
    _dataSource = dataSource;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesOfColumInExcelView)]) {
        
        NSArray *tmpArr = [self.dataSource titlesOfColumInExcelView];
        NSCAssert(tmpArr.count > 1, @"必须大于1");
        self.dataArray = [tmpArr subarrayWithRange:NSMakeRange(1, tmpArr.count-1)];
        
    }
    
    [self.collectionView reloadData];
}


#pragma mark - collectionViewDataSource&&collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;

    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XTTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCellIdentify forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row ];
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    CGFloat h = 0;
    CGFloat w = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(excelHeaderSizeInExcelView)]) {
        CGSize size = [self.dataSource excelHeaderSizeInExcelView];
        h = size.height;
        w = ([UIScreen mainScreen].bounds.size.width - size.width) / self.dataArray.count;
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(widthOfColumInExcelViewIndex:)]) {
        w = [self.dataSource widthOfColumInExcelViewIndex:indexPath.row];
    }
    
    return CGSizeMake(w, h);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
    
}

#pragma mark - UIScrollviewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.keyScrollView = scrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.keyScrollView isEqual:scrollView]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:N_TopCollectionViewScroll object:scrollView];
    }
}

#pragma mark - Setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = YES;
        
        [_collectionView registerClass:[XTTopCollectionViewCell class] forCellWithReuseIdentifier:topCellIdentify];
    }
    return _collectionView;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
