//
//  smyayaAppDelegate.m
//  testing 2
//
//  Created by John on 6/1/13.
/*  This objective C Coding completed by Chris Dollinger.
Except where code is from snippets or other examples, this
original code by Chris Dollinger is hereby released under
GNU General Public License.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

TEAM:
John Amoratis, Project Founder
Chris Dollinger, Lead Programmer
Kurt Floyd, Lead Graphic Designer
*/

#import "smyayaAppDelegate.h"

@implementation smyayaAppDelegate

/*- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *urlToSave = [NSString stringWithFormat:@"%@", url];
    urlToSave = [urlToSave substringWithRange:NSMakeRange(6, [urlToSave length] - 6)];
    urlToSave = [NSString stringWithFormat:@"http%@", urlToSave];
    
    [[NSUserDefaults standardUserDefaults] setObject:urlToSave forKey:@"schemaToDownload"];
    
    UITabBarController *tabb = (UITabBarController *)self.window.rootViewController;
    
    if (tabb.selectedIndex == 3)
        tabb.selectedIndex = 4;
    
    tabb.selectedIndex = 3;
    
    return YES;
}*/


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    NSLog(@"url is ");
    NSLog(@"url is %@",url);
    NSString *urlToSave = [NSString stringWithFormat:@"%@", url];
    urlToSave = [urlToSave substringWithRange:NSMakeRange(6, [urlToSave length] - 6)];
    urlToSave = [NSString stringWithFormat:@"http%@", urlToSave];
    
    [[NSUserDefaults standardUserDefaults] setObject:urlToSave forKey:@"schemaToDownload"];
    
    UITabBarController *tabb = (UITabBarController *)self.window.rootViewController;
    
    if (tabb.selectedIndex == 3)
        tabb.selectedIndex = 4;
    
    tabb.selectedIndex = 3;
    
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
