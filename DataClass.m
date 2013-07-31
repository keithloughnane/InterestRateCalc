//
//  DataClass.m
//  MonthlyInterest
//
//  Created by keith.loughnane on 27/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import "DataClass.h"


@implementation DataClass
-(id)init
{
    //NSLog(@"INITEDINTEDINTED");
    setUp = false;
    return self;
}

-(void)setData:(int)data
{
    //NSLog(@"Val has been set to >> %d",data);
    //d = data;
}
-(void)printData
{
   // NSLog(@"Val is set to >> %d",d);
}
-(void)addObject:(NSMutableArray *)obj
{
   // NSLog(@"DataClass adding Object(count %d) count is %d",[(NSMutableArray *)obj count],[dataSets count]);
    [dataSets addObject:obj];
   // NSLog(@"Count again %d",[dataSets count]);
    
    setUp = true;
}
-(bool)isSetUp
{
    return setUp;
}
- (NSMutableArray*)getDataSet
{
    
    return dataSets;
}
- (void)initData
{
    dataSets = [[NSMutableArray alloc]initWithCapacity:100];
}
-(int)count
{
    //NSLog(@"Count in DataClass called %d",[dataSets count]);
    return [dataSets count];
}
-(void)inputScale:(double)iScaleX :(double)iScaleY
{
    scaleX = iScaleX;
    scaleY = iScaleY;
    //NSLog(@"Scale has been set to (%f,%f)",scaleX,scaleY);
}
-(void)setPayment:(double)p payments:(double)m
{
    payments = p;
    monthPayment = m;
}
-(double) getPayment
{
    return payments;
}
-(double) getMonthPayment
{
    return monthPayment;
}
-(double) getXScale
{
    return scaleX;
}

-(double) getYScale
{
    return scaleY;
}
@end
