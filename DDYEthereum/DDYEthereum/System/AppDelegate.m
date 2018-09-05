#import "AppDelegate.h"
#import "ViewController.h"
#import "DDYEtherListVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[DDYEtherListVC new]];
    [_window makeKeyAndVisible];
    return YES;
}

@end
