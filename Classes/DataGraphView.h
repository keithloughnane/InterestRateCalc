

#import <UIKit/UIKit.h>
#import "DataGraphAppDelegate.h"
#import "DataClass.h"
//#import <NSD



@interface DataGraphView : UIView {

    /*This uses a Mutable Array DataSets which contains all the datasets you need to
     draw. Each dataSet is it's seleft a mutable array containing the points you wish
     to draw. So    Dataset->GraphData->Points  */
    
    
    IBOutlet DataClass *myData;
    
}

//@property (nonatomic, retain) NSMutableArray dataSets;
@property (nonatomic, assign) IBOutlet NSMutableArray* dataSets;
@property (nonatomic, assign) IBOutlet DataClass* myData;
//- (void)insertNewSet:(NSMutableArray*)dataSet;
- (CGGradientRef)backgroundGradient;


- (void)takeDataAndAutoConvertToDataSet;
//- (void)test;
//- (NSMutableArray*)getDataSet;
- (IBAction)redraw;
- (void)draw;

@end
