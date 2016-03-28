//
//  ViewController.m
//  Rili
//
//  Created by mrj on 16/3/2.
//  Copyright © 2016年 mrj. All rights reserved.
//

#import "ViewController.h"
#import <EventKit/EventKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //事件市场
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    //6.0及以上通过下面方式写入事件
//    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
//    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    //事件保存到日历
                    
                    
                    //创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = @"哈哈哈，我是日历事件啊";
                    event.location = @"我在杭州西湖区留和路";
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
//                    NSDate *data = [NSDate data];
                    NSDate *date = [NSDate date];
                    event.startDate = date;
                    NSTimeInterval time = 1*60* 24;
                    event.endDate   =  date;
                    event.allDay = YES;
                    NSDate *nowDate = [NSDate dateWithTimeInterval:60 sinceDate:date];
                    //添加提醒
//                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:time]];
                    [event addAlarm:[EKAlarm alarmWithAbsoluteDate:nowDate]];
//                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];

                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"设置日历提醒"
                                          message:@"确定开启"
                                          delegate:nil
                                          cancelButtonTitle:@"YES"
                                          otherButtonTitles:nil];
                    [alert show];
                    
                    NSLog(@"保存成功");
                    
                }
            });
        }];
//    }
//    else
//    {
//        // this code runs in iOS 4 or iOS 5
//        // ***** do the important stuff here *****
//        
//        //4.0和5.0通过下述方式添加
//        
//        //保存日历
//        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
//        event.title     = @"哈哈哈，我是日历事件啊";
//        event.location = @"我在杭州西湖区留和路";
//        
//        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
//        [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
//        
//        event.startDate = [[NSDate alloc]init ];
//        event.endDate   = [[NSDate alloc]init ];
//        event.allDay = YES;
//        
//        
//        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
//        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
//        
//        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
//        NSError *err;
//        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
//        
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"Event Created"
//                              message:@"Yay!?"
//                              delegate:nil
//                              cancelButtonTitle:@"Okay"
//                              otherButtonTitles:nil];
//        [alert show];
//        
//        NSLog(@"保存成功");
//        
//    }
//}

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
