//
//  UIDevice+XWCategory.m
//  XWCarCost
//
//  Created by smile.zhang on 15/7/27.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import "UIDevice+XWCategory.h"
#include <netdb.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <stdio.h>
#include <net/ethernet.h>
#include <errno.h>
#import <CommonCrypto/CommonDigest.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CFNetwork/CFNetwork.h>
#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>
#import <AVFoundation/AVFoundation.h>

@implementation UIDevice (XWCategory)
// 获取设备MAC地址，AABBCCDDEEFF
+ (NSString * )macAddresses{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

+ (NSString *)idfaString {
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }else{
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        if(asIdentifierMClass == nil){
            return @"";
        }else{
            //for no arc
            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
            //for arc
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            }else{
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

+ (NSString *)idfvString{
    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
        return [self deviceUUIDString];
    }
    return @"";
}


// 获取设备IP地址
#define BUFFERSIZE  4000
#define min(a,b)    ((a) < (b) ? (a) : (b))
#define max(a,b)    ((a) > (b) ? (a) : (b))

+ (NSString *)WLANIPAddresses{
    int                 len, flags;
    char                buffer[BUFFERSIZE], *ptr, *cptr;
    struct ifconf       ifc;
    struct ifreq        *ifr, ifrcopy;
    struct sockaddr_in  *sin;
    
    char temp[80];
    
    int sockfd;
    
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0){
        perror("socket failed");
        return nil;
    }
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) < 0){
        perror("ioctl error");
        return nil;
    }
    
    for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
        ifr = (struct ifreq *)ptr;
        len = max(sizeof(struct sockaddr), ifr->ifr_addr.sa_len);
        ptr += sizeof(ifr->ifr_name) + len;  // for next one in buffer
        
        if (ifr->ifr_addr.sa_family != AF_INET){
            continue;   // ignore if not desired address family
        }
        
        if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL){
            *cptr = 0;      // replace colon will null
        }
        
        //  以太网
        if (strncmp("en0", ifr->ifr_name, IFNAMSIZ) == 0){
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            flags = ifrcopy.ifr_flags;
            if ((flags & IFF_UP) == 0){
                continue;   // ignore if interface not up
            }
            
            sin = (struct sockaddr_in *)&ifr->ifr_addr;
            strcpy(temp, inet_ntoa(sin->sin_addr));
            break;
        }
    }
    
    close(sockfd);
    return [[NSString alloc] initWithCString:temp encoding:NSASCIIStringEncoding];
}

+ (NSString *)getHWAddresses{
    struct ifconf ifc;
    struct ifreq *ifr;
    int  sockfd;
    char buffer[BUFFERSIZE], *cp, *cplim;
    char temp[80];
    
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0){
        perror("socket failed");
        return nil;
    }
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, (char *)&ifc) < 0){
        perror("ioctl error");
        close(sockfd);
        return nil;
    }
    
    ifr = ifc.ifc_req;
    
    cplim = buffer + ifc.ifc_len;
    
    for (cp=buffer; cp < cplim; ){
        ifr = (struct ifreq *)cp;
        if (ifr->ifr_addr.sa_family == AF_LINK){
            struct sockaddr_dl *sdl = (struct sockaddr_dl *)&ifr->ifr_addr;
            int a,b,c,d,e,f;
            
            //  以太网
            if (strncmp("en0", ifr->ifr_name, IFNAMSIZ) == 0){
                strcpy(temp, (char *)ether_ntoa((struct ether_addr *)LLADDR(sdl)));
                sscanf(temp, "%x:%x:%x:%x:%x:%x", &a, &b, &c, &d, &e, &f);
                NSString *mac = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",a,b,c,d,e,f];
                return mac;
            }
            
        }
        cp += sizeof(ifr->ifr_name) + max(sizeof(ifr->ifr_addr), ifr->ifr_addr.sa_len);
    }
    
    close(sockfd);
    return nil;
}

#pragma mark - 网络状态变化通知
+ (id)fetchSSIDInfo{
    NSArray *ifs = (__bridge NSArray *)(CNCopySupportedInterfaces());
    
    id info = nil;
    
    // 枚举接口
    for (NSString *ifnam in ifs){
        info = (__bridge id)(CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam));
        if (info && [info count]){
            break;
        }
    }
    return info;
}

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleIdentifier{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)appBuild{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)sysVersion{
    return [NSString stringWithFormat:@"%@%@",[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
}

+ (NSString *)deviceUUIDString{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)deviceUUID{
    NSString *outstring = [self deviceUUIDString];
    // 去掉中间的横线
    outstring = [outstring stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return outstring;
}

+ (NSString *)deviceModel{
    return [UIDevice currentDevice].model;
}

+ (NSString *)deviceModelType{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro (Cellular)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

@end
