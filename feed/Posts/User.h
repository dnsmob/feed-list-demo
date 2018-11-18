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
  @property NSString *name; // only using name and id in this example
  
//id: 1,
//name: "Leanne Graham",
//username: "Bret",
//email: "Sincere@april.biz",
//address: {
//  street: "Kulas Light",
//  suite: "Apt. 556",
//  city: "Gwenborough",
//  zipcode: "92998-3874",
//  geo: {
//    lat: "-37.3159",
//    lng: "81.1496"
//  }
//},
//phone: "1-770-736-8031 x56442",
//website: "hildegard.org",
//company: {
//  name: "Romaguera-Crona",
//  catchPhrase: "Multi-layered client-server neural-net",
//  bs: "harness real-time e-markets"
//}
  
@end

NS_ASSUME_NONNULL_END
