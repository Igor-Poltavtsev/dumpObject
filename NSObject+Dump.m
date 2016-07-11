//
//  NSObject+Dump.m
//
//  Created by Igor Poltavtsev on 10.07.16.
//  Copyright © 2016 kupivip.ru. All rights reserved.
//

#import "NSObject+Dump.h"

@implementation NSObject (Dump)

- (void)dumpObject:(id)object {
    
#ifdef DEBUG
    
    NSString *string;
    if ([object isKindOfClass:[NSArray class]])
        string = ((NSArray*)object).description;
    else if ([object isKindOfClass:[NSDictionary class]])
        string = ((NSDictionary*)object).description;
    else return;
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"@@**@@"];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSMutableString *resultString = @"".mutableCopy;
    NSString *buf = nil;
    
    while (![scanner isAtEnd] ) {
        if ([scanner scanUpToString: @"\\U" intoString: &buf])
            [resultString appendString: buf];
        if ([scanner isAtEnd]) break;
        [scanner setScanLocation: [scanner scanLocation] + 3]; //skip the '\U'
        unsigned c = 0;
        [resultString appendString: [scanner scanHexInt: &c] ? [NSString stringWithFormat:@"%C", (unichar)c] : @"\\U"];
    }
    string = [resultString stringByReplacingOccurrencesOfString:@"@@**@@" withString:@" "];
    
    resultString = [NSMutableString string];
    scanner = [NSScanner scannerWithString:string];
    
    while (![scanner isAtEnd] ) {
        if ([scanner scanUpToString: @"%" intoString: &buf])
            [resultString appendString: buf];
        if ([scanner isAtEnd]) break;
        NSString *percent = [string substringWithRange:NSMakeRange([scanner scanLocation], 3)];
        if (![percent stringByRemovingPercentEncoding])
            percent = [string substringWithRange:NSMakeRange([scanner scanLocation], 6)];
        if (![percent stringByRemovingPercentEncoding])
            percent = [string substringWithRange:NSMakeRange([scanner scanLocation], 9)];
        if (![percent stringByRemovingPercentEncoding])
            percent = [string substringWithRange:NSMakeRange([scanner scanLocation], 12)];
        [scanner setScanLocation: [scanner scanLocation] + percent.length]; //skip the '%'
        [resultString appendString:[percent stringByRemovingPercentEncoding] ? [percent stringByRemovingPercentEncoding] : percent];
    }
    
    NSLog(@"%@", resultString);
    
#endif
    
}

@end
