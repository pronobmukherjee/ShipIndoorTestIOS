#import <Foundation/Foundation.h>

@interface IDSCoordinate : NSObject
/**
 * Horizontal distance in millimeter from the top-left origin.
 */
@property (nonatomic) NSInteger x;
/**
 * Vertical distance in millimeter from the top-left origin.
 */
@property (nonatomic) NSInteger y;
/**
 * Floor-ID
 */
@property (nonatomic) NSInteger z;
/**
 * Accuracy in mm (radius)
 */
@property (nonatomic) NSInteger accuracy;

- (instancetype)initWithX:(NSInteger)x andY:(NSInteger)y andFloorLevel:(NSInteger)z;
- (instancetype)initWithX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z accuracy:(NSInteger)accuracy;
- (NSMutableDictionary*) dictionaryWithBuildingId:(NSInteger)buildingId;
- (BOOL)isEqualToCoordinate:(IDSCoordinate*)coordinate;
@end
