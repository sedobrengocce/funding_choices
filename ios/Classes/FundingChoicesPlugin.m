#import "FundingChoicesPlugin.h"
#if __has_include(<funding_choices/funding_choices-Swift.h>)
#import <funding_choices/funding_choices-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "funding_choices-Swift.h"
#endif

@implementation FundingChoicesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFundingChoicesPlugin registerWithRegistrar:registrar];
}
@end
