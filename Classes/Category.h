#import <Foundation/Foundation.h>

@interface Category : NSObject <NSCoding> {
	NSString *_name;
	UIColor *_color;
}

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;

+ (void)loadCategoriesFrom:(NSArray*)categories;
+ (NSArray*)allCategories;
+ (Category*)categoryByIdentifier:(NSString*)identifier;
+ (Category*)uncategorized;

+ (UIColor*)nextColor;

- (id)initWithName:(NSString*)name andColor:(UIColor*)color;
- (id)initAndRegisterWithName:(NSString*)name andColor:(UIColor*)color;

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
