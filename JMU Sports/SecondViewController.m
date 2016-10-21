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
    fball = [NSMutableArray new];

    
    
//    for(int i = 0; i<_people.count; i++){
        NSURL *url;
        bool check = false;
    NSLog(@"%@",rowData[@"Name"]);
        if([rowData[@"Name"]  isEqual: @"Men's Football"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=football"];
        } else if([rowData[@"Name"]  isEqual: @"Men's Basketball"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=mbball"];
        } else if([rowData[@"Name"]  isEqual: @"Women's Basketball"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wbball"];
        } else if([rowData[@"Name"]  isEqual: @"Men's Soccer"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=msoc"];
        } else if([rowData[@"Name"]  isEqual: @"Women's Soccer"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wsoc"];
        } else if([rowData[@"Name"]  isEqual: @"Men's Golf"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=mgolf"];
            check = true;
        } else if([rowData[@"Name"]  isEqual: @"Women's Golf"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wgolf"];
            check = true;
            
        } else if([rowData[@"Name"]  isEqual: @"Men's Tennis"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=mten"];
            check = true;
            
        } else if([rowData[@"Name"]  isEqual: @"Women's Tennis"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wten"];
            check = true;
            
        } else if([rowData[@"Name"]  isEqual: @"Women's Field Hockey"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=fhockey"];
        } else if([rowData[@"Name"]  isEqual: @"Women's Softball"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=softball"];
        } else if([rowData[@"Name"]  isEqual: @"Women's Lacrosse"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wlax"];
        } else if([rowData[@"Name"]  isEqual: @"Women's Swim + Dive"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wswim"];
            check = true;
            
        } else if([rowData[@"Name"]  isEqual: @"Women's Cross Country"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wcross"];
            check = true;
            
        } else if([rowData[@"Name"]  isEqual: @"Women's Track + Field"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=tf"];
            check = true;
            
        } else if([rowData[@"Name"]  isEqual: @"Women's Volleyball"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wvball"];
        } else if([rowData[@"Name"]  isEqual: @"Men's Baseball"]){
            url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=baseball"];
        }
        NSString *webdata = [NSString stringWithContentsOfURL:url];
        //        NSString *html = [url absoluteString];
        
        NSArray *body = [webdata componentsSeparatedByString:@"schedule_game schedule_game_"];
                NSLog(@"%@",body);
        //getdate
        for(int i = 1; i < body.count; i++){
            
            NSArray *datesplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_date"];
            NSString *dateStr = [datesplit[1] substringFromIndex:2];
            NSArray *date1 = [dateStr componentsSeparatedByString:@"</div>"];
            //            NSLog(@"%@", date1[0]);
            NSArray *datewithday = [date1[0] componentsSeparatedByString:@","];
            NSString *date =  [datewithday[1] stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([date rangeOfString:@"-"].location == NSNotFound) {
                //                    NSLog(@"string does not contain bla");
            } else {
                NSLog(@"string contains bla!");
                date = [date substringToIndex:date.length - 5];
            }
            //getopponent
            NSArray *oppsplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_name"];
            NSString *oppStr = [oppsplit[1] substringFromIndex:2];
            NSArray *opp1 = [oppStr componentsSeparatedByString:@">"];
            NSArray *opp2 = [opp1[2] componentsSeparatedByString:@"<"];
            NSString *opp =  [opp2[0] stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            
            
            //
            //            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            //            [dateFormat setDateFormat:@"EE, LLL d"];
            //            NSDate *converteddate = [dateFormat dateFromString:date];
            //            NSLog(@"%@", converteddate);
            if ([opp  isEqual: @""]){
                
                NSArray *datesplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_date"];
                NSString *dateStr = [datesplit[1] substringFromIndex:2];
                NSArray *date1 = [dateStr componentsSeparatedByString:@"</div>"];
                NSArray *datewithday = [date1[0] componentsSeparatedByString:@","];
                NSString *date =  [datewithday[1] stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                if ([date rangeOfString:@"-"].location == NSNotFound) {
//                    NSLog(@"string does not contain bla");
                } else {
                    NSLog(@"string contains bla!");
                    date = [date substringToIndex:date.length - 5];
                }
                
                //getopponent
                NSArray *oppsplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_name"];
                NSString *oppStr = [oppsplit[1] substringFromIndex:2];
                //        NSLog(@"%@", oppStr);
                NSArray *opp1 = [oppStr componentsSeparatedByString:@">"];
                
                NSArray *opp2 = [opp1[1] componentsSeparatedByString:@"<"];
                NSString *opp =  [opp2[0] stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                opp = [NSString stringWithFormat:@"@ %@", opp];
                //        NSLog(@"%@ %@",date, opp);
                
                [fball addObject:@{@"Name": opp, @"Date": date}];
                
                
                

            }else{
            opp = [NSString stringWithFormat:@"vs. %@", opp];
            NSLog(@"!!!!!%@ %@",date, opp);
            [fball addObject:@{@"Name": opp, @"Date": date}];
            }
            
        }
//        body = [webdata componentsSeparatedByString:@"schedule_game schedule_game_away"];
//        //        NSLog(@"%@",bodystring);
//        //getdate
//        for(int i = 1; i < body.count; i++){
//            NSArray *datesplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_date"];
//            NSString *dateStr = [datesplit[1] substringFromIndex:2];
//            NSArray *date1 = [dateStr componentsSeparatedByString:@"</div>"];
//            NSArray *datewithday = [date1[0] componentsSeparatedByString:@","];
//            NSString *date =  [datewithday[1] stringByTrimmingCharactersInSet:
//                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            
//            //getopponent
//            NSArray *oppsplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_name"];
//            NSString *oppStr = [oppsplit[1] substringFromIndex:2];
//            //        NSLog(@"%@", oppStr);
//            NSArray *opp1 = [oppStr componentsSeparatedByString:@">"];
//            
//            NSArray *opp2 = [opp1[1] componentsSeparatedByString:@"<"];
//            NSString *opp =  [opp2[0] stringByTrimmingCharactersInSet:
//                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            
//            opp = [NSString stringWithFormat:@"!!!!!!@ %@", opp];
//            //        NSLog(@"%@ %@",date, opp);
//            
//            [fball addObject:@{@"Name": opp, @"Date": date}];
//            
//        }
    
//        NSLog(@"%lu", fball.count);
    
//    }

    
    
    
    int i = 0;
     check = false;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSLog(@"%lu", (unsigned long)fball.count);
    NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"MM dd"];
    NSString *newDate = [myFormatter stringFromDate:date];
    date = [myFormatter dateFromString:newDate];
//    NSLog(@"%@", fball[i][@"Date"]);

    while (i < [fball count]){
        NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
        [myFormatter setDateFormat:@"MM dd"];
        NSDate* myDate = [myFormatter dateFromString:fball[i][@"Date"]];
                NSLog(@"%@", fball[i][@"Date"]);
//        mydate.
        if([myDate compare: date] == NSOrderedDescending) // if start is later in time than end
        {
            check = true;
            schedindex = i;

            break;
        }
        i++;
        
        
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
