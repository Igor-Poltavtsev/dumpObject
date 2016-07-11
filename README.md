# dumpObject (with nested NSArrays and NSDictionary)
This extension of NSObject prints a log of nested objects of NSArray and NSDictionary with decoded unicode and percent encoded symbols

For example:

Standard way:

NSArray *array = @[@{@"firstName":@"Марк"},@{@"lastName":@"Цекурберг"}];
NSLog(@"array %@", array);
=== result ===
array (
        {
        firstName = "\U041c\U0430\U0440\U043a";
    },
        {
        lastName = "\U0426\U0435\U043a\U0443\U0440\U0431\U0435\U0440\U0433";
    }
)
I want to get this:

dumpObject way:

NSArray *array = @[@{@"firstName":@"Марк"},@{@"lastName":@"Цекурберг"}];
[self dumpObject:array];
=== result ===
array (
        {
        firstName = "Марк";
    },
        {
        lastName = "Цукерберг";
    }
)
