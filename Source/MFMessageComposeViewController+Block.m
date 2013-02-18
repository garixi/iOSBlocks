//
//  MFMessageComposeViewController+Block.m
//  BetaStore
//
//  Created by Ignacio on 12/12/12.
//  Copyright (c) 2012 BetaStore. All rights reserved.
//

#import "MFMessageComposeViewController+Block.h"

static ComposeCreatedBlock _composeCreatedBlock;
static ComposeFinishedBlock _composeFinishedBlock;

@implementation MFMessageComposeViewController (Block)

+ (void)messageWithBody:(NSString *)body
             recipients:(NSArray *)recipients
             onCreation:(ComposeCreatedBlock)creation
               onFinish:(ComposeFinishedBlock)finished
{
    _composeCreatedBlock = [creation copy];
    _composeFinishedBlock = [finished copy];
    
    MFMessageComposeViewController *messageComposerViewController = [[MFMessageComposeViewController alloc] init];
    messageComposerViewController.messageComposeDelegate = [self class];
    [messageComposerViewController setBody:body];
    [messageComposerViewController setRecipients:recipients];
    
    messageComposerViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    _composeCreatedBlock(messageComposerViewController);
}


#pragma mark - MFMessageComposeViewControllerDelegate

+ (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    _composeFinishedBlock(controller, nil);
}

@end