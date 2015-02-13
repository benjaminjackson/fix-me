//
//  DetailViewController.m
//  FixMe
//
//  Created by Benjamin Jackson on 2/12/15.
//
//

#import "DetailViewController.h"

@interface DetailViewController () <UIWebViewDelegate> {
}

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(NSURL *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.detailItem];
    [webView loadRequest:request];
    webView.alpha = 0;
    webView.delegate = self;
    [self.view addSubview:webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    //not sure I see the point in this, since UIView animations happen on the main thread anyway
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            aWebView.alpha = 1;
        } completion:nil];
    //});
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
//I normally don't use storyboarding, so this took more time for me, but I would normally use Masonry or Autolayout DSL to handle changes for orientation
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
