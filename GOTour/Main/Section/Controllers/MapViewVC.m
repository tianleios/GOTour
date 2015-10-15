//
//  MapViewVC.m
//  旅行
//
//  Created by 磊 田 on 15/10/10.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "MapViewVC.h"
//#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "MyAnnotationView.h"
@interface MapViewVC ()

@property (nonatomic, weak) MKMapView *mapView;
@end

@implementation MapViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.title = _locationName;
    //创建地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:mapView];
    _mapView = mapView;
    
    _mapView.scrollEnabled = YES;
    _mapView.scrollEnabled = YES;
//    MKMapTypeStandard = 0,
//    MKMapTypeSatellite,
//    MKMapTypeHybrid,
//    MKMapTypeSatelliteFlyover NS_ENUM_AVAILABLE(10_11, 9_0),
//    MKMapTypeHybridFlyove
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    //显示某块区域
    CGFloat lat1  = [_locationModel.lat doubleValue];
    CGFloat lng1 =  [_locationModel.lng doubleValue];
    
  CLLocationCoordinate2D td =CLLocationCoordinate2DMake(lat1,lng1);
   MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion regin = MKCoordinateRegionMake(td, span);
    
    [_mapView setRegion:regin animated:YES];
    //添加自定义大头针
    MyAnnotation *annotation = [[MyAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(lat1, lng1);
    annotation.title = _locationName;
    [_mapView addAnnotation:annotation];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MyAnnotationView *av = (MyAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"my"];
    if (av == nil) {
        av = [[MyAnnotationView alloc] init];
        
        av.image = [UIImage imageNamed:@"activity_location.png"];
    }

    return av;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
