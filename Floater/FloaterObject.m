//
//  FloaterObject.m
//  Floater
//
//  Created by Chris Dean on 2018-03-08.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "FloaterObject.h"

@implementation FloaterObject

- (instancetype)initWithDict:(NSDictionary*)floater {
    self = [super init];
    if (self) {
        NSArray *photosArray = floater[@"photos"];
        
        _blogName = floater[@"blog_name"];
        _iD = floater[@"id"];
        _tagsArray = floater[@"tags"];
       // _floaterArray
    }
    return self;
}

@end
//
//[
//{
//    "alt_sizes":
//    [
//    {
//        "height":
//        833,
//        "url":
//        "https://78.media.tumblr.com/tumblr_lrsf2vxPYU1qcw8igo1_1280.jpg",
//        "width":
//        600
//    },
//    {
//        "height":
//        750,
//        "url":
//        "https://78.media.tumblr.com/tumblr_lrsf2vxPYU1qcw8igo1_540.jpg",
//        "width":
//        540
//    },
//
//{
//    "blog_name":
//    "pitchersandpoets",
//    "can_like":
//    false,
//    "can_reblog":
//    false,
//    "can_reply":
//    false,
//    "can_send_in_message":
//    true,
//    "caption":
//    "<p><a href=\"http://findthosedetonators.tumblr.com/post/10413445586\">findthosedetonators</a>:</p>\n<blockquote>\n<p>ENTER SANDMAN</p>\n</blockquote>",
//    "date":
//    "2011-09-19 20:58:03 GMT",
//    "display_avatar":
//    true,
//    "format":
//    "html",
//    "id":
//    10413871154,
//    "image_permalink":
//    "http://pitchersandpoets.tumblr.com/image/10413871154",
//    "is_blocks_post_format":
//    false,
//    "note_count":
//    86,
//    "photos":
//    [],
//    "post_url":
//    "http://pitchersandpoets.tumblr.com/post/10413871154/findthosedetonators-enter-sandman",
//    "reblog":
//    {},
//    "reblog_key":
//    "SpQlLmh1",
//    "recommended_color":
//    null,
//    "recommended_source":
//    null,
//    "short_url":
//    "https://tmblr.co/ZhSWUx9ijn0o",
//    "slug":
//    "findthosedetonators-enter-sandman",
//    "state":
//    "published",
//    "summary":
//    "ENTER SANDMAN",
//    "tags":
//    [],
//    "timestamp":
//    1316465883,
//    "trail":
//    [],
//    "type":
//    "photo"
//},

