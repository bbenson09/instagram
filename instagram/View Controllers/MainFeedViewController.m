//
//  MainFeedViewController.m
//  instagram
//
//  Created by Bevin Benson on 7/9/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "MainFeedViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "PhotoCell.h"

@interface MainFeedViewController ()

@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (strong, nonatomic) NSArray *posts;
@property UIRefreshControl *refreshControl;

@end

@implementation MainFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.feedTableView insertSubview:self.refreshControl atIndex:0];
    
    // Set up for UITableView
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
    
    [self queryPosts];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)queryPosts {
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            [self.feedTableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)didPost {
    
    [self queryPosts];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    [self queryPosts];
    
    
}

- (IBAction)logoutTapped:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PhotoCell *cell = [self.feedTableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];

    cell.post = self.posts[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.posts.count;
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController *)navigationController.topViewController;
    composeController.delegate = self;
    
    
}
 


@end
