//
//  IDViewController.m
//  MyFirstIndoorsApp
//
//  Copyright (c) 2013 indoo.rs GmbH. All rights reserved.
//

#import "IDViewController.h"
#import <Indoors/IndoorsBuilder.h>
#import <IndoorsSurface/IndoorsSurfaceBuilder.h>
#import <IndoorsSurface/IndoorsSurfaceDelegates.h>

@interface IDViewController () <IndoorsSurfaceLocationDelegate, IndoorsSurfaceServiceDelegate, RoutingDelegate>
@property (nonatomic, strong) IndoorsSurfaceBuilder *surfaceBuilder;
@end

@implementation IDViewController
@synthesize surfaceBuilder;

- (void)viewDidLoad
{
    [super viewDidLoad];

    IndoorsBuilder *builder = [[IndoorsBuilder alloc] init];

    // TODO: replace with your API-key
    [builder setApiKey:@"cf81642a-ca39-4bd1-ae09-b3bb6a377f76"];
    // TODO: replace with your building ID
    [builder setBuildingId:260092219];
    [builder enableEvaluationMode:YES];

    surfaceBuilder = [[IndoorsSurfaceBuilder alloc] initWithIndoorsBuilder:builder inView:self.view];
    //for routing
    surfaceBuilder.indoorsSurface.routeSnappingEnabled = YES;
    //for routing
    [surfaceBuilder registerForSurfaceServiceUpdates:self];

    [surfaceBuilder setZoneDisplayMode:IndoorsSurfaceZoneDisplayModeUserCurrentLocation];
//    [surfaceBuilder setZoneDisplayMode:IndoorsSurfaceZoneDisplayModeAllAvailable];
    [surfaceBuilder setUserPositionDisplayMode:IndoorsSurfaceUserPositionDisplayModeDefault];

    [surfaceBuilder build];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Service Delegate

- (void)connected
{
    [surfaceBuilder registerForSurfaceLocationUpdates:self];
    NSLog(@"Connected");
}

- (void)onError:(IndoorsError *)indoorsError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to authenticate with your API key" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)loadingBuilding:(NSNumber *)progress
{
    NSLog(@"loading building: %@", progress);
}

- (void)buildingLoaded:(IDSBuilding *)building
{
    NSLog(@"building loaded!");
    self.currentBuilding = building;
}

- (void)loadingBuildingFailed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to load building" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - IndoorsSurfaceLocationManagerDelegate

- (void)updateFloorLevel:(int)floorLevel name:(NSString *)name
{
}

- (void)updateUserPosition:(IDSCoordinate *)userPosition
{
    NSLog(@"position updated: %@", userPosition);
    [self calculateRoute:userPosition];
}

- (void)updateUserOrientation:(float)orientation
{
}

- (void)weakSignal
{
}

- (void)positionUpdated:(IDSCoordinate *)userPosition
{
    if (self.currentBuilding) {
        CLLocation* location = [IndoorsCoordinateUtil geoLocationForCoordinate:userPosition inBuilding:self.currentBuilding];
        [self calculateRoute:userPosition];
        NSLog(@"current gps position is %@", location);
    } else {
        NSLog(@"this should not happen. building not initialized, but position calculated");
    }
//    I could not find the column named 'id'
}

- (void)calculateRoute:(IDSCoordinate *)userPosition
{
    IDSCoordinate* start = [[IDSCoordinate alloc] initWithX:userPosition.x andY:userPosition.y andFloorLevel:userPosition.z];
    IDSCoordinate* end = [[IDSCoordinate alloc] initWithX:38268 andY:7152 andFloorLevel:userPosition.z];
    
    [[Indoors instance] routeFromLocation:start toLocation:end delegate:self];
}

// ...

#pragma mark - RoutingDelegate
- (void)setRoute:(NSArray *)path
{
    [self.surfaceBuilder showPathWithPoints:path];
}

@end
