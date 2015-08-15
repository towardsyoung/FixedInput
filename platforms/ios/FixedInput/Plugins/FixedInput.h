//
//  FixedInput.h
//  FixedInput
//
//  Created by 陈朝阳 on 15/8/14.
//
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>

@interface FixedInput : CDVPlugin<UITextViewDelegate>{
    UIToolbar * toolBar;
    UITextView * textField;
    UIBarButtonItem * sendButton;
    int screenWidth;
    int screenHeight;
    float beginTextViewHeight;
    float curTextViewHeight;
    CDVInvokedUrlCommand * showCommand;
}

- (void)show:(CDVInvokedUrlCommand*)command;
- (void)hide:(CDVInvokedUrlCommand*)command;

@end

