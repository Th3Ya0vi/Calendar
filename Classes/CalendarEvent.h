#import <Foundation/Foundation.h>
#import "CalendarEntity.h"

#define BORDER_COLOR		[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define EVENT_DX			65.0

@interface CalendarEvent : CalendarEntity <UITextFieldDelegate> {
	UITextField *_textField;
}

- (void)setFocus;
- (void)drawInContext:(CGContextRef)context;

@end
