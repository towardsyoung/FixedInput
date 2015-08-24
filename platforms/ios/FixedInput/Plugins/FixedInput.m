//
//  FixedInput.m
//  FixedInput
//
//  Created by 陈朝阳 on 15/8/14.
//
//

#import <Foundation/Foundation.h>
#import "FixedInput.h"

//输入框工具条
#define defaultBarHeight 45
#define defaultTVHeight 30
@implementation FixedInput

-(void) show:(CDVInvokedUrlCommand *)command {
    NSString* defaultText = [command.arguments objectAtIndex:0];
    NSString* btnText = [command.arguments objectAtIndex:1];
    if (toolBar == nil) {
        //屏幕宽度
        screenWidth  = [UIScreen mainScreen].bounds.size.width;
        //屏幕高度
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        //注册键盘变化事件
        [self registerForKeyboardNotifications];
        //发送按钮
        sendButton = [[UIBarButtonItem alloc] initWithTitle:@"回复" style:UIBarButtonItemStyleDone target:self action:@selector(sendContent)];
        //文字输入框
        textField = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, screenWidth - 75, defaultTVHeight)];
        textField.scrollEnabled = YES;
        textField.font = [UIFont systemFontOfSize:14];
        textField.delegate = self;
        //起始时textview的高度
        //    beginTextViewHeight = [self measureHeightOfUITextView : textField];
        //    curTextViewHeight = beginTextViewHeight;
        UIBarButtonItem *textFieldItem = [[UIBarButtonItem alloc] initWithCustomView:textField];
        
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenHeight - defaultBarHeight,screenWidth,defaultBarHeight)];
        toolBar.barStyle = UIBarStyleDefault;
        toolBar.items = [NSArray arrayWithObjects:textFieldItem,sendButton,nil];
        [self.viewController.view addSubview:toolBar];
    } else {
        toolBar.hidden = false;
    }
    if (defaultText) {
        textField.text = defaultText;
    }
    if (btnText) {
        sendButton.title = btnText;
    }
    showCommand = command;
}

-(void) showAndFocus:(CDVInvokedUrlCommand *)command {
    [self show:command];
    [textField becomeFirstResponder];
}

-(void) hide:(CDVInvokedUrlCommand *)command {
    [textField resignFirstResponder];
    toolBar.hidden = true;
}

-(void) sendContent {
    NSString *inputText = textField.text;
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString : inputText];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:showCommand.callbackId];
    [textField resignFirstResponder];
    textField.text = @"";
}

-(void)textViewDidChange:(UITextView *)textView {
    //    float height = [self measureHeightOfUITextView:textField];
    //    if (curTextViewHeight != height) {
    //        float changeHeight = height - beginTextViewHeight;
    //        [self changeView:changeHeight];
    //        curTextViewHeight = height;
    //    }
    //    CGSize contentSize = textField.contentMode;
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^{
        //此处的viewFooter即是你的输入框View
        toolBar.frame = CGRectMake(0, screenHeight - defaultBarHeight - kbSize.height, screenWidth, defaultBarHeight);
    } completion:^(BOOL finished){
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView beginAnimations:nil context:nil];
    toolBar.frame = CGRectMake(0, screenHeight - defaultBarHeight, screenWidth, defaultBarHeight);
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}

-(CGFloat)measureHeightOfUITextView:(UITextView *)textView {
    if ([textView respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        // This is the code for iOS 7. contentSize no longer returns the correct value, so
        CGRect frame = textView.bounds;
        // Take account of the padding added around the text.
        UIEdgeInsets textContainerInsets = textView.textContainerInset;
        UIEdgeInsets contentInsets = textView.contentInset;
        
        CGFloat leftRightPadding = textContainerInsets.left + textContainerInsets.right + textView.textContainer.lineFragmentPadding * 2 + contentInsets.left + contentInsets.right;
        CGFloat topBottomPadding = textContainerInsets.top + textContainerInsets.bottom + contentInsets.top + contentInsets.bottom;
        
        frame.size.width -= leftRightPadding;
        frame.size.height -= topBottomPadding;
        
        NSString *textToMeasure = textView.text;
        if ([textToMeasure hasSuffix:@"\n"])
        {
            textToMeasure = [NSString stringWithFormat:@"%@-", textView.text];
        }
        
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName: textView.font, NSParagraphStyleAttributeName : paragraphStyle };
        
        CGRect size = [textToMeasure boundingRectWithSize:CGSizeMake(CGRectGetWidth(frame), MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributes
                                                  context:nil];
        
        CGFloat measuredHeight = ceilf(CGRectGetHeight(size) + topBottomPadding);
        return measuredHeight+8.0f;
    } else {
        return textView.contentSize.height;
    }
}

-(void)changeView : (float)changeHeight {
    textField.frame = CGRectMake(0, 0, screenWidth - 75, defaultTVHeight + changeHeight);
}
@end
