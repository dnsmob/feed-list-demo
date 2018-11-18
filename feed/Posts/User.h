//
//  PeopleInformationTable.h
//  feed
//
//  Created by Denis Santos on 17/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import <Realm/RLMObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : RLMObject
  @property NSInteger userId;
  @property NSString *longDescription;
  @property NSString *shortDescription;
@end

NS_ASSUME_NONNULL_END
