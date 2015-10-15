//
//  UserViewController.h
//  GOTour
//
//  Created by 磊 田 on 15/10/14.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferrerModel.h"

@interface UserViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ReferrerModel *referrer;

@end
