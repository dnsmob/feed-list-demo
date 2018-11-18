//
//  DetailsViewControl.m
//  feed
//
//  Created by Denis Santos on 18/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
  
  @end

@implementation DetailsViewController
  
  -(void) viewDidLoad {
    [super viewDidLoad];
  }
  
  -(void) viewWillAppear:(BOOL) animated {
    [self addEvents];
    
    // setup ui elements
    self.details.text = self.post.body;
    if (self.post.user != NULL) { // user details cached? 🤔
      self.user.text = self.post.user.name;
    }
  }
  
  -(void) viewWillDisappear:(BOOL) animated {
    [self.post removeObserver:self forKeyPath:@"user"];
  }
  
  -(void) addEvents {
    [self.post addObserver:self
                forKeyPath:@"user"
                   options:NSKeyValueObservingOptionNew
                   context:nil];
  }
  
  -(void) observeValueForKeyPath:(NSString *)keyPath
                        ofObject:(id) object
                          change:(NSDictionary *)change
                         context:(void *)context {
    // update user field
    User *user = [change valueForKey:@"new"];
    self.user.text = user.name;
    self.user.textColor = user.userId < 0 ? [UIColor grayColor] : [UIColor blackColor];
  }
  
  @end
