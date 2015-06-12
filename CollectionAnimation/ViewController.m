//
//  ViewController.m
//  CollectionAnimation
//
//  Created by lidehua on 15/4/30.
//  Copyright (c) 2015年 李德华. All rights reserved.
//

#import "ViewController.h"
#import "LLCollectionViewFlowLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
//@property (strong, nonatomic) UICollectionView * collectionView;
@property (strong, nonatomic) LLCollectionViewFlowLayout * layout;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _layout = [[LLCollectionViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(self.view.bounds.size.width, 44);
        
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:_layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}
@end
