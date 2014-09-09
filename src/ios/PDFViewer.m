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
    NSString* fileTitle = [command.arguments objectAtIndex:1];
    if (url != nil && [url length] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // NSURL *fileURL = [NSURL URLWithString:url];
            //NSURL *fileURL = [NSURL fileURLWithPath:[url stringByReplacingOccurrencesOfString:@"file://" withString:@""]];
            NSString *fileURL = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"www/%@",url];
            if (fileURL) {
                pdfviewerViewController = [[UIStoryboard storyboardWithName:@"PDFViewerViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"PDFViewer"];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:pdfviewerViewController];
                [pdfviewerViewController setPlugin:self];
                [pdfviewerViewController setCommand:command];
                [pdfviewerViewController setFileURL:fileURL];
                if (fileTitle != nil && [fileTitle length] > 0) {
                    [pdfviewerViewController setFileTitle:fileTitle];
                }
                if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]){
                    [[self viewController] presentViewController:navigationController animated:YES  completion:nil];
                } else {
                    [[self viewController] presentModalViewController:navigationController animated:YES];
                }
            }
        });
    } else {
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end
