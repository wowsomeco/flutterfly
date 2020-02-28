#import "FlutterflyPlugin.h"
#if __has_include(<flutterfly/flutterfly-Swift.h>)
#import <flutterfly/flutterfly-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutterfly-Swift.h"
#endif

@implementation FlutterflyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterflyPlugin registerWithRegistrar:registrar];
}
@end
