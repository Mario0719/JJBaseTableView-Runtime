//
//  TabbarController.m
//  MyRAC
//
//  Created by Mario on 2019/8/5.
//  Copyright © 2019 MS. All rights reserved.
//

#import "TabbarController.h"
#import "NavigationController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NavigationController *table = [[NavigationController alloc] initWithRootViewController:[[TableViewController alloc] init]];
    
    NavigationController *collection = [[NavigationController alloc] initWithRootViewController:[[CollectionViewController alloc] init]];
    
    self.viewControllers = @[table,collection];
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
