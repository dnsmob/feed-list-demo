//
//  ViewController.m
//  demo
//
//  Created by Denis Santos on 17/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
  @property (strong, nonatomic) DataModel *model;
  @property (strong, nonatomic) UIRefreshControl *refreshControl;
  @property (strong, nonatomic) Post *selectedPost;
  
  @end

@implementation ViewController
  
-(void) viewDidLoad {
  [super viewDidLoad];
  self.model = [[DataModel alloc] init];
  
  // basic setup
  [self createRefreshControl];
  [self addEvents];
  
  // show loading state
  [self.model loadPosts];
  [self.refreshControl beginRefreshingProgrammatically];
}
  
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id) object
                        change:(NSDictionary *)change
                       context:(void *)context {
  // posts model changed
  [self.refreshControl endRefreshing];
  [self.tableView reloadData];
}
  
-(void) createRefreshControl {
  self.refreshControl = [[UIRefreshControl alloc] init];
  self.tableView.refreshControl = self.refreshControl;
}
  
-(void) addEvents {
  [self.refreshControl addTarget:self
                          action:@selector(onRefreshChanged)
                forControlEvents:UIControlEventValueChanged];
  
  [self.model addObserver:self
               forKeyPath:@"posts"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
}
  
-(void) onRefreshChanged {
  // forcing a reload request
  [self.model loadPosts];
}
  
  // MARK: TableView methods
-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger) section {
  return [self.model.posts count];
}
  
-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
  static NSString *cellid = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:cellid];
  }
  
  Post *post = [self.model.posts objectAtIndex:indexPath.row];
  cell.textLabel.text = post.title;
  
  return cell;
}
  
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  self.selectedPost = [self.model.posts objectAtIndex:indexPath.row];
  
  [self.model loadDetailsForPost:self.selectedPost];
  [self performSegueWithIdentifier:@"segueToDetails" sender:nil];
}
 
  // MARK: segue details
  -(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id) sender {
    DetailsViewController *view = (DetailsViewController *)segue.destinationViewController;
    view.model = self.model;
    view.post = self.selectedPost;
  }

  @end
