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
  @end

@implementation DataModel
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
             [realm deleteAllObjects]; // should/could update known entries, but for simplicity, let's just recreate the database

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

         }
         failure:^(NSURLSessionTask *operation, NSError *error){
           NSLog(@"error %@", error);
           
           [self setValue:[Post allObjects] forKey:@"posts"];
           [self didChangeValueForKey:@"posts"];
         }];
  }
  
  -(void) loadDetailsForPost:(Post *)post {
    [manager.operationQueue cancelAllOperations]; // cancel loading, will start a new one

    NSString *path = @"http://jsonplaceholder.typicode.com/users";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%ld", path, (long)post.userId]];
    [manager GET:url.absoluteString
      parameters:NULL
        progress:NULL
         success:^(NSURLSessionTask *task, id responseObject) {
           
           RLMRealm *realm = [RLMRealm defaultRealm];
           [realm transactionWithBlock:^{
             User *user = [[User alloc] init];
             user.userId = [[responseObject valueForKey:@"id"] integerValue];
             user.name = [[responseObject valueForKey:@"name"] description];
             
             // append user to post object
             post.user = user;
           }];
           
//           [self setValue:[Post allObjects] forKey:@"posts"];
         }
         failure:^(NSURLSessionTask *operation, NSError *error){
           NSLog(@"error %@", error);
           
           [self setValue:[Post allObjects] forKey:@"posts"];
           [self didChangeValueForKey:@"posts"];
         }];
  }
  
  @end
