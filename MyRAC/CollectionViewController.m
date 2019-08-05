//
//  CollectionViewController.m
//  MyRAC
//
//  Created by Mario on 2019/8/5.
//  Copyright © 2019 MS. All rights reserved.
//

#import "CollectionViewController.h"
#import "JJCollectionView/JJBaseCollectionView.h"

@interface CollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) JJBaseCollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTitle:@"collection"];
    
    _dataSource = @[@"1",@"2"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[JJBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[UICollectionViewCell className]];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.autoNetworkNotice = YES;
    _collectionView.enableRefresh = YES;
    
    __weak typeof(self) weakSelf = self;
    _collectionView.collectionViewHeaderRefresh = ^{
        int x = arc4random() % 2;
        if (x == 0) {
            weakSelf.dataSource = @[];
        }else{
            weakSelf.dataSource = @[@"1",@"2",@"3"];
        }
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView endingRefresh];
    };
    
    
    
    UIButton *networkButton = [UIButton new];
    networkButton.frame = CGRectMake(0, 0, 44, 44);
    [networkButton setTitle:@"断网" forState:0];
    [networkButton setTitle:@"恢复" forState:UIControlStateSelected];
    [networkButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *  _Nonnull sender) {
        sender.selected = !sender.selected;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkChange" object:@(!sender.selected)];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:networkButton];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UICollectionViewCell className] forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.width, 60);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
