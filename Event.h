//
//  Event.h
//  Ticket-o-matic
//
//  Created by Bogdan on 11/17/12.
//
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
{
    NSString *Name;
    NSDate *startDate;
    NSDate *endDate;
    NSArray *Clients;
}
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSArray * Clients;
@end
