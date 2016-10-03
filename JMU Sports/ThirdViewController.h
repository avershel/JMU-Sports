//
//  ThirdViewController.h
//  JMU Sports
//
//  Created by Austin Vershel on 10/3/16.
//  Copyright © 2016 Austin Vershel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (copy, nonatomic) NSMutableArray *people;
@property (copy, nonatomic) NSMutableArray *roster;

@property (strong, nonatomic) UIAlertView *av;
@property (strong, nonatomic) NSUserDefaults* defaults;
@property NSInteger index;
@property NSInteger ct;
@property bool check;

@property (weak, nonatomic) IBOutlet UITableView *tv;
@property int schedindex;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *roster;

@property (weak, nonatomic) IBOutlet UINavigationBar *nav;
@property (weak, nonatomic) IBOutlet UINavigationItem *titlebar;

@end
