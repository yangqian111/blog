//
//  AppDelegate.m
//  APP-2
//
//  Created by 羊谦 on 2016/10/27.
//  Copyright © 2016年 羊谦. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 9.0之后
//-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
//    
//}


// 因为现在xcode8 最低支持8.0 所以  我还是用这个方法吧
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    //获取根控制器
    UINavigationController *nvc = (UINavigationController *)self.window.rootViewController;
//    ViewController *vc = nvc.childViewControllers.firstObject;
    
    //每次跳转都必须要在根控制器 这一点比较重要
    [nvc popToRootViewControllerAnimated:YES];
    
    //根据url判断需要展示的VC
    if ([url.absoluteString containsString:@"VC1"]) {
        ViewController1 *vc1 = [[ViewController1 alloc] init];
//        [vc presentViewController:vc1 animated:YES completion:nil];
        [nvc pushViewController:vc1 animated:YES];
    }else if([url.absoluteString containsString:@"VC2"]){
        ViewController2 *vc2 = [[ViewController2 alloc] init];
        [nvc pushViewController:vc2 animated:YES];
    }
    
    return YES;
}


@end
