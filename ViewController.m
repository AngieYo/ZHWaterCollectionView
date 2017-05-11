//
//  ViewController.m
//  ZHWaterCollectionView
//
//  Created by 1860 on 2017/5/10.
//  Copyright © 2017年 HangZhao. All rights reserved.
//

#import "ViewController.h"
#import "ZHWaterFlowLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) UICollectionView *waterCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"瀑布流";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.view addSubview:self.waterCollectionView];
    [self.waterCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (UICollectionView *)waterCollectionView{
    if (!_waterCollectionView) {
        ZHWaterFlowLayout *layout = [[ZHWaterFlowLayout alloc] init];

        _waterCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _waterCollectionView.delegate = self;
        _waterCollectionView.dataSource = self;
        _waterCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _waterCollectionView;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
