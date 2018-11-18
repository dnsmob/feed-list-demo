//
//  DetailsViewControl.m
//  feed
//
//  Created by Denis Santos on 18/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import "DetailsViewControl.h"

@interface DetailsViewControl ()
  
  @end

@implementation DetailsViewControl
  
  -(void) viewDidLoad {
    [super viewDidLoad];
  }
  
  -(void) viewWillAppear:(BOOL) animated {
    [self addEvents];
    
    // setup ui elements
    [self.details setText: self.post.body];
    if (self.post.user != NULL) { // user details cached? 🤔
      [self.user setText:self.post.user.name];
    }
  }
  
  -(void) viewWillDisappear:(BOOL) animated {
    [self.model removeObserver:self forKeyPath:@"posts"];
  }
  
  -(void) addEvents {
    [self.model addObserver:self
                 forKeyPath:@"posts"
                    options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                    context:nil];
  }
  
  -(void) observeValueForKeyPath:(NSString *) keyPath
                        ofObject:(id) object
                          change:(NSDictionary *) change
                         context:(void *) context {
    // update user field
    NSLog(@"change %@", change);
  }
  
  @end
