//
//  AppModel.h
//  feed
//
//  Created by Denis Santos on 17/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/RLMResults.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Post.h"
#import <Realm/RLMRealm.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject

  -(void) loadPosts:(void(^)(bool)) completionHandler;
  -(void) loadDetailsForPost:(Post *)post;
  
  @property (nonatomic, strong) RLMResults *posts;
  
  @end

NS_ASSUME_NONNULL_END
