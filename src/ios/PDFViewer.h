//  PDFViewer.h
//
//  Created by Pierre-Emmanuel Bois on 08/08/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>
#import "PDFViewerViewController.h"

@interface PDFViewer : CDVPlugin {
    PDFViewerViewController *pdfviewerViewController;
}

- (void)open:(CDVInvokedUrlCommand*)command;

@end
