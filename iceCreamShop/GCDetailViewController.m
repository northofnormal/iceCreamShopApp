//
//  GCDetailViewController.m
//  iceCreamShop
//
//  Created by DetroitLabsUser on 3/17/14.
//  Copyright (c) 2014 Anne Cahalan. All rights reserved.
//

#import "GCDetailViewController.h"
#import "GCStockViewController.h"

@interface GCDetailViewController ()

@property (nonatomic, weak) IBOutlet UITextField *flavorName;
@property (nonatomic, weak) IBOutlet UITextField *quantity;
@property (nonatomic, weak) IBOutlet UIButton *updateButton;
@property (nonatomic, strong) GCStockViewController *stockViewController;

@end

@implementation GCDetailViewController

- (IBAction)updateButtonPressed:(id)sender
{
    NSLog(@"Let's Update Some Stuff for %@",_indexRow);
    
    NSDictionary *addedIceCreamInfo = [[NSDictionary alloc] initWithObjectsAndKeys:_flavorName.text, @"Flavor", _quantity.text, @"Quantity", nil];
    
    if ([_indexRow length] == 0 ) {
        NSLog(@"Add");
        [_iceCreamArray addObject:addedIceCreamInfo];
        [_iceCreamArray writeToFile:[self getStockListPath] atomically:YES];
    } else {
        NSLog(@"Change");
        [_iceCreamArray replaceObjectAtIndex:[_indexRow intValue] withObject:addedIceCreamInfo];
        [_iceCreamArray writeToFile:[self getStockListPath] atomically:YES];
    }
    
    _stockViewController = [[GCStockViewController alloc] initWithNibName:@"GCStockViewController" bundle:nil];
    [self.navigationController pushViewController:_stockViewController animated:YES];
    
}

- (NSString *)getStockListPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Stock.plist"];
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
    
    if (_indexRow) {
        _flavorName.text = [[_iceCreamArray objectAtIndex:[_indexRow intValue]] objectForKey:@"Flavor"];
        _quantity.text = [[_iceCreamArray objectAtIndex:[_indexRow intValue]] objectForKey:@"Quantity"];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
