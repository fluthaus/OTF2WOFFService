/*

 OTF2WOFFService - an OS X service to convert OTF files to WOFF files and vice versa.
 Copyright (C) 2011-2017 NoHalfBits | fluthaus (nohalfbits0x40fluthaus0x2Ede)
 Project available at https://github.com/fluthaus/OTF2WOFFService

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

 */

#import <Cocoa/Cocoa.h>
#import "OTF2WOFFService.h"

NSString* kO2W_ServiceName = @"OTF2WOFFService";
const NSTimeInterval kO2W_RunTime = 60.;

int main(int argc, const char * argv[])
{
	@autoreleasepool
	{
		NSRegisterServicesProvider( [[[OTF2WOFFService alloc] init] autorelease], kO2W_ServiceName);
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:kO2W_RunTime]];
	}
	return 0;
}
