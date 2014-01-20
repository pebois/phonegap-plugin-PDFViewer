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
                [[self viewController] presentModalViewController:pdfviewerViewController animated:YES];
            }
        });
    } else {
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end
