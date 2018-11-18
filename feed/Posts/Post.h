//
//  PeopleInformationTable.h
//  feed
//
//  Created by Denis Santos on 17/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import <Realm/RLMObject.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post : RLMObject
  @property NSInteger userId;
  @property NSInteger postId;
  @property NSString *title;
  @property NSString *body;
  @property User *user;
@end

NS_ASSUME_NONNULL_END
