//
//  SecondViewController.m
//  JMU Sports
//
//  Created by Austin Vershel on 9/11/16.
//  Copyright © 2016 Austin Vershel. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation SecondViewController


static NSString *CellIdentifier = @"CellTableIdentifier";
@synthesize av,defaults, tv, title, index, nav, titlebar, schedindex,fball;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *rowData = self.people[index];
    titlebar.title = rowData[@"Name"];
    fball = rowData[@"Schedule"];

    
    
    int i = 0;
    bool check = false;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSLog(@"%lu", (unsigned long)fball.count);
    NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *newDate = [myFormatter stringFromDate:date];
    date = [myFormatter dateFromString:newDate];
//    NSLog(@"%@", fball[i][@"Date"]);

    while (i < [fball count]){
        NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
        [myFormatter setDateFormat:@"MM/dd/yyyy"];
        NSDate* myDate = [myFormatter dateFromString:fball[i][@"Date"]];
                NSLog(@"%@", fball[i][@"Date"]);
//        mydate.
        if([myDate compare: date] == NSOrderedDescending) // if start is later in time than end
        {
            check = true;
            schedindex = i;

            break;
        }
        schedindex++;
        i++;
        
        
    }
    
    if(!check){
        schedindex--;
    }
    
//    schedindex = 0;
    
    av = [[UIAlertView alloc]initWithTitle:@"Enter your Friends Name!" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    tv.dataSource = self;
    tv.delegate = self;
    tv.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    [tv reloadData];
    //[tableView registerClass:[CustomCell class] forCellReuseIdentifier:CellIdentifier];
    
   //    NSString *player = [[numsplit[1] stringByTrimmingCharactersInSet:
//                        [NSCharacterSet whitespaceAndNewlineCharacterSet]] substringFromIndex:2];
//    NSLog(@"======= %@", [ player substringToIndex:1]);

    
}

-(void) viewDidAppear:(BOOL)animated{
    [tv reloadData];
                    [self.tv selectRowAtIndexPath:[NSIndexPath indexPathForRow:schedindex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
       [self.tv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:schedindex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

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
        NSLog(@"%lu",[fball count]);
//    return [self.people[index][@"Schedule"] count];
    return fball.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];

    NSDictionary *rowData = self.people[index];
    

    
    
    CGRect rowrect = CGRectMake(25, 25, 500, 30);
    UILabel* row = [[UILabel alloc] initWithFrame:rowrect];

        row.text = [NSString stringWithFormat:@"%@ %@", fball[indexPath.row][@"Date"],fball[indexPath.row][@"Name"]];
    row.font = [UIFont systemFontOfSize:20];
    [cell.contentView addSubview:row];
    
    
    return cell;
}



- (IBAction)rosterclicked:(id)sender {
          [self performSegueWithIdentifier:@"secondtothird" sender:self];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tv selectRowAtIndexPath:[NSIndexPath indexPathForRow:schedindex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
//    NSIndexPath *offsetIndexPath = [NSIndexPath indexPathWithIndex:(NSInteger)schedindex];
 
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"secondtothird"]) {
        NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
        ThirdViewController *destViewController = segue.destinationViewController;
        destViewController.people = self.people;
        destViewController.index = index;
    }
}

//- (NSDate*)getDateFromSched:(NSArray *)sched
//{
//    //CHECK FIRST DATE FROM HOME GAME & AWAY GAME
//    NSLog(@"%@", sched);
//    NSArray *mo = [sched[0][@"Date"] componentsSeparatedByString:@" "];
//    //    NSString *firstmonth = mo[1];
//    
//    int firstmonth = 99;
//    
//    
//    for (int i = 0; i < sched.count; i++) {
//        if([sched[i][@"Name"] rangeOfString:@"vs."].location == NSNotFound){
//            if([mo[0]  isEqual: @"Jan"]){
//                firstmonth = 1;
//            } else if([mo[0]  isEqual: @"Feb"]){
//                firstmonth = 2;
//            }
//            else if([mo[0]  isEqual: @"Mar"]){
//                firstmonth = 3;
//            }
//            else if([mo[0]  isEqual: @"Apr"]){
//                firstmonth = 4;
//            }
//            else if([mo[0]  isEqual: @"May"]){
//                firstmonth = 5;
//            }
//            else if([mo[0]  isEqual: @"Jun"]){
//                firstmonth = 6;
//            }
//            else if([mo[0]  isEqual: @"Jul"]){
//                firstmonth = 7;
//            }
//            else if([mo[0]  isEqual: @"Aug"]){
//                firstmonth = 8;
//            }
//            else if([mo[0]  isEqual: @"Sep"]){
//                firstmonth = 9;
//            }
//            else if([mo[0]  isEqual: @"Oct"]){
//                firstmonth = 10;
//            }
//            else if([mo[0]  isEqual: @"Nov"]){
//                firstmonth = 11;
//            }
//            else if([mo[0]  isEqual: @"Dec"]){
//                firstmonth = 12;
//            }
//        }
//    }
//    
//    
//    for (int i = 0; i < sched.count; i++) {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy"];
//        NSString *yearString = [formatter stringFromDate:[NSDate date]];
//        int year = [yearString intValue];
//        
//        NSArray *mo = [sched[i][@"Date"] componentsSeparatedByString:@" "];
//        NSString *day = mo[1];
//        int moval = 0;
//        if([mo[0]  isEqual: @"Jan"]){
//            moval = 1;
//        } else if([mo[0]  isEqual: @"Feb"]){
//            moval = 2;
//        }
//        else if([mo[0]  isEqual: @"Mar"]){
//            moval = 3;
//        }
//        else if([mo[0]  isEqual: @"Apr"]){
//            moval = 4;
//        }
//        else if([mo[0]  isEqual: @"May"]){
//            moval = 5;
//        }
//        else if([mo[0]  isEqual: @"Jun"]){
//            moval = 6;
//        }
//        else if([mo[0]  isEqual: @"Jul"]){
//            moval = 7;
//        }
//        else if([mo[0]  isEqual: @"Aug"]){
//            moval = 8;
//        }
//        else if([mo[0]  isEqual: @"Sep"]){
//            moval = 9;
//        }
//        else if([mo[0]  isEqual: @"Oct"]){
//            moval = 10;
//        }
//        else if([mo[0]  isEqual: @"Nov"]){
//            moval = 11;
//        }
//        else if([mo[0]  isEqual: @"Dec"]){
//            moval = 12;
//        }
//        
//        if (moval < firstmonth)
//        {
//            
//            year += 1;
//        }
//        
//        NSLog(@"%@ %@ %@", day, mo[0], [NSString stringWithFormat:@"%i", year]);
//        
//        
//    }
//    
//    return [NSDate new];
//}

@end
