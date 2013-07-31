//
//  DataClass.h
//  MonthlyInterest
//
//  Created by keith.loughnane on 27/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataClass:NSObject {
    double scaleX,scaleY;
    NSMutableArray *dataSets;
    double payments;
    double monthPayment;
    bool setUp;

    
}
-(void)setData:(int)data;
-(void)printData;
- (NSMutableArray*)getDataSet;
-(void)addObject:(NSMutableArray *)obj;
-(int)count;
-(void)inputScale:(double)iScaleX :(double)iScaleY;
- (void)initData;
-(double) getXScale;
-(double) getYScale;

-(void)setPayment:(double)p payments:(double)m;
-(bool)isSetUp;

-(double) getPayment;
-(double) getMonthPayment;



@end
