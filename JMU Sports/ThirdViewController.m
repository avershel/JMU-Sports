//
//  ThirdViewController.m
//  JMU Sports
//
//  Created by Austin Vershel on 10/3/16.
//  Copyright © 2016 Austin Vershel. All rights reserved.
//

#import "ThirdViewController.h"
#import "SecondViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
static NSString *CellIdentifier = @"CellTableIdentifier";
@synthesize av,defaults, tv, title, index, nav, titlebar, schedindex, roster, check;

- (void)viewDidLoad {
    [super viewDidLoad];
    roster = [NSMutableArray new];

    NSDictionary *rowData = self.people[index];
    titlebar.title = @"Roster";
    tv.dataSource = self;
    tv.delegate = self;
    tv.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    
    
    NSURL *url;
     check = false;
    if([rowData[@"Name"]  isEqual: @"Men's Football"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=football"];
    } else if([rowData[@"Name"]  isEqual: @"Men's Basketball"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=mbball"];
    } else if([rowData[@"Name"]  isEqual: @"Women's Basketball"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=wbball"];
    } else if([rowData[@"Name"]  isEqual: @"Men's Soccer"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=msoc"];
    } else if([rowData[@"Name"]  isEqual: @"Women's Soccer"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=wsoc"];
    } else if([rowData[@"Name"]  isEqual: @"Men's Golf"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=mgolf"];
        check = true;
    } else if([rowData[@"Name"]  isEqual: @"Women's Golf"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=wgolf"];
        check = true;

    } else if([rowData[@"Name"]  isEqual: @"Men's Tennis"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=mten"];
        check = true;

    } else if([rowData[@"Name"]  isEqual: @"Women's Tennis"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=wten"];
        check = true;

    } else if([rowData[@"Name"]  isEqual: @"Women's Field Hockey"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=fhockey"];
    } else if([rowData[@"Name"]  isEqual: @"Women's Softball"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=softball"];
    } else if([rowData[@"Name"]  isEqual: @"Women's Lacrosse"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=wlax"];
    } else if([rowData[@"Name"]  isEqual: @"Women's Swim + Dive"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=wswim"];
        check = true;

    } else if([rowData[@"Name"]  isEqual: @"Women's Cross Country"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=wcross"];
        check = true;

    } else if([rowData[@"Name"]  isEqual: @"Women's Track + Field"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=tf"];
        check = true;

    } else if([rowData[@"Name"]  isEqual: @"Women's Volleyball"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=wvball"];
    } else if([rowData[@"Name"]  isEqual: @"Men's Baseball"]){
        url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=baseball"];
    }

    
    [tv reloadData];

//        NSURL *url = [NSURL URLWithString:@"http://www.jmusports.com/roster.aspx?path=football"];
        //        NSURL *url = [NSURL URLWithString:@"http://www.prettygoodsports.com"];
    if(!check){
        NSString *webdata = [NSString stringWithContentsOfURL:url];
        //        NSString *html = [url absoluteString];
        
        NSMutableArray *fballroster = [NSMutableArray new];
        NSArray *body = [webdata componentsSeparatedByString:@"default_dgrd_header roster_dgrd_header"];
        
        NSArray *numsplit = [body[1] componentsSeparatedByString:@"roster_dgrd_no"];
        for (int i = 1; i < numsplit.count; i++) {
            NSString *num = @"";
            NSString *name = @"";
            
            NSString *player = [[numsplit[i] stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceAndNewlineCharacterSet]] substringFromIndex:2];
            NSArray *opp1 = [player componentsSeparatedByString:@">"];
            
            
            name = [NSString stringWithFormat:@"%@ %@",  [[opp1[3] substringToIndex:[opp1[3] length] - 2] stringByTrimmingCharactersInSet:
                                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]], [[opp1[5] substringToIndex:[opp1[5] length] - 3] stringByTrimmingCharactersInSet:
                                                                                                               [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            
            
            num = [player substringToIndex:2];
//            NSLog(@"%@", num);
            [roster addObject:@{@"name": name, @"num": num}];
            

        }
    }
    else{
        NSString *webdata = [NSString stringWithContentsOfURL:url];
        //        NSString *html = [url absoluteString];
        
        NSMutableArray *fballroster = [NSMutableArray new];
        NSArray *body = [webdata componentsSeparatedByString:@"default_dgrd_header roster_dgrd_header"];
        
        NSArray *numsplit = [body[1] componentsSeparatedByString:@"roster_dgrd_full_name"];
        for (int i = 1; i < numsplit.count; i++) {
            NSString *num = @"";
            NSString *name = @"";
            
            NSString *player = [[numsplit[i] stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceAndNewlineCharacterSet]] substringFromIndex:2];
            NSArray *opp1 = [player componentsSeparatedByString:@">"];
            
//            NSLog(@"%@", opp1[1]);
            name = [NSString stringWithFormat:@"%@ %@",  [[opp1[1] substringToIndex:[opp1[1] length] - 2] stringByTrimmingCharactersInSet:
                                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]], [[opp1[3] substringToIndex:[opp1[3] length] - 3] stringByTrimmingCharactersInSet:
                                                                                                               [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            
            
            
            //            NSLog(@"%@", num);
            [roster addObject:@{@"name": name}];
    }
    }
    
        
    
    
    //    schedindex = 0;
    


}

-(void) viewDidAppear:(BOOL)animated{
    [tv reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger) supportedInterfaceOrientations {
    // Return a bitmask of supported orientations. If you need more,
    // use bitwise or (see the commented return).
    return UIInterfaceOrientationMaskPortrait;
    // return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    // Return the orientation you'd prefer - this is what it launches to. The
    // user can still rotate. You don't have to implement this method, in which
    // case it launches in the current orientation
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"====== %lu",(unsigned long)[roster count]);
    return [roster count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    NSDictionary *rowData = self.people[index];
    
    
    
    
    CGRect rowrect = CGRectMake(25, 25, 500, 30);
    UILabel* row = [[UILabel alloc] initWithFrame:rowrect];
    if(!check){
    row.text = [NSString stringWithFormat:@"#%@     %@", roster[indexPath.row][@"num"],roster[indexPath.row][@"name"]];
    }
    else{
        row.text = [NSString stringWithFormat:@"\t%@", roster[indexPath.row][@"name"]];
    }

    row.font = [UIFont systemFontOfSize:20];
    [cell.contentView addSubview:row];
    
    
    return cell;
}







-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"maintosecond"]) {
//        NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
        SecondViewController *destViewController = segue.destinationViewController;
        destViewController.people = _people;
        destViewController.index = index;
//    }
}

@end
