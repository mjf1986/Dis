//
//  ContractUsViewController.m
//  Skp
//
//  Created by 剑锋 莫 on 16/3/11.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#import "ContractUsViewController.h"
#import "PKRevealController.h"

@interface ContractUsViewController ()

@end

@implementation ContractUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Contract Us"];
    self.view.backgroundColor = [UIColor blackColor];
//    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftmenu"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView)];
//     self.navigationItem.leftBarButtonItem = btnLeft;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//按钮点击事件
- (void) showLeftView {
    PKRevealController *revealController = self.parentViewController.parentViewController.revealController;
    [revealController showViewController:revealController.leftViewController];

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
