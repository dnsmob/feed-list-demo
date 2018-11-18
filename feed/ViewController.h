//
//  ViewController.h
//  demo
//
//  Created by Denis Santos on 17/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "User.h"
#import "DataModel.h"
#import <Realm/RLMRealm.h>
#import <Realm/RLMResults.h>
#import <Realm/RLMArray.h>
#import <AFNetworking/AFNetworking.h>
#import "UIRefreshControl+beginRefreshing.h"
#import "DetailsViewController.h"

@interface ViewController : UIViewController {
}
  
  @property (weak, nonatomic) IBOutlet UITableView *tableView;
  
@end
