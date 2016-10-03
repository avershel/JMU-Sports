//
//  ViewController.h
//  FriendPoints
//
//  Created by Austin Vershel on 3/23/15.
//  Copyright (c) 2015 Austin Vershel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (copy, nonatomic) NSMutableArray *people;
@property (copy, nonatomic) NSMutableArray *fball;

@property (strong, nonatomic) UIAlertView *av;
@property (strong, nonatomic) NSUserDefaults* defaults;
@property NSInteger index;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property int schedindex;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *roster;

@property (weak, nonatomic) IBOutlet UINavigationBar *nav;
@property (weak, nonatomic) IBOutlet UINavigationItem *titlebar;

@end

