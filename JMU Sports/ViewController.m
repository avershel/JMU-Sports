//
//  ViewController.m
//  FriendPoints
//
//  Created by Austin Vershel on 3/23/15.
//  Copyright (c) 2015 Austin Vershel. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

static NSString *CellIdentifier = @"CellTableIdentifier";
@synthesize av,defaults, tv;

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    if (!_people) {
//        
//       NSURL *url = [NSURL URLWithString:@"http://www.prettygoodsports.com/api.php"];
//    
//    NSString *webdata = [NSString stringWithContentsOfURL:url];
//        NSLog(@"%@", webdata);
        
        
        //Create emptyArray of Sports, Schedules, Rostres
        _people = [NSMutableArray new];
        
        //Load static data into array
        [self getStaticSched];
        
        //Set array
        [defaults setObject:_people forKey:@"myArray"];
        
        
        //Delete this boolean and if conditional
        bool dontdoit = false;
        if(dontdoit){
            for(int i = 0; i<_people.count; i++){
                NSURL *url;
                bool check = false;
                if (i == 0) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=football"];
                } else if (i == 1) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=mbball"];
                    
                } else if (i == 2) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wbball"];
                    
                } else if (i == 3) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=msoccer"];
                    
                } else if (i == 4) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wsoccer"];
                    
                } else if (i == 5) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=mgolf"];
                    check = true;
                } else if (i == 6) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wgolf"];
                    check = true;
                    
                } else if (i == 7) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=mtennis"];
                    
                } else if (i == 8) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wtennis"];
                    
                } else if (i == 9) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=fhockey"];
                    
                } else if (i == 10) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=baseball"];
                    
                } else if (i == 11) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=softball"];
                    
                } else if (i == 12) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wlax"];
                    
                } else if (i == 13) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wswim"];
                    
                } else if (i == 14) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=wcross"];
                    
                } else if (i == 15) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=tf"];
                    
                } else if (i == 16) {
                    url = [NSURL URLWithString:@"http://www.jmusports.com/schedule.aspx?path=vball"];
                    
                }
                
                NSString *webdata = [NSString stringWithContentsOfURL:url];
                NSMutableArray *fball = [NSMutableArray new];
                
                //Split HTML by Home Games
                NSArray *body = [webdata componentsSeparatedByString:@"schedule_game schedule_game_home"];
                for(int i = 1; i < body.count; i++){
                    
                    //Get rid of Away Games... They will be added in the next loop
                    NSArray *datesplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_date"];
                    
                    //Get Date
                    NSString *dateStr = [datesplit[1] substringFromIndex:2];
                    NSArray *date1 = [dateStr componentsSeparatedByString:@"</div>"];
                    NSArray *datewithday = [date1[0] componentsSeparatedByString:@","];
                    NSString *date =  [datewithday[1] stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    
                    //Get Opponent
                    NSArray *oppsplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_name"];
                    NSString *oppStr = [oppsplit[1] substringFromIndex:2];
                    NSArray *opp1 = [oppStr componentsSeparatedByString:@">"];
                    NSArray *opp2 = [opp1[2] componentsSeparatedByString:@"<"];
                    NSString *opp =  [opp2[0] stringByTrimmingCharactersInSet:
                                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    opp = [NSString stringWithFormat:@"vs. %@", opp];
                    NSLog(@"%@ %@",date, opp);
                    
                    //Add to Arr
                    [fball addObject:@{@"Name": opp, @"Date": date}];
                    
                    
                }
                //Split HTML by Away Games
                body = [webdata componentsSeparatedByString:@"schedule_game schedule_game_away"];
                
                
                for(int i = 1; i < body.count; i++){
                    NSArray *datesplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_date"];
                    
                    //Get Date
                    NSString *dateStr = [datesplit[1] substringFromIndex:2];
                    NSArray *date1 = [dateStr componentsSeparatedByString:@"</div>"];
                    NSArray *datewithday = [date1[0] componentsSeparatedByString:@","];
                    NSString *date =  [datewithday[1] stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    
                    //Get Opponent
                    NSArray *oppsplit = [body[i] componentsSeparatedByString:@"schedule_game_opponent_name"];
                    NSString *oppStr = [oppsplit[1] substringFromIndex:2];
                    //        NSLog(@"%@", oppStr);
                    NSArray *opp1 = [oppStr componentsSeparatedByString:@">"];
                    
                    NSArray *opp2 = [opp1[1] componentsSeparatedByString:@"<"];
                    NSString *opp =  [opp2[0] stringByTrimmingCharactersInSet:
                                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    
                    opp = [NSString stringWithFormat:@"@ %@", opp];
                    //        NSLog(@"%@ %@",date, opp);
                    
                    //Add to Arr
                    [fball addObject:@{@"Name": opp, @"Date": date}];
                    
                }
                
                
            }
            
            
        }
        
        
        
        
        
        //stops here

        
    }

    tv.dataSource = self;
    tv.delegate = self;
    tv.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    [tv reloadData];
    //[tableView registerClass:[CustomCell class] forCellReuseIdentifier:CellIdentifier];
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
    //    NSLog(@"%lu",(unsigned long)[self.people count]);
    return [self.people count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    NSDictionary *rowData = self.people[indexPath.row];
    
    NSMutableArray *sched = rowData[@"Schedule"];
    
    
    

        
        CGRect colorRectangle = CGRectMake(0, 1, [UIScreen mainScreen].bounds.size.width, 45);
        UILabel* _colorRectangle = [[UILabel alloc] initWithFrame:colorRectangle];
        //    _colorRectangle.text = rowData[@"Name"];
        _colorRectangle.font = [UIFont systemFontOfSize:20];
        _colorRectangle.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:228/255.0f blue:194.0f/255.0f
                                                          alpha:1.0f];;
        [cell.contentView addSubview:_colorRectangle];
        
        
        CGRect nameValueRectangle = CGRectMake(20, 10, 250, 30);
        UILabel* _nameValue = [[UILabel alloc] initWithFrame:nameValueRectangle];
        _nameValue.text = rowData[@"Name"];
        _nameValue.font = [UIFont systemFontOfSize:20];
        //    _nameValue.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:228/255.0f blue:194.0f/255.0f
        //                                                                                 alpha:1.0f];;
        [cell.contentView addSubview:_nameValue];
        
        
        
        CGRect nextarrow = CGRectMake(340, 10, 20, 30);
        UILabel* _nextValue = [[UILabel alloc] initWithFrame:nextarrow];
        _nextValue.text = @">";
        _nextValue.font = [UIFont systemFontOfSize:20];
        [cell.contentView addSubview:_nextValue];
        int schedcounter = 0;
        while (schedcounter < 3) {
            if(schedcounter == 0){
        int i = 0;
        bool check = false;
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
        
        while (i < [rowData[@"Schedule"] count]){
            NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
            [myFormatter setDateFormat:@"MM/dd/yyyy"];
            NSDate* myDate = [myFormatter dateFromString:rowData[@"Schedule"][i][@"Date"]];
            //        NSLog(@"%@", myDate);
            if([myDate compare: date] == NSOrderedDescending) // if start is later in time than end
            {
                // do something
                check = true;
                break;
            }
            i++;
        }
//                check = true;
        
        CGRect rowrect = CGRectMake(25, 55, 500, 30);
        UILabel* row = [[UILabel alloc] initWithFrame:rowrect];
        //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
        if (!check){
//            row.text = @"Not in Season.";
//            row.text = @"1/1";
            
            
            
            
            
            
            
            
 
                
                CGRect rowrect = CGRectMake(25, 55, 500, 30);
                
                UILabel* row = [[UILabel alloc] initWithFrame:rowrect];
                //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
                
                
                //POSSIBLE THREAT
                //                       NSString *testString= [NSString stringWithFormat:@"%@", rowData[@"Schedule"][i][@"Date"]];
                //                       NSArray *dsplitarray = [testString componentsSeparatedByString:@"/"];
                row.text = [NSString stringWithFormat:@""];
                
                row.font = [UIFont systemFontOfSize:20];
                [cell.contentView addSubview:row];
                
                
                
                
                
                CGRect rowrect2 = CGRectMake(18, 55, 180, 60);
                UILabel* row2 = [[UILabel alloc] initWithFrame:rowrect2];
                //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
                
                
                //                       if(dsplitarray.count > 2){
                //                           row2.numberOfLines = 0;
                row2.text = [NSString stringWithFormat:@"\tNot"];
                //                       }
                
                row2.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:row2];
                
                
                
            
            
            
            
            
            
            
            
        }
        else{
            
            //POSSIBLE THREAT
            NSString *testString= [NSString stringWithFormat:@"%@", rowData[@"Schedule"][i][@"Date"]];
            NSArray *dsplitarray = [testString componentsSeparatedByString:@"/"];
            row.text = [NSString stringWithFormat:@"%@/%@", dsplitarray[0],dsplitarray[1]];
        }
        row.font = [UIFont systemFontOfSize:20];
        [cell.contentView addSubview:row];
        
            
        
        
        
        CGRect rowrect2 = CGRectMake(18, 75, 180, 60);
        UILabel* row2 = [[UILabel alloc] initWithFrame:rowrect2];
        //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
        if (!check){
            //            row.text = @"Not in Season.";
            row2.text = @"App. State";
        }
        else{
            NSString *teamstr =rowData[@"Schedule"][i][@"Name"];
            NSArray *dsplitarray = [teamstr componentsSeparatedByString:@" "];
            if(dsplitarray.count > 3){
                NSLog(@"%@", dsplitarray[0]);
                row2.numberOfLines = 0;
                row2.text = [NSString stringWithFormat:@"%@ %@\n     %@ ...", dsplitarray[0], dsplitarray[1], dsplitarray[2]];
            }
            else if(dsplitarray.count == 3){
                NSLog(@"%@", dsplitarray[0]);
                row2.numberOfLines = 0;
                row2.text = [NSString stringWithFormat:@"%@ %@\n     %@", dsplitarray[0], dsplitarray[1], dsplitarray[2]];
            }
            else if(dsplitarray.count == 2){
                row2.numberOfLines = 0;
                row2.text = [NSString stringWithFormat:@"%@ %@", dsplitarray[0], dsplitarray[1]];
            }
            else{
                NSString *teamstr =rowData[@"Schedule"][i][@"Name"];
                NSArray *dsplitarray = [teamstr componentsSeparatedByString:@" "];
                //                       if(dsplitarray.count > 2){
                //                           row2.numberOfLines = 0;
                row2.text = [NSString stringWithFormat:@"%@", rowData[@"Schedule"][i][@"Name"]];
                //                       }
            }
        row2.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:row2];
        }
        
        
        CGRect blocker = CGRectMake(125, 60, 0.5, 60);
        UILabel* blocklab1 = [[UILabel alloc] initWithFrame:blocker];
        blocklab1.text = @"";
        blocklab1.font = [UIFont systemFontOfSize:20];
        blocklab1.backgroundColor = [UIColor purpleColor];
        [cell.contentView addSubview:blocklab1];
            }
            
           else if(schedcounter == 1){
                int i = 0;
                bool check = false;
                NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
                
                while (i < [rowData[@"Schedule"] count]){
                    NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
                    [myFormatter setDateFormat:@"MM/dd/yyyy"];
                    NSDate* myDate = [myFormatter dateFromString:rowData[@"Schedule"][i][@"Date"]];
                    //        NSLog(@"%@", myDate);
                    if([myDate compare: date] == NSOrderedDescending) // if start is later in time than end
                    {
                        // do something
                        check = true;
                        break;
                    }
                    i++;
                }
    
               if(i+ 1 >= [rowData[@"Schedule"] count]){
                   
                   CGRect rowrect = CGRectMake(145, 55, 500, 30);

                   UILabel* row = [[UILabel alloc] initWithFrame:rowrect];
                   //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);

                       
                       //POSSIBLE THREAT
//                       NSString *testString= [NSString stringWithFormat:@"%@", rowData[@"Schedule"][i][@"Date"]];
//                       NSArray *dsplitarray = [testString componentsSeparatedByString:@"/"];
                       row.text = [NSString stringWithFormat:@""];
                   
                   row.font = [UIFont systemFontOfSize:20];
                   [cell.contentView addSubview:row];
                   
                   
                   
                   
                   
                   CGRect rowrect2 = CGRectMake(148, 55, 180, 60);
                   UILabel* row2 = [[UILabel alloc] initWithFrame:rowrect2];
                   //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);

                
                           //                       if(dsplitarray.count > 2){
                           //                           row2.numberOfLines = 0;
                   row2.text = [NSString stringWithFormat:@"\tIn"];
                           //                       }
                   
                       row2.font = [UIFont systemFontOfSize:15];
                       [cell.contentView addSubview:row2];
                   

                   
                   
               }
               else{
               i+= 1;
                CGRect rowrect = CGRectMake(145, 55, 500, 30);
                UILabel* row = [[UILabel alloc] initWithFrame:rowrect];
                //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
                if (!check){
                    //            row.text = @"Not in Season.";
                    row.text = @"1/1";
                }
                else{
                    
                    //POSSIBLE THREAT
                    NSString *testString= [NSString stringWithFormat:@"%@", rowData[@"Schedule"][i][@"Date"]];
                    NSArray *dsplitarray = [testString componentsSeparatedByString:@"/"];
                    row.text = [NSString stringWithFormat:@"%@/%@", dsplitarray[0],dsplitarray[1]];
                }
                row.font = [UIFont systemFontOfSize:20];
                [cell.contentView addSubview:row];
                
               
               
                
                
                CGRect rowrect2 = CGRectMake(133, 75, 180, 60);
                UILabel* row2 = [[UILabel alloc] initWithFrame:rowrect2];
                //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
               if (!check){
                   //            row.text = @"Not in Season.";
                   row2.text = @"App. State";
               }
               else{
                   NSString *teamstr =rowData[@"Schedule"][i][@"Name"];
                   NSArray *dsplitarray = [teamstr componentsSeparatedByString:@" "];
                   if(dsplitarray.count > 3){
                       NSLog(@"%@", dsplitarray[0]);
                       row2.numberOfLines = 0;
                       row2.text = [NSString stringWithFormat:@"%@ %@\n     %@ ...", dsplitarray[0], dsplitarray[1], dsplitarray[2]];
                   }
                   else if(dsplitarray.count == 3){
                       NSLog(@"%@", dsplitarray[0]);
                       row2.numberOfLines = 0;
                       row2.text = [NSString stringWithFormat:@"%@ %@\n     %@", dsplitarray[0], dsplitarray[1], dsplitarray[2]];
                   }
                   else if(dsplitarray.count == 2){
                       row2.numberOfLines = 0;
                       row2.text = [NSString stringWithFormat:@"%@ %@", dsplitarray[0], dsplitarray[1]];
                   }
                   else{
                       NSString *teamstr =rowData[@"Schedule"][i][@"Name"];
                       NSArray *dsplitarray = [teamstr componentsSeparatedByString:@" "];
                       //                       if(dsplitarray.count > 2){
                       //                           row2.numberOfLines = 0;
                       row2.text = [NSString stringWithFormat:@"%@", rowData[@"Schedule"][i][@"Name"]];
                       //                       }
                   }
                   row2.font = [UIFont systemFontOfSize:15];
                   [cell.contentView addSubview:row2];
               }
                   
               }
               
                CGRect blocker = CGRectMake(250, 60, 0.5, 60);
                UILabel* blocklab1 = [[UILabel alloc] initWithFrame:blocker];
                blocklab1.text = @"";
                blocklab1.font = [UIFont systemFontOfSize:20];
                blocklab1.backgroundColor = [UIColor purpleColor];
                [cell.contentView addSubview:blocklab1];
            }

            
            
           else if(schedcounter == 2){
               int i = 0;
               bool check = false;
               NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
               
               while (i < [rowData[@"Schedule"] count]){
                   NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
                   [myFormatter setDateFormat:@"MM/dd/yyyy"];
                   NSDate* myDate = [myFormatter dateFromString:rowData[@"Schedule"][i][@"Date"]];
                   //        NSLog(@"%@", myDate);
                   if([myDate compare: date] == NSOrderedDescending) // if start is later in time than end
                   {
                       // do something
                       check = true;
                       break;
                   }
                   i++;
               }
               if(i+ 2 >= [rowData[@"Schedule"] count]){
                   
                   CGRect rowrect = CGRectMake(270, 55, 500, 30);
                   
                   UILabel* row = [[UILabel alloc] initWithFrame:rowrect];
                   //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
                   
                   
                   //POSSIBLE THREAT
                   //                       NSString *testString= [NSString stringWithFormat:@"%@", rowData[@"Schedule"][i][@"Date"]];
                   //                       NSArray *dsplitarray = [testString componentsSeparatedByString:@"/"];
                   row.text = [NSString stringWithFormat:@""];
                   
                   row.font = [UIFont systemFontOfSize:20];
                   [cell.contentView addSubview:row];
                   
                   
                   
                   
                   
                   CGRect rowrect2 = CGRectMake(262, 55, 180, 60);
                   UILabel* row2 = [[UILabel alloc] initWithFrame:rowrect2];
                   //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
                   
                   
                   //                       if(dsplitarray.count > 2){
                   //                           row2.numberOfLines = 0;
                   row2.text = [NSString stringWithFormat:@"\tSeason"];
                   //                       }
                   
                   row2.font = [UIFont systemFontOfSize:15];
                   [cell.contentView addSubview:row2];
                   
                   
                   
                   
               }
               else{

               i += 2;
               CGRect rowrect = CGRectMake(270, 55, 500, 30);
               UILabel* row = [[UILabel alloc] initWithFrame:rowrect];
               //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
               if (!check){
                   //            row.text = @"Not in Season.";
                   row.text = @"1/1";
               }
               else{
                   
                   //POSSIBLE THREAT
                   NSString *testString= [NSString stringWithFormat:@"%@", rowData[@"Schedule"][i][@"Date"]];
                   NSArray *dsplitarray = [testString componentsSeparatedByString:@"/"];
                   row.text = [NSString stringWithFormat:@"%@/%@", dsplitarray[0],dsplitarray[1]];
               }
               row.font = [UIFont systemFontOfSize:20];
               [cell.contentView addSubview:row];
               
               
               
               
               
               CGRect rowrect2 = CGRectMake(262, 75, 180, 60);
               UILabel* row2 = [[UILabel alloc] initWithFrame:rowrect2];
               //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
               if (!check){
                   //            row.text = @"Not in Season.";
                   row2.text = @"App. State";
               }
               else{
                   NSString *teamstr =rowData[@"Schedule"][i][@"Name"];
                   NSArray *dsplitarray = [teamstr componentsSeparatedByString:@" "];
                   if(dsplitarray.count > 3){
                       NSLog(@"%@", dsplitarray[0]);
                       row2.numberOfLines = 0;
                       row2.text = [NSString stringWithFormat:@"%@ %@\n     %@ ...", dsplitarray[0], dsplitarray[1], dsplitarray[2]];
                   }
                   else if(dsplitarray.count == 3){
                       NSLog(@"%@", dsplitarray[0]);
                       row2.numberOfLines = 0;
                       row2.text = [NSString stringWithFormat:@"%@ %@\n     %@", dsplitarray[0], dsplitarray[1], dsplitarray[2]];
                   }
                   else if(dsplitarray.count == 2){
                       row2.numberOfLines = 0;
                       row2.text = [NSString stringWithFormat:@"%@ %@", dsplitarray[0], dsplitarray[1]];
                   }
                   else{
                       NSString *teamstr =rowData[@"Schedule"][i][@"Name"];
                       NSArray *dsplitarray = [teamstr componentsSeparatedByString:@" "];
//                       if(dsplitarray.count > 2){
//                           row2.numberOfLines = 0;
                           row2.text = [NSString stringWithFormat:@"%@", rowData[@"Schedule"][i][@"Name"]];
//                       }
                   }
                   row2.font = [UIFont systemFontOfSize:15];
                   [cell.contentView addSubview:row2];
               }
               }
               
               
//               CGRect blocker = CGRectMake(370, 46, 2, 85);
//               UILabel* blocklab1 = [[UILabel alloc] initWithFrame:blocker];
//               blocklab1.text = @"";
//               blocklab1.font = [UIFont systemFontOfSize:20];
//               blocklab1.backgroundColor = [UIColor blackColor];
//               [cell.contentView addSubview:blocklab1];
           }
            
            
            
            schedcounter = schedcounter + 1;
            
        }
        return cell;
        
        

    
//    else{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
//
//    NSDictionary *rowData = self.people[indexPath.row];
//    
//    CGRect colorRectangle = CGRectMake(0, 1, [UIScreen mainScreen].bounds.size.width, 45);
//    UILabel* _colorRectangle = [[UILabel alloc] initWithFrame:colorRectangle];
//    //    _colorRectangle.text = rowData[@"Name"];
//    _colorRectangle.font = [UIFont systemFontOfSize:20];
//    _colorRectangle.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:228/255.0f blue:194.0f/255.0f
//                                                      alpha:1.0f];;
//    [cell.contentView addSubview:_colorRectangle];
//    
//    
//    CGRect nameValueRectangle = CGRectMake(20, 10, 250, 30);
//    UILabel* _nameValue = [[UILabel alloc] initWithFrame:nameValueRectangle];
//    _nameValue.text = rowData[@"Name"];
//    _nameValue.font = [UIFont systemFontOfSize:20];
//    //    _nameValue.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:228/255.0f blue:194.0f/255.0f
//    //                                                                                 alpha:1.0f];;
//    [cell.contentView addSubview:_nameValue];
//    
//    
//    
//    CGRect nextarrow = CGRectMake(340, 10, 20, 30);
//    UILabel* _nextValue = [[UILabel alloc] initWithFrame:nextarrow];
//    _nextValue.text = @">";
//    _nextValue.font = [UIFont systemFontOfSize:20];
//    [cell.contentView addSubview:_nextValue];
//    
//    
//    
//    int i = 0;
//    bool check = false;
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//    
//    while (i < [rowData[@"Schedule"] count]){
//        NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
//        [myFormatter setDateFormat:@"MM/dd/yyyy"];
//        NSDate* myDate = [myFormatter dateFromString:rowData[@"Schedule"][i][@"Date"]];
//        //        NSLog(@"%@", myDate);
//        if([myDate compare: date] == NSOrderedDescending) // if start is later in time than end
//        {
//            // do something
//            check = true;
//            break;
//        }
//        i++;
//    }
//    
//    
//    CGRect rowrect = CGRectMake(25, 65, 500, 30);
//    UILabel* row = [[UILabel alloc] initWithFrame:rowrect];
//    //    NSLog(@"%@",rowData[@"Schedule"][0][@"Name"]);
//    if (!check){
//        row.text = @"Not in Season.";
//    }
//    else{
//        row.text = [NSString stringWithFormat:@"%@ %@", rowData[@"Schedule"][i][@"Date"],rowData[@"Schedule"][i][@"Name"]];
//    }
//    row.font = [UIFont systemFontOfSize:20];
//    [cell.contentView addSubview:row];
//    
//    
//    
//    return cell;
//    
//    
//    }
}

- (void)getStaticSched
{
    
    NSURL *url = [NSURL URLWithString:@"http://www.prettygoodsports.com/api.php"];
    
    NSString *webdata = [NSString stringWithContentsOfURL:url];
    NSArray *rawExhibits = (NSArray *)[NSJSONSerialization JSONObjectWithData:[webdata dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];

    NSMutableArray *mFootball = [NSMutableArray new];
    NSMutableArray *mBasketball = [NSMutableArray new];
    NSMutableArray *wBasketball = [NSMutableArray new];
    NSMutableArray *mSoccer = [NSMutableArray new];
    NSMutableArray *wSoccer = [NSMutableArray new];
    NSMutableArray *mGolf = [NSMutableArray new];
    NSMutableArray *wGolf = [NSMutableArray new];
    NSMutableArray *mTennis = [NSMutableArray new];
    NSMutableArray *wTennis = [NSMutableArray new];
    NSMutableArray *wFockey = [NSMutableArray new];
    NSMutableArray *mBaseball = [NSMutableArray new];
    NSMutableArray *wSoftball = [NSMutableArray new];
    NSMutableArray *wLax = [NSMutableArray new];
    NSMutableArray *wCC = [NSMutableArray new];
    NSMutableArray *wSwim = [NSMutableArray new];
    NSMutableArray *wTrack = [NSMutableArray new];
    NSMutableArray *wVolleyball = [NSMutableArray new];

    for(int i = 0; i < rawExhibits.count; i++){
        if ([rawExhibits[i][@"Name"]  isEqual: @"football"]) {
            [mFootball addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];

        }
        else if ([rawExhibits[i][@"Name"]  isEqual: @"mbasketball"]) {
            [mBasketball addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wbasketball"]) {
            [wBasketball addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"msoccer"]) {
            [mSoccer addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wsoccer"]) {
            [wSoccer addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"mgolf"]) {
            [mGolf addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wgolf"]) {
            [wGolf addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"mtennis"]) {
            [mTennis addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wtennis"]) {
            [wTennis addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wfockey"]) {
            [wFockey addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"mbaseball"]) {
            [mBaseball addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wsoftball"]) {
            [wSoftball addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wlax"]) {
            [wLax addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wswim"]) {
            [wSwim addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wcc"]) {
            [wCC addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wtrack"]) {
            [wTrack addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }        else if ([rawExhibits[i][@"Name"]  isEqual: @"wvolleyball"]) {
            [wVolleyball addObject:@{@"Name": rawExhibits[i][@"Opp"], @"Date": rawExhibits[i][@"Date"]}];
            
        }

    }
    
    
//    NSMutableArray *mFootball = [NSMutableArray new];
    //        [sports addObject:mFootball];

    [_people addObject:@{@"Name": @"Men's Football",
                         @"Schedule": mFootball
                         }];
    
    
//    NSMutableArray *mBasketball = [NSMutableArray new];
    //        [sports addObject:mBasketball];
    
    [mBasketball addObject:@{@"Name": @"@ Old Dominion", @"Date": @"11/11/2016"}];
    [mBasketball addObject:@{@"Name": @"vs. Rice", @"Date": @"11/13/2016"}];
    [mBasketball addObject:@{@"Name": @"@ Montana St.", @"Date": @"11/18/2016"}];
    [mBasketball addObject:@{@"Name": @"vs Texas Southern", @"Date": @"11/21/2016"}];
    [mBasketball addObject:@{@"Name": @"vs. Louisiana", @"Date": @"11/23/2016"}];
    [mBasketball addObject:@{@"Name": @"@ George Mason", @"Date": @"11/26/2016"}];
    [mBasketball addObject:@{@"Name": @"@ Charlotte", @"Date": @"11/30/2016"}];
    [mBasketball addObject:@{@"Name": @"@ Longwood", @"Date": @"12/3/2016"}];
    [mBasketball addObject:@{@"Name": @"@ Western Michigan", @"Date": @"12/10/2016"}];
    [mBasketball addObject:@{@"Name": @"@ Appalachian St.", @"Date": @"12/17/2016"}];
    [mBasketball addObject:@{@"Name": @"vs. Richmond", @"Date": @"12/20/2016"}];
    [mBasketball addObject:@{@"Name": @"vs. UMBC", @"Date": @"12/23/2016"}];
    [mBasketball addObject:@{@"Name": @"vs. Eastern Mennonite", @"Date": @"12/28/2016"}];
    [mBasketball addObject:@{@"Name": @"vs. Drexel", @"Date": @"12/31/2016"}];
    [mBasketball addObject:@{@"Name": @"vs. Towson", @"Date": @"1/2/2017"}];
    [mBasketball addObject:@{@"Name": @"@ Hofstra", @"Date": @"1/5/2017"}];
    [mBasketball addObject:@{@"Name": @"@ Northeastern", @"Date": @"1/7/2017"}];
    [mBasketball addObject:@{@"Name": @"vs. College of Charleston", @"Date": @"1/12/2017"}];
    [mBasketball addObject:@{@"Name": @"vs. Elon", @"Date": @"1/14/2017"}];
    [mBasketball addObject:@{@"Name": @"@ William & Mary", @"Date": @"1/19/2017"}];
    [mBasketball addObject:@{@"Name": @"@ College of Charleston", @"Date": @"1/21/2017"}];
    [mBasketball addObject:@{@"Name": @"vs. NC Wilmington", @"Date": @"1/26/2017"}];
    [mBasketball addObject:@{@"Name": @"@ Delaware", @"Date": @"1/28/2017"}];
    [mBasketball addObject:@{@"Name": @"@ Elon", @"Date": @"2/2/2017"}];
    [mBasketball addObject:@{@"Name": @"vs. Northeastern", @"Date": @"2/4/2017"}];
    [mBasketball addObject:@{@"Name": @"@ NC Wilmington", @"Date": @"2/9/2017"}];
    [mBasketball addObject:@{@"Name": @"vs. Delaware", @"Date": @"2/11/2017"}];
    [mBasketball addObject:@{@"Name": @"vs. William & Mary", @"Date": @"2/16/2017"}];
    [mBasketball addObject:@{@"Name": @"@ Towson", @"Date": @"2/18/2017"}];
    [mBasketball addObject:@{@"Name": @"@ Drexel", @"Date": @"2/23/2017"}];
    [mBasketball addObject:@{@"Name": @"vs. Hofstra", @"Date": @"2/25/2017"}];
    [_people addObject:@{@"Name": @"Men's Basketball",
                         @"Schedule": mBasketball
                         }];
    
    
//    NSMutableArray *wBasketball = [NSMutableArray new];
    //        [sports addObject:wBasketball];
    
    [wBasketball addObject:@{@"Name": @"vs. Glenville St.", @"Date": @"11/6/2016"}];
    [wBasketball addObject:@{@"Name": @"vs. Tennessee", @"Date": @"11/11/2016"}];
    [wBasketball addObject:@{@"Name": @"vs. Saint Francis", @"Date": @"11/13/2016"}];
    [wBasketball addObject:@{@"Name": @"@ Liberty", @"Date": @"11/15/2016"}];
    [wBasketball addObject:@{@"Name": @"@ Florida State", @"Date": @"11/20/2016"}];
    [wBasketball addObject:@{@"Name": @"vs. Hampton", @"Date": @"12/2/2016"}];
    [wBasketball addObject:@{@"Name": @"@ Rutgers", @"Date": @"12/5/2016"}];
    [wBasketball addObject:@{@"Name": @"@ Saint John's", @"Date": @"12/21/2016"}];
    [wBasketball addObject:@{@"Name": @"@ Saint Joseph's", @"Date": @"12/28/2016"}];
    [wBasketball addObject:@{@"Name": @"vs. Wake Forest", @"Date": @"12/31/2016"}];
    [wBasketball addObject:@{@"Name": @"vs. NC Wilmington", @"Date": @"1/2/2017"}];
    [wBasketball addObject:@{@"Name": @"@ Towson", @"Date": @"1/8/2017"}];
    [wBasketball addObject:@{@"Name": @"@ Delaware", @"Date": @"1/13/2017"}];
    [wBasketball addObject:@{@"Name": @"vs. Northeastern", @"Date": @"1/15/2017"}];
    [wBasketball addObject:@{@"Name": @"@ Elon", @"Date": @"1/20/2017"}];
    [wBasketball addObject:@{@"Name": @"vs. Towson", @"Date": @"1/22/2017"}];
    [wBasketball addObject:@{@"Name": @"vs. Drexel", @"Date": @"1/27/2017"}];
    [wBasketball addObject:@{@"Name": @"@ William & Mary", @"Date": @"1/29/2017"}];
    [wBasketball addObject:@{@"Name": @"@ Hofstra", @"Date": @"2/3/2017"}];
    [wBasketball addObject:@{@"Name": @"@ Northeastern", @"Date": @"2/5/2017"}];
    [wBasketball addObject:@{@"Name": @"vs. Delaware", @"Date": @"2/10/2017"}];
    [wBasketball addObject:@{@"Name": @"vs. Elon", @"Date": @"2/12/2017"}];
    [wBasketball addObject:@{@"Name": @"@ NC Wilmington", @"Date": @"2/17/2017"}];
    [wBasketball addObject:@{@"Name": @"@ College of Charleston", @"Date": @"2/19/2017"}];
    [wBasketball addObject:@{@"Name": @"@ Drexel", @"Date": @"2/24/2017"}];
    [wBasketball addObject:@{@"Name": @"vs. William & Mary", @"Date": @"2/26/2017"}];
    [wBasketball addObject:@{@"Name": @"vs. College of Charleston", @"Date": @"3/1/2017"}];
    [_people addObject:@{@"Name": @"Women's Basketball", @"Schedule": wBasketball}];
    
    
//    NSMutableArray *mSoccer = [NSMutableArray new];
    [mSoccer addObject:@{@"Name": @"vs. Lehigh", @"Date": @"8/26/2016"}];
    [mSoccer addObject:@{@"Name": @"vs. N.C. State", @"Date": @"8/28/2016"}];
    [mSoccer addObject:@{@"Name": @"@ Penn State", @"Date": @"9/2/2016"}];
    [mSoccer addObject:@{@"Name": @"vs. Virginia", @"Date": @"9/5/2016"}];
    [mSoccer addObject:@{@"Name": @"@ Georgia Southern", @"Date": @"9/9/2016"}];
    [mSoccer addObject:@{@"Name": @"vs. La Salle", @"Date": @"9/13/2016"}];
    [mSoccer addObject:@{@"Name": @"@ Hofstra", @"Date": @"9/17/2016"}];
    [mSoccer addObject:@{@"Name": @"vs. Radford", @"Date": @"9/21/2016"}];
    [mSoccer addObject:@{@"Name": @"vs. Elon", @"Date": @"9/24/2016"}];
    [mSoccer addObject:@{@"Name": @"@ William & Mary", @"Date": @"9/28/2016"}];
    [mSoccer addObject:@{@"Name": @"vs. College of Charleston", @"Date": @"10/1/2016"}];
    [mSoccer addObject:@{@"Name": @"@ NC Wilmington", @"Date": @"10/8/2016"}];
    [mSoccer addObject:@{@"Name": @"vs. Delaware", @"Date": @"10/12/2016"}];
    [mSoccer addObject:@{@"Name": @"vs. Northeastern", @"Date": @"10/15/2016"}];
    [mSoccer addObject:@{@"Name": @"vs. Longwood", @"Date": @"10/19/2016"}];
    [mSoccer addObject:@{@"Name": @"@ Drexel", @"Date": @"10/22/2016"}];
    [mSoccer addObject:@{@"Name": @"@ Robert Morris", @"Date": @"10/26/2016"}];
    [_people addObject:@{@"Name": @"Men's Soccer", @"Schedule": mSoccer}];
    
    
//    NSMutableArray *wSoccer = [NSMutableArray new];
    [wSoccer addObject:@{@"Name": @"vs. Arkansas", @"Date": @"8/19/2016"}];
    [wSoccer addObject:@{@"Name": @"vs. Northwestern", @"Date": @"8/21/2016"}];
    [wSoccer addObject:@{@"Name": @"@ Richmond", @"Date": @"8/26/2016"}];
    [wSoccer addObject:@{@"Name": @"vs. Virginia Tech.", @"Date": @"8/28/2016"}];
    [wSoccer addObject:@{@"Name": @"@ East Carolina", @"Date": @"9/2/2016"}];
    [wSoccer addObject:@{@"Name": @"@ Liberty", @"Date": @"9/4/2016"}];
    [wSoccer addObject:@{@"Name": @"@ Boston U.", @"Date": @"9/9/2016"}];
    [wSoccer addObject:@{@"Name": @"@ Indiana", @"Date": @"9/11/2016"}];
    [wSoccer addObject:@{@"Name": @"vs. VCU", @"Date": @"9/16/2016"}];
    [wSoccer addObject:@{@"Name": @"@ William & Mary", @"Date": @"9/23/2016"}];
    [wSoccer addObject:@{@"Name": @"@ Elon", @"Date": @"9/25/2016"}];
    [wSoccer addObject:@{@"Name": @"vs. Drexel", @"Date": @"9/30/2016"}];
    [wSoccer addObject:@{@"Name": @"vs. Delaware", @"Date": @"10/2/2016"}];
    [wSoccer addObject:@{@"Name": @"@ Towson", @"Date": @"10/8/2016"}];
    [wSoccer addObject:@{@"Name": @"vs. College of Charleston", @"Date": @"10/14/2016"}];
    [wSoccer addObject:@{@"Name": @"vs. NC Wilmington", @"Date": @"10/16/2016"}];
    [wSoccer addObject:@{@"Name": @"@ Hofstra", @"Date": @"10/21/2016"}];
    [wSoccer addObject:@{@"Name": @"@ Northeastern", @"Date": @"10/23/2016"}];
    [_people addObject:@{@"Name": @"Women's Soccer", @"Schedule": wSoccer}];
    
    
//    NSMutableArray *mGolf = [NSMutableArray new];
    [mGolf addObject:@{@"Name": @"@ True Blue GC", @"Date": @"9/11/2016"}];
    [mGolf addObject:@{@"Name": @"@ Country Club of VA", @"Date": @"9/19/2016"}];
    [mGolf addObject:@{@"Name": @"@ Spirit Hollow GC", @"Date": @"9/30/2016"}];
    [mGolf addObject:@{@"Name": @"@ Pete Dye GC", @"Date": @"10/10/2016"}];
    [mGolf addObject:@{@"Name": @"@ Camden CC", @"Date": @"10/22/2016"}];
    [mGolf addObject:@{@"Name": @"@ Grand National Lake", @"Date": @"3/5/2017"}];
    [mGolf addObject:@{@"Name": @"@ Southwood GC", @"Date": @"3/10/2017"}];
    [mGolf addObject:@{@"Name": @"@ Furman U. GC", @"Date": @"3/24/2017"}];
    [mGolf addObject:@{@"Name": @"@ Irish Creek GC", @"Date": @"4/8/2017"}];
    [mGolf addObject:@{@"Name": @"@ Salisbury CC", @"Date": @"4/21/2017"}];
    [_people addObject:@{@"Name": @"Men's Golf", @"Schedule": mGolf}];
    
    
//    NSMutableArray *wGolf = [NSMutableArray new];
    [wGolf addObject:@{@"Name": @"@ Caledonia GC", @"Date": @"9/11/2016"}];
    [wGolf addObject:@{@"Name": @"@ Red Sky GC", @"Date": @"9/26/2016"}];
    [wGolf addObject:@{@"Name": @"@ Pinehurst No. 1", @"Date": @"10/10/2016"}];
    [wGolf addObject:@{@"Name": @"@ Hayesville, N.C.", @"Date": @"10/16/2016"}];
    [wGolf addObject:@{@"Name": @"@ Macon, GA.", @"Date": @"10/31/2016"}];
    [wGolf addObject:@{@"Name": @"@ Kiawah Island GC", @"Date": @"2/26/2017"}];
    [wGolf addObject:@{@"Name": @"@ Forest Hills GC", @"Date": @"3/17/2017"}];
    [wGolf addObject:@{@"Name": @"@ Kingsmill Resort", @"Date": @"3/27/2017"}];
    [wGolf addObject:@{@"Name": @"@ Marsh Landing CC", @"Date": @"4/3/2017"}];
    [wGolf addObject:@{@"Name": @"@ South James Plantation", @"Date": @"4/14/2017"}];
    [_people addObject:@{@"Name": @"Women's Golf", @"Schedule": wGolf}];
    
    
//    NSMutableArray *mTennis = [NSMutableArray new];
    [mTennis addObject:@{@"Name": @"@ Wilmington, N.C.", @"Date": @"9/9/2016"}];
    [mTennis addObject:@{@"Name": @"@ Greenville, N.C.", @"Date": @"9/16/2016"}];
    [mTennis addObject:@{@"Name": @"@ Elon, N.C.", @"Date": @"9/23/2016"}];
    [mTennis addObject:@{@"Name": @"@ Blacksburg, VA.", @"Date": @"10/13/2016"}];
    [mTennis addObject:@{@"Name": @"@ Raleigh, N.C.", @"Date": @"10/21/2016"}];
    [_people addObject:@{@"Name": @"Men's Tennis", @"Schedule": mTennis}];
    
    
//    NSMutableArray *wTennis = [NSMutableArray new];
    [wTennis addObject:@{@"Name": @"@ College Park, MD.", @"Date": @"9/16/2016"}];
    [wTennis addObject:@{@"Name": @"@ Charlottesville, VA.", @"Date": @"9/23/2016"}];
    [wTennis addObject:@{@"Name": @"@ Norfolk, VA.", @"Date": @"10/14/2016"}];
    [wTennis addObject:@{@"Name": @"@ Blacksburg, VA.", @"Date": @"10/28/2016"}];
    [_people addObject:@{@"Name": @"Women's Tennis", @"Schedule": wTennis}];
    
    
//    NSMutableArray *wFockey = [NSMutableArray new];
    [wFockey addObject:@{@"Name": @"vs. Liberty", @"Date": @"8/26/2016"}];
    [wFockey addObject:@{@"Name": @"vs. Longwood", @"Date": @"8/30/2016"}];
    [wFockey addObject:@{@"Name": @"vs. Appalachian St.", @"Date": @"9/2/2016"}];
    [wFockey addObject:@{@"Name": @"@ American", @"Date": @"9/4/2016"}];
    [wFockey addObject:@{@"Name": @"@ Duke", @"Date": @"9/11/2016"}];
    [wFockey addObject:@{@"Name": @"vs. New Hampshire", @"Date": @"9/16/2016"}];
    [wFockey addObject:@{@"Name": @"@ Old Dominion", @"Date": @"9/18/2016"}];
    [wFockey addObject:@{@"Name": @"@ VCU", @"Date": @"9/25/2016"}];
    [wFockey addObject:@{@"Name": @"vs. Delaware", @"Date": @"9/30/2016"}];
    [wFockey addObject:@{@"Name": @"vs. Towson", @"Date": @"10/2/2016"}];
    [wFockey addObject:@{@"Name": @"@ Northeastern", @"Date": @"10/7/2016"}];
    [wFockey addObject:@{@"Name": @"@ Drexel", @"Date": @"10/9/2016"}];
    [wFockey addObject:@{@"Name": @"vs. Richmond", @"Date": @"10/14/2016"}];
    [wFockey addObject:@{@"Name": @"@ Lafayette", @"Date": @"10/16/2016"}];
    [wFockey addObject:@{@"Name": @"vs. William & Mary", @"Date": @"10/21/2016"}];
    [wFockey addObject:@{@"Name": @"vs. Louisville", @"Date": @"10/23/2016"}];
    [wFockey addObject:@{@"Name": @"@ Hofstra", @"Date": @"10/28/2016"}];
    [wFockey addObject:@{@"Name": @"@ Virginia", @"Date": @"10/30/2016"}];
    [_people addObject:@{@"Name": @"Women's Field Hockey", @"Schedule": wFockey}];
    
    
//    NSMutableArray *mBaseball = [NSMutableArray new];
    [_people addObject:@{@"Name": @"Men's Baseball", @"Schedule": mBaseball}];
    
    
//    NSMutableArray *wSoftball = [NSMutableArray new];
    [wSoftball addObject:@{@"Name": @"@ Farmville, VA.", @"Date": @"9/24/2016"}];
    [wSoftball addObject:@{@"Name": @"vs. WV Wesleyan", @"Date": @"9/25/2016"}];
    [wSoftball addObject:@{@"Name": @"vs. Virginia", @"Date": @"10/2/2016"}];
    [wSoftball addObject:@{@"Name": @"vs. Roanoke", @"Date": @"10/9/2016"}];
    [wSoftball addObject:@{@"Name": @"vs. Louisburg", @"Date": @"10/9/2016"}];
    [_people addObject:@{@"Name": @"Women's Softball", @"Schedule": wSoftball}];
    
//    NSMutableArray *wLax = [NSMutableArray new];
    //        [wLax addObject:@{@"Name": @"@ Farmville, VA.", @"Date": @"9/24/2016"}];
    [_people addObject:@{@"Name": @"Women's Lacrosse", @"Schedule": wLax}];
    
//    NSMutableArray *wSwim = [NSMutableArray new];
    [wSwim addObject:@{@"Name": @"vs. Liberty", @"Date": @"10/15/2016"}];
    [wSwim addObject:@{@"Name": @"@ Boston, Mass.", @"Date": @"10/22/2016"}];
    [wSwim addObject:@{@"Name": @"vs. CAA POD Meet", @"Date": @"11/5/2016"}];
    [wSwim addObject:@{@"Name": @"@ Virginia Tech.", @"Date": @"10/17/2016"}];
    [wSwim addObject:@{@"Name": @"@ Rutgers", @"Date": @"10/18/2016"}];
    [wSwim addObject:@{@"Name": @"@ Richmond", @"Date": @"1/14/2017"}];
    [wSwim addObject:@{@"Name": @"vs. JMU Invitational", @"Date": @"1/20/2017"}];
    [wSwim addObject:@{@"Name": @"@ North Carolina", @"Date": @"2/3/2017"}];
    [wSwim addObject:@{@"Name": @"vs. JMU Diving Invitational", @"Date": @"2/4/2017"}];
    [_people addObject:@{@"Name": @"Women's Swim + Dive", @"Schedule": wSwim}];
    
//    NSMutableArray *wCC = [NSMutableArray new];
    [wCC addObject:@{@"Name": @"@ Viginia", @"Date": @"9/1/2016"}];
    [wCC addObject:@{@"Name": @"@ New Market, VA.", @"Date": @"9/10/2016"}];
    [wCC addObject:@{@"Name": @"@ Lehigh", @"Date": @"10/1/2016"}];
    [wCC addObject:@{@"Name": @"@ Indiana St.", @"Date": @"10/15/2016"}];
    [_people addObject:@{@"Name": @"Women's Cross Country", @"Schedule": wCC}];
    
    
//    NSMutableArray *wTrack = [NSMutableArray new];
    [wTrack addObject:@{@"Name": @"@ George Mason", @"Date": @"1/9/2017"}];
    [wTrack addObject:@{@"Name": @"@ Kentucky", @"Date": @"1/15/2017"}];
    [wTrack addObject:@{@"Name": @"@ Marshall", @"Date": @"1/29/2017"}];
    [wTrack addObject:@{@"Name": @"@ George Mason", @"Date": @"1/30/2017"}];
    [wTrack addObject:@{@"Name": @"@ Penn State", @"Date": @"2/5/2017"}];
    [wTrack addObject:@{@"Name": @"@ Liberty", @"Date": @"2/12/2017"}];
    [wTrack addObject:@{@"Name": @"@ Boston U.", @"Date": @"2/12/2017"}];
    [wTrack addObject:@{@"Name": @"@ Virginia Tech.", @"Date": @"2/19/2017"}];
    [wTrack addObject:@{@"Name": @"@ Ohio St.", @"Date": @"2/19/2017"}];
    [wTrack addObject:@{@"Name": @"@ George Mason", @"Date": @"2/28/2017"}];
    [wTrack addObject:@{@"Name": @"@ Boston, Mass.", @"Date": @"3/4/2017"}];
    [wTrack addObject:@{@"Name": @"@ Portland, Ore.", @"Date": @"3/11/2017"}];
    [wTrack addObject:@{@"Name": @"@ N.C. State", @"Date": @"3/25/2017"}];
    [wTrack addObject:@{@"Name": @"@ William & Mary", @"Date": @"3/31/2017"}];
    [wTrack addObject:@{@"Name": @"@ George Mason", @"Date": @"4/9/2017"}];
    [wTrack addObject:@{@"Name": @"@ Virginia", @"Date": @"4/22/2017"}];
    [wTrack addObject:@{@"Name": @"@ JMU", @"Date": @"4/23/2017"}];
    [wTrack addObject:@{@"Name": @"@ Penn", @"Date": @"4/28/2017"}];
    [wTrack addObject:@{@"Name": @"@ Bridgewater", @"Date": @"4/29/2017"}];
    [wTrack addObject:@{@"Name": @"@ Elon", @"Date": @"5/6/2017"}];
    
    
    
    [_people addObject:@{@"Name": @"Women's Track + Field", @"Schedule": wTrack}];
    
//    NSMutableArray *wVolleyball = [NSMutableArray new];
    [wVolleyball addObject:@{@"Name": @"@ Harrisonburg, VA.", @"Date": @"8/26/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ Ithica, N.Y.", @"Date": @"9/2/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ Fairfield, Conn.", @"Date": @"9/9/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ Washington, D.C.", @"Date": @"9/16/2016"}];
    [wVolleyball addObject:@{@"Name": @"vs. William & Mary", @"Date": @"9/21/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ Elon", @"Date": @"9/23/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ Hofstra", @"Date": @"9/30/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ Northeastern", @"Date": @"10/2/2016"}];
    [wVolleyball addObject:@{@"Name": @"vs. NC Wilmington", @"Date": @"10/7/2016"}];
    [wVolleyball addObject:@{@"Name": @"vs. College of Charleston", @"Date": @"10/9/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ Towson", @"Date": @"10/14/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ Delaware", @"Date": @"10/16/2016"}];
    [wVolleyball addObject:@{@"Name": @"vs. Northeastern", @"Date": @"10/20/2016"}];
    [wVolleyball addObject:@{@"Name": @"vs. Elon", @"Date": @"10/22/2016"}];
    [wVolleyball addObject:@{@"Name": @"vs. Hofstra", @"Date": @"10/23/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ William & Mary", @"Date": @"10/28/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ College of Charleston", @"Date": @"11/3/2016"}];
    [wVolleyball addObject:@{@"Name": @"@ NC Wilmington", @"Date": @"11/5/2016"}];
    [wVolleyball addObject:@{@"Name": @"vs. Delaware", @"Date": @"11/11/2016"}];
    [wVolleyball addObject:@{@"Name": @"vs. Towson", @"Date": @"11/12/2016"}];
    [_people addObject:@{@"Name": @"Women's Volleyball", @"Schedule": wVolleyball}];
    
}
- (NSDate*)getDateFromSched:(NSArray *)sched
{
    //CHECK FIRST DATE FROM HOME GAME & AWAY GAME
    NSLog(@"%@", sched);
    NSArray *mo = [sched[0][@"Date"] componentsSeparatedByString:@" "];
    //    NSString *firstmonth = mo[1];
    
    int firstmonth = 99;
    
    
    for (int i = 0; i < sched.count; i++) {
        if([sched[i][@"Name"] rangeOfString:@"vs."].location == NSNotFound){
            if([mo[0]  isEqual: @"Jan"]){
                firstmonth = 1;
            } else if([mo[0]  isEqual: @"Feb"]){
                firstmonth = 2;
            }
            else if([mo[0]  isEqual: @"Mar"]){
                firstmonth = 3;
            }
            else if([mo[0]  isEqual: @"Apr"]){
                firstmonth = 4;
            }
            else if([mo[0]  isEqual: @"May"]){
                firstmonth = 5;
            }
            else if([mo[0]  isEqual: @"Jun"]){
                firstmonth = 6;
            }
            else if([mo[0]  isEqual: @"Jul"]){
                firstmonth = 7;
            }
            else if([mo[0]  isEqual: @"Aug"]){
                firstmonth = 8;
            }
            else if([mo[0]  isEqual: @"Sep"]){
                firstmonth = 9;
            }
            else if([mo[0]  isEqual: @"Oct"]){
                firstmonth = 10;
            }
            else if([mo[0]  isEqual: @"Nov"]){
                firstmonth = 11;
            }
            else if([mo[0]  isEqual: @"Dec"]){
                firstmonth = 12;
            }
        }
    }
    
    
    for (int i = 0; i < sched.count; i++) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        NSString *yearString = [formatter stringFromDate:[NSDate date]];
        int year = [yearString intValue];
        
        NSArray *mo = [sched[i][@"Date"] componentsSeparatedByString:@" "];
        NSString *day = mo[1];
        int moval = 0;
        if([mo[0]  isEqual: @"Jan"]){
            moval = 1;
        } else if([mo[0]  isEqual: @"Feb"]){
            moval = 2;
        }
        else if([mo[0]  isEqual: @"Mar"]){
            moval = 3;
        }
        else if([mo[0]  isEqual: @"Apr"]){
            moval = 4;
        }
        else if([mo[0]  isEqual: @"May"]){
            moval = 5;
        }
        else if([mo[0]  isEqual: @"Jun"]){
            moval = 6;
        }
        else if([mo[0]  isEqual: @"Jul"]){
            moval = 7;
        }
        else if([mo[0]  isEqual: @"Aug"]){
            moval = 8;
        }
        else if([mo[0]  isEqual: @"Sep"]){
            moval = 9;
        }
        else if([mo[0]  isEqual: @"Oct"]){
            moval = 10;
        }
        else if([mo[0]  isEqual: @"Nov"]){
            moval = 11;
        }
        else if([mo[0]  isEqual: @"Dec"]){
            moval = 12;
        }
        
        if (moval < firstmonth)
        {
            
            year += 1;
        }
        
        NSLog(@"%@ %@ %@", day, mo[0], [NSString stringWithFormat:@"%i", year]);
        
        
    }
    
    return [NSDate new];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //where indexPath.row is the selected cell
    NSLog(@"%@", _people[indexPath.row]);
    [self performSegueWithIdentifier:@"maintosecond" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"maintosecond"]) {
        NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
        SecondViewController *destViewController = segue.destinationViewController;
        destViewController.people = _people;
        destViewController.index = indexPath.row;
        
        //        UIView.setAnimationsEnabled(false)
        //        self.nav.prompt = nil;
        //        self.setAnimationsEnabled(true)
    }
}


@end
