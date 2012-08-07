//
// Using CoreLocation on Mac OS X with command-line
// $ clang CoreLocationTest.m -framework cocoa -framework CoreLocation
// $ ./a.out 
// location service enabled
// 2011-12-01 21:03:01.839 a.out[10214:903] latitude,logitude : 35.606647, 140.695538
// 2011-12-01 21:03:01.842 a.out[10214:903] timestamp         : 2011-12-01 21:01:36 +0900
// tmiz moo@tmiz.net
//
//
#import <cocoa/cocoa.h>
#import <CoreLocation/CoreLocation.h>

@interface LLHolder : NSObject {
  double latitude;
  double longitude;
}

- (void)latitude:(double*)lat longitude:(double*)log;

- (void)logLonLat:(CLLocation*)location;
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
@end

@implementation LLHolder
- (void)latitude:(double*)lat longitude:(double*)log
{
  *lat = latitude;
  *log = longitude;
}

- (void)logLonLat:(CLLocation*)location
{
    CLLocationCoordinate2D coordinate = location.coordinate;
    latitude = coordinate.latitude;
    longitude = coordinate.longitude;

    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self logLonLat:newLocation];
    [pool drain];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
  latitude = 0.0;
  longitude = 0.0;
  CFRunLoopStop(CFRunLoopGetCurrent());
}
@end

id g_lm = nil;

int int_coreloc_enable() {
  if ([CLLocationManager locationServicesEnabled]) {
		g_lm = [[CLLocationManager alloc] init];
    return 1;
  }

  return 0;
}

void int_coreloc_get(double* lat, double* log) {
  LLHolder* obj = [[LLHolder alloc] init];
	[g_lm setDelegate:obj];
	[g_lm startUpdatingLocation];

  CFRunLoopRun();

  [obj release];

  [obj latitude: lat longitude: log];
}

// int main(int ac,char *av[])
// {
    // id obj = [[NSObject alloc] init];
    // id lm = nil;
    // if ([CLLocationManager locationServicesEnabled]) {
		// printf("location service enabled\n");
		// lm = [[CLLocationManager alloc] init];
		// [lm setDelegate:obj];
		// [lm startUpdatingLocation];
    // }

    // CFRunLoopRun();
    // [lm release];
    // [obj release];
    // return 0;
// }
