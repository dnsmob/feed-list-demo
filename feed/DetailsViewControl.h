//
//  DetailsViewControl.h
//  feed
//
//  Created by Denis Santos on 18/11/2018.
//  Copyright © 2018 Denis Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewControl : UIViewController
  
  @property (weak, nonatomic) IBOutlet UILabel *user;
  @property (weak, nonatomic) IBOutlet UITextView *details;
  @property (strong, nonatomic) Post *post;
  @property (strong, nonatomic) DataModel *model;
  
  @end

NS_ASSUME_NONNULL_END
