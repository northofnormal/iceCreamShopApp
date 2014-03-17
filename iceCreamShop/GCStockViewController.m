//
//  GCStockViewController.m
//  iceCreamShop
//
//  Created by DetroitLabsUser on 3/17/14.
//  Copyright (c) 2014 Anne Cahalan. All rights reserved.
//

#import "GCStockViewController.h"
#import "GCDetailViewController.h"

@interface GCStockViewController ()

@property (nonatomic, strong) NSMutableArray *iceCreamArray;
@property (nonatomic, weak) IBOutlet UITableView *stockTableView;
@property (nonatomic, strong) GCDetailViewController *detailViewController;

@end

@implementation GCStockViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_iceCreamArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [_iceCreamArray[indexPath.row] objectForKey:@"Flavor"];
    cell.detailTextLabel.text = [_iceCreamArray[indexPath.row] objectForKey:@"Quantity"];
    return cell;

}

 - (NSString *)getStockListPath
 {
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     return [documentsDirectory stringByAppendingPathComponent:@"Stock.plist"];
 }

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _stockTableView) {
        NSLog(@"Look, I've Been Selected!!");
        _detailViewController = [[GCDetailViewController alloc] initWithNibName:@"GCDetailViewController" bundle:nil];
        _detailViewController.iceCreamArray = _iceCreamArray;
        _detailViewController.indexRow = [NSString stringWithFormat:@"%i",[indexPath row]];
        [self.navigationController pushViewController:_detailViewController animated:YES];
        
    }
}

- (IBAction)addButtonPressed:(id)sender {
    NSLog(@"Add");
    _detailViewController = [[GCDetailViewController alloc] initWithNibName:@"GCDetailViewController" bundle:nil];
    _detailViewController.iceCreamArray = _iceCreamArray;
    [self.navigationController pushViewController:_detailViewController animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Stock" ofType:@"plist"];
    NSString *documentPath = [self getStockListPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:documentPath error:&error];
    }
    _iceCreamArray = [[NSMutableArray alloc] initWithContentsOfFile:documentPath];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed:)];
        
    self.navigationItem.rightBarButtonItem = addButton;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
