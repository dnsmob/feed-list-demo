//
//  AppModel.m
//  feed
//
//  Created by Denis Santos on 17/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import "DataModel.h"


@interface DataModel ()
  @property (nonatomic) AFHTTPSessionManager *manager;
  @property (nonatomic) RLMRealm *realm;
  @end

@implementation DataModel
  
  -(instancetype) init {
    self = [super init];
    if (self) {
      self.manager = [AFHTTPSessionManager manager];
      self.realm = [RLMRealm defaultRealm];
    }
    return self;
  }

-(void) loadPosts:(void(^)(bool)) handler {
    [self.manager.operationQueue cancelAllOperations]; // cancel loading, will start a new one
    
    NSURL *url = [NSURL URLWithString:@"http://jsonplaceholder.typicode.com/posts"];
    [self.manager GET:url.absoluteString
      parameters:NULL
        progress:NULL
         success:^(NSURLSessionTask *task, id responseObject){
           
           [self.realm transactionWithBlock:^{
             [self.realm deleteAllObjects]; // should/could update known entries, but for simplicity, let's just recreate the database

             for (id object in responseObject) {
               Post *post = [[Post alloc] init];
               post.userId = [[object valueForKey:@"userId"] integerValue];
               post.postId = [[object valueForKey:@"id"] integerValue];
               post.title = [[object valueForKey:@"title"] description];
               post.body = [[object valueForKey:@"body"] description];

               // write post entry
               [self.realm addObject:post];
             }
           }];

           [self setValue:[Post allObjects] forKey:@"posts"];
           
           handler(true);
         }
         failure:^(NSURLSessionTask *operation, NSError *error){
           NSLog(@"error %@", error);
           
           // recycle previously stored data
           [self setValue:[Post allObjects] forKey:@"posts"];
           
           handler(true);
         }];
  }
  
-(void) loadDetailsForPost:(Post *)post withCompletion:(void(^)(bool)) handler {
    if (post.user != NULL && post.user.userId >= 0) return;
    
    [self.manager.operationQueue cancelAllOperations]; // cancel loading, will start a new one
    
    NSString *path = @"http://jsonplaceholder.typicode.com/users";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%ld", path, (long)post.userId]];
    [self.manager GET:url.absoluteString
      parameters:NULL
        progress:NULL
         success:^(NSURLSessionTask *task, id responseObject) {
           
           [self.realm transactionWithBlock:^{
             User *user = [[User alloc] init];
             user.userId = [[responseObject valueForKey:@"id"] integerValue];
             user.name = [[responseObject valueForKey:@"name"] description];
             
             // append User to post object
             [post setValue:user forKey:@"user"];
           }];
           
           handler(true);
         }
         failure:^(NSURLSessionTask *operation, NSError *error){
           NSLog(@"error %@", error);
           
           [self.realm transactionWithBlock:^{
             // cant download, so let's create a temporary fake user
             User *user = [[User alloc] init];
             user.userId = -1;
             user.name = @"no internet 😵";
             [post setValue:user forKey:@"user"];
           }];
           
           handler(true);
         }];
  }
  
  @end
