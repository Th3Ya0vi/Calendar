#import <UIKit/UIKit.h>
#import "LayerDelegate.h"

@interface CalendarEntity : UIView {
    LayerDelegate *_sublayerDelegate;
    
    NSTimeInterval _baseTime;
	NSTimeInterval _startTime;
	NSTimeInterval _endTime;
}

@property (nonatomic, setter=setStartTime:) NSTimeInterval startTime;
@property (nonatomic, setter=setEndTime:) NSTimeInterval endTime;

- (id)initWithBaseTime:(NSTimeInterval)baseTime startTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime;
- (void)drawInContext:(CGContextRef)context;

- (NSTimeInterval)size;

- (CGRect)reframe;

@end
