# dumpObject (with nested NSArrays and NSDictionary)
This extension of NSObject prints a log of nested objects of NSArray and NSDictionary with decoded unicode and percent encoded symbols

Install:<br />
1. Copy NSObject+Dump.h and NSObject+Dump.m into your project<br />
2. in AppDelegate or .pch file add line
```
#import "NSObject+Dump.h"
```
3. In any NSObject class dump:
```
[self dumpObject:object];
```

<b>For example:</b>

Standard way:
```
NSArray *array = @[@{@"firstName":@"Марк%20%F0%9F%98%9C"},@{@"lastName":@"Цекурберг"}];
NSLog(@"array %@", array);
=== result ===
array (
        {
        firstName = "\U041c\U0430\U0440\U043a%20%F0%9F%98%9C";
    },
        {
        lastName = "\U0426\U0435\U043a\U0443\U0440\U0431\U0435\U0440\U0433";
    }
)
```
dumpObject way:
```
NSArray *array = @[@{@"firstName":@"Марк%20%F0%9F%98%9C"},@{@"lastName":@"Цекурберг"}];
[self dumpObject:array];
=== result ===
array (
        {
        firstName = "Марк 😜";
    },
        {
        lastName = "Цукерберг";
    }
)
```
