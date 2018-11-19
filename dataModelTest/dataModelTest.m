//
//  dataModelTest.m
//  dataModelTest
//
//  Created by Denis Santos on 19/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataModel.h"


@interface dataModelTest : XCTestCase
  @property DataModel *model;
@end

@implementation dataModelTest

-(void) setUp {
  self.model = [[DataModel alloc] init];
}

-(void) tearDown {
}

-(void) testDownloadPosts {
  // there is a nil property posts
  XCTAssertNil(self.model.posts);
  
  // we get live json data
  [self.model loadPosts:^(bool finished) {
    // and convert to a realm list
    XCTAssertTrue([self.model.posts isKindOfClass:[RLMResults class]]);
    XCTAssertGreaterThan(self.model.posts.count, 0);
  }];
}

-(void) testPostElements {
  [self.model loadPosts:^(bool finished) {
    // we have a Post in index 0
    XCTAssertTrue([[self.model.posts objectAtIndex:0] isKindOfClass:[Post class]]);
    
    // no properties are null
    Post *post = [self.model.posts objectAtIndex:0];
    XCTAssertGreaterThanOrEqual(post.postId, 0);
    XCTAssertGreaterThanOrEqual(post.userId, 0);
    XCTAssertNotNil(post.title);
    XCTAssertNotNil(post.body);
    // we have an empty user
    XCTAssertNil(post.user);
    
    NSString *expected = @"sunt aut facere repellat provident occaecati excepturi optio reprehenderit";
    NSString *result = [[[self.model posts] objectAtIndex:0] objectForKey:@"title"];
    XCTAssertEqualObjects(expected, result);
  }];
}


@end
