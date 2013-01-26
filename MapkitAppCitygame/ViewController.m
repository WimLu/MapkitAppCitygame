//
//  ViewController.m
//  MapkitAppCitygame
//
//  Created by Wim on 14/01/13.
//  Copyright (c) 2013 Wim. All rights reserved.
//

#import "ViewController.h"
//annotation klassen importeren
#import "JagerAnnotation.h"
#import "ProoiAnnotation.h"

#import "WebserviceConnection.h" //WS klasse importeren

@interface ViewController ()
@property CLLocationCoordinate2D userLocation;
@end

@implementation ViewController
@synthesize userLocation = _userLocation;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    //object van type WebserviceConnection
    WebserviceConnection *test =[[WebserviceConnection alloc] init];
    [test getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showLocation
{
    //Dwingt de kaart zich te beperken tot een regio van 800 op 800 rond de locatie van de gebruiker
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance
    (_userLocation, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region]
                   animated:YES];
}

//User locatie wordt geupdate
-	(void)mapView:(MKMapView *)mapView didUpdateUserLocation:
(MKUserLocation *)userLocation
{
    _userLocation = userLocation.coordinate;
    
    //Punt toevoegen aan de kaart
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(50.9377, 5.3458);
    //titel en subtitel geven aan het punt
    point.title = @"Opdracht2";
    point.subtitle = @"Dans!";
    
    [self.mapView addAnnotation:point];
    
    JagerAnnotation *jager = [[JagerAnnotation alloc] init];
    jager.titel = @"Groep1";
    jager.subTitel=@"We zijn je op het spoor!";
    CLLocationCoordinate2D test;    
    test.latitude = 50.9360;
    test.longitude = 5.3458;
    jager.coordinaat = test;
    
    [self.mapView addAnnotation:jager];

    
    JagerAnnotation *groep2 = [[JagerAnnotation alloc] init];
    groep2.titel = @"Groep2";
    groep2.subTitel=@"We zijn je op het spoor!";
    test.latitude = 50.9317;
    test.longitude = 5.3423;
    groep2.coordinaat = test;
    [self.mapView addAnnotation:groep2];
    
    
    ProoiAnnotation *prooi = [[ProoiAnnotation alloc] init];
    prooi.titel = @"Konijntje";
    prooi.subTitel=@"Je vindt me toch niet!";
    test.latitude = 50.9324;
    test.longitude = 5.3464;
    prooi.coordinaat = test;
    [self.mapView addAnnotation:prooi];

    
}

//methode wwordt opgeroepen bij plaatsen van pin op kaart
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
        MKAnnotationView *pinView = nil;
        //controleren of de annotatie == locatie gebruiker
        if(annotation != _mapView.userLocation)
        {
            if ([annotation isKindOfClass:[JagerAnnotation class]]) // Indien om het om een jager gaat
            {
                static NSString *defaultPinID = @"com.invasivecode.pin";
                pinView = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
                if ( pinView == nil )
                    pinView = [[MKAnnotationView alloc]
                               initWithAnnotation:annotation reuseIdentifier:defaultPinID];
                
                //pinView.pinColor = MKPinAnnotationColorGreen;
                pinView.canShowCallout = YES;
                //pinView.animatesDrop = YES;
                //de pin een custom image toewijzen
                pinView.image = [UIImage imageNamed:@"Elmer-Fudd-Hunting-icon.png"];
            }else if ([annotation isKindOfClass:[ProoiAnnotation class]]){ //Als het om de prooi gaat
                static NSString *defaultPinID = @"com.invasivecode.pin";
                pinView = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
                if ( pinView == nil )
                    pinView = [[MKAnnotationView alloc]
                               initWithAnnotation:annotation reuseIdentifier:defaultPinID];
                
                //pinView.pinColor = MKPinAnnotationColorGreen;
                pinView.canShowCallout = YES;
                //pinView.animatesDrop = YES;
                pinView.image = [UIImage imageNamed:@"Prooi.png"];            }
        }
        else {
            [_mapView.userLocation setTitle:@"Ik ben hier"];
        }
        return pinView;
}

- (IBAction)clearMap:(id)sender {
    [self.mapView removeAnnotations:self.mapView.annotations];  // remove any annotations that exist

}

- (IBAction)refresh:(id)sender {
    [self showLocation];
}

@end
