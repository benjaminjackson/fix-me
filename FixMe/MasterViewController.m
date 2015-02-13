//
//  MasterViewController.m
//  FixMe
//
//  Created by Benjamin Jackson on 2/12/15.
//
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, strong) NSArray *images;

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.urls = @[[NSURL URLWithString:@"http://nytimes.com"],
                  [NSURL URLWithString:@"http://wsj.com"],
                  [NSURL URLWithString:@"http://ft.com"],
                  [NSURL URLWithString:@"http://grantland.com"],
                  [NSURL URLWithString:@"http://vicenews.com"]];
    self.images = @[[self imageWithImage:[UIImage imageNamed:@"1.jpg"] scaledToSize:CGSizeMake(100, 50)],
                    [self imageWithImage:[UIImage imageNamed:@"2.jpg"] scaledToSize:CGSizeMake(100, 50)],
                    [self imageWithImage:[UIImage imageNamed:@"3.jpg"] scaledToSize:CGSizeMake(100, 50)],
                    [self imageWithImage:[UIImage imageNamed:@"4.jpg"] scaledToSize:CGSizeMake(100, 50)],
                    [self imageWithImage:[UIImage imageNamed:@"5.jpg"]scaledToSize:CGSizeMake(100, 50)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSURL *url = self.urls[indexPath.row % [self.urls count]];
        [[segue destinationViewController] setDetailItem:url];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = [self.images objectAtIndex:((long)indexPath.row % 5)];
    cell.textLabel.text = [NSString stringWithFormat:@"Image %ld", (long)indexPath.row];
    cell.accessoryView = imageView;
    return cell;
}

#pragma mark - private

//need to avoid super large images....
//taken from the interwebs ---
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
