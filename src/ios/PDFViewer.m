//  PDFViewer.m
//
//  Created by Pierre-Emmanuel Bois on 08/08/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import "PDFViewer.h"
#import <Cordova/CDV.h>

@implementation PDFViewer

- (void)open:(CDVInvokedUrlCommand*)command
{
    NSString* url = [command.arguments objectAtIndex:0];
    NSString* ext = [command.arguments objectAtIndex:1];
    if (url != nil && [url length] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *fileURL = [[NSBundle mainBundle] URLForResource:url withExtension:ext];
            if (fileURL) {
                pdfviewerViewController = [[PDFViewerViewController alloc] initWithNibName:@"PDFViewerViewController" bundle:nil];
                [pdfviewerViewController setPlugin:self];
                [pdfviewerViewController setCommand:command];
                [pdfviewerViewController setFileURL:fileURL];
                
                CGRect optionsFrame = pdfviewerViewController.view.frame;
                optionsFrame.origin.x = 0;
                optionsFrame.size.width = 320;
                optionsFrame.origin.y = 423;
                optionsFrame.origin.y += optionsFrame.size.height;
                
                pdfviewerViewController.view.frame = optionsFrame;
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                [UIView setAnimationDuration:.3];
                optionsFrame.origin.y -= optionsFrame.size.height;
                pdfviewerViewController.view.frame = optionsFrame;
                [[[self viewController] view] addSubview:pdfviewerViewController.view];
                [pdfviewerViewController.view setFrame:self.webView.frame];
                [UIView commitAnimations];
            }
        });
    } else {
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end
