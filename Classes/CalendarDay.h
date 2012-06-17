#import <UIKit/UIKit.h>
#import "CalendarEntity.h"

#define TIME_LINES_X		50.0
#define LINE_TEXT_X			5.0
#define LINE_TEXT_DY		-9.0
#define LINE_TEXT_BIG_DY	-16.0
#define LINE_TEXT_SUB_DY	6.0
#define LINE_FONT_SIZE		13.0
#define LINE_BIG_FONT_SIZE	20.0

#define BG_BLACK			0.05
#define LINES_WHITE			0.9

#define OVERFLOW_TOP		20.0

@interface CalendarDay : CalendarEntity {	
}

- (float)yPosFromTime:(NSTimeInterval)time;
- (NSString*)dateStringFromTime:(NSTimeInterval)time withFormat:(NSString*)format;

- (void)drawHourLine:(NSTimeInterval)time inContext:(CGContextRef)context;
- (void)drawDayLine:(NSTimeInterval)time inContext:(CGContextRef)context;
- (void)drawLineAtY:(int)yPos inContext:(CGContextRef)context;

@end
