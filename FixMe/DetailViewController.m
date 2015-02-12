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

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURL *URL = [NSURL URLWithString:[self.detailItem valueForKey:@"URL"]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            aWebView.alpha = 1;
        } completion:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
