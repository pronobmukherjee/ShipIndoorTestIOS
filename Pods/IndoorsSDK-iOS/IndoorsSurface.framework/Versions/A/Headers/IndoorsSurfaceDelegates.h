#ifndef IndoorsSurface_IndoorsSurfaceDelegates_h
#define IndoorsSurface_IndoorsSurfaceDelegates_h

@class IDSCoordinate;
@class IndoorsError;
@class IDSBuilding;

@protocol IndoorsSurfaceServiceDelegate <NSObject>
@optional
- (void)connected;
- (void)onError:(IndoorsError *)indoorsError;
- (void)loadingBuilding:(NSNumber *)progress;
- (void)buildingLoaded:(IDSBuilding *)building;
- (void)loadingBuildingFailed;
@end

@protocol IndoorsSurfaceLocationDelegate <NSObject>
@optional
- (void)updateFloorLevel:(int)floorLevel name:(NSString *)name;
- (void)updateUserPosition:(IDSCoordinate *)userPosition;
- (void)updateUserOrientation:(float)orientation;
- (void)weakSignal;
- (void)zonesEntered:(NSArray *)zones;
- (void)updateContext:(IDSContext *)context;
@end

#endif
