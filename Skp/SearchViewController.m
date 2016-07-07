//
//  SearchViewController.m
//  Skp
//
//  Created by 剑锋 莫 on 16/3/15.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchResultsUpdating, UISearchBarDelegate,UISearchControllerDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Product Query";
    
//    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backUp)];
//    self.navigationItem.leftBarButtonItem = btnLeft;

    
    [self initializeSearchController];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)backUp
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)initializeSearchController {
    
    //instantiate a search results controller for presenting the search/filter results (will be presented on top of the parent table view)
    UITableViewController *searchResultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    searchResultsController.tableView.dataSource = self;
    
    searchResultsController.tableView.delegate = self;
    
    //instantiate a UISearchController - passing in the search results controller table
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    
    //this view controller can be covered by theUISearchController's view (i.e. search/filter table)
    self.definesPresentationContext = YES;
    
    
    
    //define the frame for the UISearchController's search bar and tint
    //    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x + 15, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    _searchController.hidesNavigationBarDuringPresentation = NO;//不隐藏导航栏
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    
    self.searchController.delegate = self;
    //add the UISearchController's search bar to the header of this table
    self.tableView.tableHeaderView = self.searchController.searchBar;
    //[self.navigationController.navigationBar addSubview:self.searchController.searchBar];
    
    self.searchController.active = YES;
    
    //this ViewController will be responsible for implementing UISearchResultsDialog protocol method(s) - so handling what happens when user types into the search bar
    self.searchController.searchResultsUpdater = self;
    
    
    //this ViewController will be responsisble for implementing UISearchBarDelegate protocol methods(s)
    self.searchController.searchBar.delegate = self;
}

#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}
#pragma mark - UISearchBarDelegate methods

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchController Delegate
- (void)didPresentSearchController:(UISearchController *)searchController
{
    [searchController.searchBar becomeFirstResponder];
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    [searchController.searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
