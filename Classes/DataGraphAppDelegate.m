

#import "DataGraphAppDelegate.h"
#import "DataGraphViewController.h"

@implementation DataGraphAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
    //NSLog(@"App Delegate Launched");
    
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}




@end
