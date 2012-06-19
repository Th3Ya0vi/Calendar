#import "CalendarController.h"

@implementation CalendarController

@synthesize scrollView=_scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	_calendar = [[Calendar alloc] init];
	_pixelsPerHour = PIXELS_PER_HOUR;
	_calendarDays = [[NSMutableDictionary alloc] init];
	
	[self setToday:[self floorTimeToStartOfDay:[[NSDate date] timeIntervalSinceReferenceDate]]];
	
	CGSize totalSize = CGSizeMake(PIXELS_PER_DAY * 3, 480.0);
	[_scrollView setContentSize:totalSize];
}

#pragma mark -
#pragma mark CalendarController Methods

- (void)createDayControllerForStartTime:(NSTimeInterval)startTime {
	CalendarDayController *dayController;
	
	if ([_calendarDays objectForKey:[NSNumber numberWithInt:startTime]] != nil) {
		dayController = [_calendarDays objectForKey:[NSNumber numberWithInt:startTime]];
	} else {
		dayController = [[CalendarDayController alloc] initWithStartTime:startTime andDelegate:self];
		[_calendarDays setObject:dayController forKey:[NSNumber numberWithInt:startTime]];
	}

	if (![dayController.view superview]) {
		[_scrollView addSubview:dayController.view];
	}
	
	CGRect frame = dayController.view.frame;
	frame.origin.x = ((int)startTime - (int)_yesterday) / SECONDS_PER_DAY * PIXELS_PER_DAY;
	[dayController.view setFrame:frame];
}

- (void)setToday:(NSTimeInterval)today {
	_today = today;
	_yesterday = [self floorTimeToStartOfDay:(_today - SECONDS_PER_DAY)];
	_tomorrow = [self floorTimeToStartOfDay:(_today + SECONDS_PER_DAY)];
	
	NSEnumerator *e = [_calendarDays objectEnumerator];
	CalendarDayController *calDay;
	while (calDay = [e nextObject]) {
		if ([calDay startTime] != _today) {
			[calDay.view removeFromSuperview];
		}
    }
	
	[self createDayControllerForStartTime:_today];
	[self createDayControllerForStartTime:_yesterday];
	[self createDayControllerForStartTime:_tomorrow];
	
	[_scrollView setContentOffset:CGPointMake(PIXELS_PER_DAY, 0) animated:NO];
}

#pragma mark -
#pragma mark CalendarDayDelegate Methods

- (NSTimeInterval)pixelToTimeOffset:(float)pixel {
	return pixel / _pixelsPerHour * SECONDS_PER_HOUR;
}

- (float)timeOffsetToPixel:(NSTimeInterval)time {
	return time / (float)SECONDS_PER_HOUR * _pixelsPerHour;
}

- (float)getPixelsPerHour {
	return _pixelsPerHour;
}

- (NSInteger)calendarHourFromTime:(NSTimeInterval)time {
	NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:time];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:date];
	NSInteger calHour = [components hour];
	return calHour;
}

- (NSTimeInterval)floorTimeToStartOfDay:(NSTimeInterval)time {
	NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:time];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];

	int modTime = [components hour] * SECONDS_PER_HOUR + [components minute] * SECONDS_PER_MINUTE + [components second];
	if (modTime == SECONDS_PER_DAY) return time;
	return time - modTime;
}

- (int)dayWidth {
	// TODO: This is hardcoded for now, but will be dynamic later
	return PIXELS_PER_DAY;
}

- (void)showCategoryChooser {
	CategoryChooserController *catController = [[CategoryChooserController alloc] initWithCalendar:_calendar andDelegate:self];
	[self.view addSubview:catController.view];
}

#pragma mark -
#pragma mark CategoryChooserDelegate Methods

- (void)categoryChooser:(CategoryChooserController*)chooser didSelectCategory:(Category*)cat {
	[[_calendarDays objectForKey:[NSNumber numberWithInt:_today]] chooseCategory:cat];
	[chooser.view removeFromSuperview];
	[chooser release];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if ([scrollView contentOffset].x == 0) {
		_today -= SECONDS_PER_DAY;
	} else if ([scrollView contentOffset].x == PIXELS_PER_DAY * 2) {
		_today += SECONDS_PER_DAY;
	}
	
	[self setToday:_today];
}

#pragma mark -
#pragma mark ViewController Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end