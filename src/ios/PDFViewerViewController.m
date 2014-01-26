//  PDFViewerViewController.m
//
//  Created by Pierre-Emmanuel Bois on 8/23/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import "PDFViewerViewController.h"

@interface PDFViewerViewController ()

@end

@implementation PDFViewerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // ...
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webView.delegate = self;
    webView.scrollView.delegate = self;
    
    NSString *url = [fileURL relativeString];
    if ([fileTitle length] > 0) {
        navItem.title = fileTitle;
    } else {
        NSArray *parts = [url componentsSeparatedByString:@"/"];
        if ([parts count] > 1) {
            NSString *filename = [parts objectAtIndex:[parts count]-1];
            navItem.title = filename;

        }
    }
    webView.backgroundColor = [UIColor darkGrayColor];
	webView.scalesPageToFit = YES;
	webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    [panGestureRecognizer requireGestureRecognizerToFail:pinchGestureRecognizer];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [doubleTapGestureRecognizer requireGestureRecognizerToFail:pinchGestureRecognizer];
    [doubleTapGestureRecognizer requireGestureRecognizerToFail:panGestureRecognizer];
    doubleTapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [singleTapGestureRecognizer requireGestureRecognizerToFail:pinchGestureRecognizer];
    [singleTapGestureRecognizer requireGestureRecognizerToFail:panGestureRecognizer];
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    singleTapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void) handlePan:(UIPanGestureRecognizer *)pan {
    CGPoint velocity = [pan velocityInView:webView];
    if (velocity.y > 0) {
        [self showNavigationBar];
    } else {
        [self hideNavigationBar];
    }
}

- (void) handlePinch:(UIPinchGestureRecognizer *)pinch {
    //NSLog(@"handlePinch");
}

- (void) handleSingleTap:(UITapGestureRecognizer *)tap {
    //NSLog(@"handleSingleTap");
    [self toggleNavigationBar];
}

- (void) handleDoubleTap:(UITapGestureRecognizer *)tap {
    //NSLog(@"handleDoubleTap");
}

- (void)webViewDidFinishLoad:(UIWebView *)theWebView {
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

- (void) toggleNavigationBar {
    if (self.navigationController.navigationBar.hidden == NO) {
        [self hideNavigationBar];
    } else if (self.navigationController.navigationBar.hidden == YES) {
        [self showNavigationBar];
    }
}

- (void) showNavigationBar {
    isStatusBarHidden = FALSE;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void) hideNavigationBar {
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    isStatusBarHidden = YES;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
}

- (BOOL)prefersStatusBarHidden {
    return isStatusBarHidden;
}

- (IBAction)close
{
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
    [plugin.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setFileURL:(NSURL *)url
{
    fileURL = url;
}

- (void)setFileTitle:(NSString *)title
{
    fileTitle = title;
}

- (void)setPlugin:(CDVPlugin *)cdvPlugin
{
    plugin = cdvPlugin;
}

- (void)setCommand:(CDVInvokedUrlCommand *)cdvCommand
{
    command = cdvCommand;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
