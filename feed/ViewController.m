//
//  ViewController.m
//  demo
//
//  Created by Denis Santos on 17/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import "ViewController.h"
#import <Realm/RLMRealm.h>
#import <Realm/RLMResults.h>
#import <Realm/RLMArray.h>
#import <AFNetworking/AFNetworking.h>
#import "UIRefreshControl+beginRefreshing.h"


@interface ViewController ()
  @property (strong, nonatomic) AppModel *model;
  @property (strong, nonatomic) UIRefreshControl *refreshControl;
  
  //@property (strong, nonatomic) Post *selectedDataObject;
  
  @end

@implementation ViewController
  
-(void) viewDidLoad {
  [super viewDidLoad];
  self.model = [[AppModel alloc] init];
  
  // basic setup
  [self createRefreshControl];
  [self addEvents];
  
  // show loading state
  [self.model loadPosts];
  [self.refreshControl beginRefreshingProgrammatically];
}
  
-(void) observeValueForKeyPath:(NSString *) keyPath
                      ofObject:(id) object
                        change:(NSDictionary *) change
                       context:(void *) context {
  // posts model changed
  [self.refreshControl endRefreshing];
  [_tableView reloadData];
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
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
}
  
-(void) onRefreshChanged {
  // forcing a reload request
  [self.model loadPosts];
}
  
  // MARK: TableView methods
- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger) section {
  return [self.model.posts count];
}
  
- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
  static NSString * cellid = @"cell";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:cellid];
  }
  
  Post *post = [self.model.posts objectAtIndex:indexPath.row];
  cell.textLabel.text = post.title;
  
  return cell;
}
  
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  selectedDataObject = [self.tableDataArray objectAtIndex:indexPath.row];
  
  
}
 
  

  @end
