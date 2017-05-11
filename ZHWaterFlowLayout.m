//
//  ZHWaterFlowLayout.m
//  ZHWaterCollectionView
//
//  Created by 1860 on 2017/5/10.
//  Copyright © 2017年 HangZhao. All rights reserved.
//

#import "ZHWaterFlowLayout.h"

#define CollectionViewWidth self.collectionView.frame.size.width

//行距
static const CGFloat RowMargin = 10;
//列距
static const CGFloat ColumnMargin = 10;
//cell的EdageInsets
static const UIEdgeInsets DefaultEdgeInsets = {10,10,10,10};
//默认的列数
static const int ColumnCount = 3;
@interface ZHWaterFlowLayout()
//每一列的最大Y值
@property (nonatomic , strong) NSMutableArray *MaxYsColumn;
//保存cell的属性
@property (nonatomic , strong) NSMutableArray *attrsArray;
@end

@implementation ZHWaterFlowLayout

- (NSMutableArray *)MaxYsColumn{
    if (!_MaxYsColumn) {
        _MaxYsColumn = [NSMutableArray array];
    }
    return _MaxYsColumn;
}


- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc]init];
    }
    return _attrsArray;
}

- (void)prepareLayout{
    [super prepareLayout];
    [self.MaxYsColumn removeAllObjects];
    for (NSInteger i = 0; i < ColumnCount; i++) {
        [self.MaxYsColumn addObject:@(DefaultEdgeInsets.top)];
    }
    //
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.attrsArray addObject:attr];
    }
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //cell的水平间距
    CGFloat xMargin = DefaultEdgeInsets.left + DefaultEdgeInsets.right + (ColumnCount - 1) * ColumnMargin;
    //cell的宽度
    CGFloat w = (CollectionViewWidth - xMargin)/ColumnCount;
    CGFloat h = 50 + arc4random_uniform(150);
    //找出最小的Y值和列号
    CGFloat minY = [self.MaxYsColumn[0] doubleValue];
    int locateColumn = 0;
    for (int i = 0; i < self.MaxYsColumn.count; i++) {
        if (minY > [self.MaxYsColumn[i] doubleValue]) {
            minY = [self.MaxYsColumn[i] doubleValue];
            locateColumn = i;
        }
    }
    //计算cell的x,Y值
    CGFloat x = DefaultEdgeInsets.left + locateColumn*(w + ColumnMargin);
    CGFloat y = minY + RowMargin;
    attrs.frame = CGRectMake(x, y, w, h);
    self.MaxYsColumn[locateColumn] = @(CGRectGetMaxY(attrs.frame));
    return attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

- (CGSize)collectionViewContentSize{
    //找出最大的Y值
    CGFloat maxY = [self.MaxYsColumn[0] doubleValue];
    for (NSInteger i = 1; i < self.MaxYsColumn.count; i ++) {
        if (maxY < [self.MaxYsColumn[i] doubleValue]) {
            maxY = [self.MaxYsColumn[i] doubleValue];
        }
    }
    return CGSizeMake(0, maxY + DefaultEdgeInsets.bottom);
}

@end


