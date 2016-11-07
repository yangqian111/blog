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
//    return YES;
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
    //我这里直接通过APP1来判断了，比如要像支付宝或者微信之类的，会有一个特殊的参数表示 在SDK中写明了的
    }else if ([url.absoluteString containsString:@"APP1"]){
        NSLog(@"%@",url);
        
        //拿到源程序的
        NSString * urlschemes = [[url.absoluteString componentsSeparatedByString:@"//"][1] componentsSeparatedByString:@"?"][0];
        
        //拿到参数
        NSRange range = [url.absoluteString rangeOfString:@"?"];
        NSString *paramStr = [url.absoluteString substringFromIndex:range.location+1];//去除问号
        NSArray *params = [paramStr componentsSeparatedByString:@"&"];
        NSLog(@"%@",params);
        
        //跳回源程序
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 延时3s模拟处理后回调指定的 URL Schemes并传递结果
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"APP2://"]]) {
                
                NSLog(@"跳转成功");
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://back?name=back&code=200",urlschemes]]];
                
            }else{
                NSLog(@"跳转失败");
                NSLog(@"未安装应用!");
            }
        });
    }
    return YES;
}


@end
