//
//  AppModel.m
//  feed
//
//  Created by Denis Santos on 17/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import "AppModel.h"


@interface AppModel ()
  @property (nonatomic) AFHTTPSessionManager *manager;
  @end

@implementation AppModel
  @synthesize manager;
  
  -(instancetype) init {
    self = [super init];
    if (self) {
      manager = [AFHTTPSessionManager manager];
    }
    return self;
  }
  
  -(void) loadPosts {
    [manager.operationQueue cancelAllOperations]; // cancel loading, will start a new one
    
    NSURL *url = [NSURL URLWithString:@"http://jsonplaceholder.typicode.com/posts"];
    [manager GET:url.absoluteString
      parameters:NULL
        progress:NULL
         success:^(NSURLSessionTask *task, id responseObject){
           RLMRealm *realm = [RLMRealm defaultRealm];
           [realm transactionWithBlock:^{

             [realm deleteAllObjects];

             for (id object in responseObject) {
               Post *post = [[Post alloc] init];
               post.userId = [[object valueForKey:@"userId"] integerValue];
               post.postId = [[object valueForKey:@"id"] integerValue];
               post.title = [[object valueForKey:@"title"] description];
               post.body = [[object valueForKey:@"body"] description];

               // write post entry
               [realm addObject:post];
             }
           }];

           [self setValue:[Post allObjects] forKey:@"posts"];
           NSLog(@"saved all posts");
         }
         failure:^(NSURLSessionTask *operation, NSError *error){
           NSLog(@"error %@", error);
           
           [self setValue:[Post allObjects] forKey:@"posts"];
           [self didChangeValueForKey:@"posts"];
         }];
  }
  
  
  
//  -(void)setPosts:(RLMResults *)posts{
//    NSLog(@"called setter");
//    [self willChangeValueForKey:@"posts"];
//    _posts = posts;
//    [self didChangeValueForKey:@"posts"];
//  }
  
  @end
