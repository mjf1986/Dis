//
//  LeftFaceController.m
//  PKRevealControllerDemo
//
//  Created by Barry Wey on 8/21/13.
//  Copyright (c) 2013 Barry Wey. All rights reserved.
//

#import "LeftFaceController.h"
#import "MainFaceController.h"
#import "PKRevealController.h"
#import "ProfileViewController.h"
#import "CommonHeader.h"

@interface LeftFaceController ()

@property (strong,nonatomic) MainFaceController *mainFaceController;
@property (strong,nonatomic) ProfileViewController *profileViewController;
@property (strong,nonatomic) NSMutableArray *arrTitle;
@end

@implementation LeftFaceController

@synthesize mainFaceController = _mainFaceController , profileViewController = _profileViewController;


- (ProfileViewController *) profileViewController {
    if(!_profileViewController)
    {
        _profileViewController = [[ProfileViewController alloc] init];
    }
    return _profileViewController;
}

- (MainFaceController *) mainFaceController
{
    if(!_mainFaceController)
    {
        _mainFaceController = [[MainFaceController alloc] init];
    }
    return _mainFaceController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.tableView.tableHeaderView.backgroundColor = BK_COLOR;
    
    _arrTitle = [[NSMutableArray alloc]initWithArray:@[@"Strip",@"Panel Light",@"Tube",@"Linear Light",@"Bulb",@"Downlight",@"Tablelight",@"Floodlight",@"Tri-proof lamp",@"High bay light",@"Wall washer",@"Garden light",@"Outdoor spolt light",@"Controller/Amplifier",@"Aluminum Bar"]];
    self.view.backgroundColor = BK_COLOR;
    self.tableView.backgroundColor = BK_COLOR;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellReuseIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    cell.textLabel.textColor = HINT_COLOR;
    [cell.textLabel setText: _arrTitle[indexPath.row]];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UINavigationController *frontViewController = nil;
//    switch (indexPath.row)
//    {
//        case 0:
//            //Home
//            frontViewController = [[UINavigationController alloc] initWithRootViewController:self.mainFaceController];
//            break;
//        case 1:
//            //Profile
//            frontViewController = [[UINavigationController alloc] initWithRootViewController:self.profileViewController];
//            break;
//    }
//    [self.revealController setFrontViewController:frontViewController];
    PKRevealController *revealController = self.revealController;
    [self.revealController showViewController:self.revealController.frontViewController];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
