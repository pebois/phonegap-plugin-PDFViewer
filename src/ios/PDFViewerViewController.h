//  PDFViewerViewController.h
//
//  Created by Pierre-Emmanuel Bois on 8/23/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>

@interface PDFViewerViewController : UIViewController <UIWebViewDelegate> {
    NSURL *fileURL;
    CDVPlugin *plugin;
    CDVInvokedUrlCommand *command;
    IBOutlet UIWebView *webView;
    IBOutlet UIBarButtonItem *barButton;
    IBOutlet UINavigationBar *navBar;
}

- (IBAction)close;
- (void)setFileURL:(NSURL *)url;
- (void)setPlugin:(CDVPlugin *)cdvPlugin;
- (void)setCommand:(CDVInvokedUrlCommand *)cdvCommand;

@end
