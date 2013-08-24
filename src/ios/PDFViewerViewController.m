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

    NSString *url = [fileURL relativeString];
    NSArray *parts = [url componentsSeparatedByString:@"/"];
    if ([parts count] > 1) {
        NSString *filename = [parts objectAtIndex:[parts count]-1];
        navBar.topItem.title = filename;
    } else {
        navBar.topItem.title = @"";
    }
    webView.backgroundColor = [UIColor darkGrayColor];
	webView.scalesPageToFit = YES;
	webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
}

- (IBAction)close {
    [self dismissModalViewControllerAnimated:YES];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
    [plugin.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setFileURL:(NSURL *)url
{
    fileURL = url;
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
