//
//  AppDelegate.m
//  Skp
//
//  Created by 剑锋 莫 on 16/3/11.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#import "AppDelegate.h"
#import "PKRevealController.h"
//#import "LeftFaceController.h"
#import "CommonHeader.h"

#import "MainFaceController.h"
#import "CollectionViewController.h"
#import "HJCarouselViewLayout.h"
#import "AboutViewController.h"
#import "ContractUsViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //菜单栏
//    LeftFaceController* leftFaceController = [[LeftFaceController alloc] init];
    
    UITabBarController *tabBarController;
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate=self;
    tabBarController.moreNavigationController.navigationBar.barStyle=UIBarStyleBlack;

    //屏幕界面
    HJCarouselViewLayout *layout = nil;
    int style = 0;
    switch (style) {
        case 0:
            layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
            layout.visibleCount = 6;
            break;
        case 1:
            layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimRotary];
            break;
        case 2:
            layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimCarousel];
            break;
        case 3:
            layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimCarousel1];
            break;
        case 4:
            layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimCoverFlow];
            break;
        default:
            layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
            break;
    }
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(240, 400);
    CollectionViewController *clVC = [[CollectionViewController alloc] initWithCollectionViewLayout:layout];

    //节目制作界面
    MainFaceController* mainFaceController = [[MainFaceController alloc] init];
    //我的界面
    AboutViewController *aboutVC = [[AboutViewController alloc]init];
    
    UINavigationController *navFirst = [[UINavigationController alloc] initWithRootViewController:clVC];
    UINavigationController *navSecond = [[UINavigationController alloc] initWithRootViewController:mainFaceController];
    UINavigationController *navThird = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:navFirst,navSecond,navThird,nil];
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *itemBar0= [tabBar.items objectAtIndex:0];
    itemBar0.image = [UIImage imageNamed:@"me"];
    itemBar0.title = @"屏幕列表";
    UITabBarItem *itemBar1= [tabBar.items objectAtIndex:1];
    itemBar1.image = [UIImage imageNamed:@"me"];
    itemBar1.title = @"节目制作";
    UITabBarItem *itemBar2= [tabBar.items objectAtIndex:2];
    itemBar2.image = [UIImage imageNamed:@"me"];
    itemBar2.title = @"我的";
    
    
    
     //构造PKRevealController对象
//    self.revealController = [PKRevealController revealControllerWithFrontViewController:tabBarController leftViewController:leftFaceController options:nil];
    
    self.revealController = [PKRevealController revealControllerWithFrontViewController:tabBarController leftViewController:nil options:nil];
    //
    //对导航栏定制 start
    [[UINavigationBar appearance] setBarTintColor:APPFRAME_COLOR];//UIColorFromRGB(0x067AB5)];
    //[UINavigationBar appearance].translucent  = YES;
    [[UINavigationBar appearance] setTintColor:WHITE_COLOR];
    
    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
//    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //对导航栏定制 end
    //对tab栏定制 start
    [[UITabBar appearance] setBackgroundImage: [UIImage imageWithColor:TINT_COLOR]];
    //隐藏那条黑线
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:APPFRAME_COLOR]];
    [[UITabBar appearance] setTintColor:APPFRAME_COLOR];//UIColorFromRGB(0x067AB5)];
    
//    UITabBarController *tabbarVc = (UITabBarController *)self.window.rootViewController;
//    tabbarVc.delegate = self;
    //
   
    //将其PKRevealController对象作为RootViewController
    self.window.backgroundColor = WHITE_COLOR;
    self.window.rootViewController = self.revealController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
