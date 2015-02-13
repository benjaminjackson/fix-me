//
//  DetailViewController.h
//  FixMe
//
//  Created by Benjamin Jackson on 2/12/15.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSURL *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

