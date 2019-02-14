/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVImageZoom.h"
#import <Cordova/CDVViewController.h>
#import <Cordova/CDVScreenOrientationDelegate.h>
#import "CDVViewController+ImageZoom.h"

@implementation CDVImageZoom


- (void)show:(CDVInvokedUrlCommand*)command
{
    imageURL = [command argumentAtIndex:0];
    options = [command argumentAtIndex:1];
    [self setVisible];
}

- (void)hide:(CDVInvokedUrlCommand*)command
{
    [self destroyViews];
}


- (void)createViews
{
    // Determine whether rotation should be enabled for this device
    // Per iOS HIG, landscape is only supported on iPad and iPhone 6+
    CDV_iOSDevice device = [self getCurrentDevice];
    BOOL autorotateValue = (device.iPad || device.iPhone6Plus || device.iPhoneX) ?
        [(CDVViewController *)self.viewController shouldAutorotateDefaultValue] :
        NO;

    [(CDVViewController *)self.viewController setEnabledAutorotation:autorotateValue];

    UIView* parentView = self.viewController.view;
//PK    parentView.userInteractionEnabled = NO;  // disable user interaction while imagezoom is shown

    // Set the frame & image later.
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [parentView addSubview:_imageView];
    
    // Frame is required when launching in portrait mode.
    // Bounds for landscape since it captures the rotation.
    [parentView addObserver:self forKeyPath:@"frame" options:0 context:nil];
    [parentView addObserver:self forKeyPath:@"bounds" options:0 context:nil];

    [self updateImage];
    _destroyed = NO;
}


- (void)destroyViews
{
    _destroyed = YES;
    [(CDVViewController *)self.viewController setEnabledAutorotation:[(CDVViewController *)self.viewController shouldAutorotateDefaultValue]];

    [_imageView removeFromSuperview];
    _imageView = nil;
    _curImageName = nil;

    @try {
        [self.viewController.view removeObserver:self forKeyPath:@"frame"];
        [self.viewController.view removeObserver:self forKeyPath:@"bounds"];
    }
    @catch (NSException *exception) {
        // When reloading the page from a remotely connected Safari, there
        // are no observers, so the removeObserver method throws an exception,
        // that we can safely ignore.
        // Alternatively we can check whether there are observers before calling removeObserver
    }
}

- (CDV_iOSDevice) getCurrentDevice
{
    CDV_iOSDevice device;

    UIScreen* mainScreen = [UIScreen mainScreen];
    CGFloat mainScreenHeight = mainScreen.bounds.size.height;
    CGFloat mainScreenWidth = mainScreen.bounds.size.width;

    int limit = MAX(mainScreenHeight,mainScreenWidth);

    device.iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    device.iPhone = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
    device.retina = ([mainScreen scale] == 2.0);
    device.iPhone4 = (device.iPhone && limit == 480.0);
    device.iPhone5 = (device.iPhone && limit == 568.0);
    // note these below is not a true device detect, for example if you are on an
    // iPhone 6/6+ but the app is scaled it will prob set iPhone5 as true, but
    // this is appropriate for detecting the runtime screen environment
    device.iPhone6 = (device.iPhone && limit == 667.0);
    device.iPhone6Plus = (device.iPhone && limit == 736.0);
    device.iPhoneX  = (device.iPhone && limit == 812.0);

    return device;
}

// PK remove this later
- (BOOL) isUsingCDVLaunchScreen {
    NSString* launchStoryboardName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UILaunchStoryboardName"];
    if (launchStoryboardName) {
        return ([launchStoryboardName isEqualToString:@"CDVLaunchScreen"]);
    } else {
        return NO;
    }
}


- (UIInterfaceOrientation)getCurrentOrientation
{
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    UIDeviceOrientation dOrientation = [UIDevice currentDevice].orientation;

    bool landscape;

    if (dOrientation == UIDeviceOrientationUnknown || dOrientation == UIDeviceOrientationFaceUp || dOrientation == UIDeviceOrientationFaceDown) {
        // If the device is laying down, use the UIInterfaceOrientation based on the status bar.
        landscape = UIInterfaceOrientationIsLandscape(iOrientation);
    } else {
        // If the device is not laying down, use UIDeviceOrientation.
        landscape = UIDeviceOrientationIsLandscape(dOrientation);

        // There's a bug in iOS!!!! http://openradar.appspot.com/7216046
        // So values needs to be reversed for landscape!
        if (dOrientation == UIDeviceOrientationLandscapeLeft)
        {
            iOrientation = UIInterfaceOrientationLandscapeRight;
        }
        else if (dOrientation == UIDeviceOrientationLandscapeRight)
        {
            iOrientation = UIInterfaceOrientationLandscapeLeft;
        }
        else if (dOrientation == UIDeviceOrientationPortrait)
        {
            iOrientation = UIInterfaceOrientationPortrait;
        }
        else if (dOrientation == UIDeviceOrientationPortraitUpsideDown)
        {
            iOrientation = UIInterfaceOrientationPortraitUpsideDown;
        }
    }

    return iOrientation;
}

// Sets the view's frame and image.
- (void)updateImage
{
    if (![imageURL isEqualToString:_curImageName])
    {
        _curImageName = imageURL;
        UIImage* img = [UIImage imageNamed:imageURL];
        
        // https://developer.apple.com/documentation/uikit/uiimage/1624127-resizableimage
        _imageView.image = img;//img.resizableimage(0);
    }

    // Check that image exists before updating bounds
    if (_imageView.image)
    {
        [self updateBounds];
    }
    else
    {
        NSLog(@"WARNING: The imagezoom image named %@ was not found", imageURL);
    }
}

- (void)updateBounds
{
    _imageView.frame = CGRectMake(100, 50, 200, 400);
}

- (void)setVisible
{
    if (_imageView == nil)
    {
        [self createViews];
    }
}

@end
