#import "BixparkPlugin.h"
#if __has_include(<bixpark/bixpark-Swift.h>)
#import <bixpark/bixpark-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bixpark-Swift.h"
#endif

@implementation BixparkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBixparkPlugin registerWithRegistrar:registrar];
}
@end
