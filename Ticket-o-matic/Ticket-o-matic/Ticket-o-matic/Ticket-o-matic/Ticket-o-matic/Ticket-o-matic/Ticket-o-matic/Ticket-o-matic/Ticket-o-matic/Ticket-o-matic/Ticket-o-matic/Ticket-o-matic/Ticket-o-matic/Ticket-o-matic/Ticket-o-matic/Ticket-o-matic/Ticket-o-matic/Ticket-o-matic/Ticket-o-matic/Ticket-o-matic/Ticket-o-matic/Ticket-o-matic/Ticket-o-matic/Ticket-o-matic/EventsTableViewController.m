//
//  EventsTableViewController.m
//  Ticket-o-matic
//
//  Created by Laborator iOS on 11/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventsTableViewController.h"
#import "Event.h"
#import "SBJson.h"
@interface EventsTableViewController ()

@property (nonatomic, strong) NSArray *events;

@end

@implementation EventsTableViewController

@synthesize events = _events;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* acceptHeader = @"application/json";
    NSURL* url = [NSURL URLWithString:@"http://ticketquest.azurewebsites.net/api/mobile"];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:acceptHeader forHTTPHeaderField:@"Accept"];
    
    NSURLResponse* responseGET = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&responseGET
                                                     error:&error];
    
    
    NSString *mewSTR = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"trece");
    NSLog(@"%@",mewSTR);
    
    NSMutableURLRequest*request1 = [[NSMutableURLRequest alloc] initWithURL:url];
    [request1 setHTTPMethod:@"POST"];
    
    NSString * contentType = @"application/json; charset=utf-8";
    [request1 setValue: contentType forHTTPHeaderField:@"Content-Type"];
    NSString *postString = @"{\" Name\":\"Bogdan Nechita\",\"Age\":23}";
    [request1 setHTTPBody:[postString dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLResponse* responsePOST = nil;
    NSError* error1 = nil;
    NSData* data1 = [NSURLConnection sendSynchronousRequest:request1
                                          returningResponse:&responsePOST
                                                      error:&error1];
    NSString *mewSTR1 = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    NSLog(@"trece");
    NSLog(@"%@",mewSTR1);
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *parserError = nil;
    NSArray *jsonObjects = [jsonParser objectWithString:mewSTR error:&parserError];
    jsonParser = nil;
    
    NSMutableArray *events = [NSMutableArray array];
    
    for(NSDictionary *doct in jsonObjects){
        Event *newEvent =[ [ Event alloc ] init ];
        [newEvent setName:[doct objectForKey:@"Name"]];
        [events addObject:newEvent];
    }
    for(Event*event in events)
    {
        NSLog(@"%@",event.Name);
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSArray *)events
{
    // lazy instantiation
    if (_events == nil)
    {
        _events = [NSArray arrayWithObjects:
                   @"Red Hot Chili Peppers",
                   @"Rammstein",
                   @"Kings on Ice",
                   @"Depeche Mode",
                   @"Laura Pausini",
                   @"Dimmu Borgir",
                   @"Linkin Park", 
                   @"The Prodigy", nil];
    }
    return _events;
}

//- (NSArray *)events
//{
//    NSString *title = @"Red Hot Chili Peppers";
//    NSString *location = @"National Arena";
//    NSString *date = @"30/08/2013";
//    NSString *thumbnailUrlString = @"/images/redhot.jpg";
//    int stepsNumber = 3;
//    NSDictionary *eventInfo = [NSDictionary dictionaryWithObjectsAndKeys:
//                               title, @"title",
//                               location, @"location",
//                               date, @"date",
//                               thumbnailUrlString, @"thumbnailUrlString", nil]; 
//    NSMutableArray *events = [[NSMutableArray alloc] initWithCapacity:1];
//    [events addObject:eventInfo];
//    return (NSArray *)events;
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.events objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
