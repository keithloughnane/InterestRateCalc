

#import <UIKit/UIKit.h>
#import "DataGraphView.h"

@class DataGraphViewController;

@interface DataGraphAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DataGraphViewController *viewController;
    
   id *myGraph;
    
}




@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DataGraphViewController *viewController;

@end

