import AppKit
let directory="ios/App/App/Assets.xcassets/AppIcon.appiconset"
try FileManager.default.createDirectory(atPath: directory,withIntermediateDirectories:true)
guard let source=NSImage(contentsOfFile:"www/assets/fib-point.png"),let bitmap=NSBitmapImageRep(bitmapDataPlanes:nil,pixelsWide:1024,pixelsHigh:1024,bitsPerSample:8,samplesPerPixel:3,hasAlpha:false,isPlanar:false,colorSpaceName:.deviceRGB,bytesPerRow:0,bitsPerPixel:0) else { fatalError("Could not load Fib icon") }
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current=NSGraphicsContext(bitmapImageRep:bitmap)
NSColor(calibratedRed:7/255.0,green:26/255.0,blue:43/255.0,alpha:1).setFill()
NSBezierPath(rect:NSRect(x:0,y:0,width:1024,height:1024)).fill()
source.draw(in:NSRect(x:70,y:70,width:884,height:884),from:.zero,operation:.sourceOver,fraction:1)
NSGraphicsContext.restoreGraphicsState()
try bitmap.representation(using:.png,properties:[:])!.write(to:URL(fileURLWithPath:directory+"/AppIcon.png"))
let contents="""
{"images":[{"filename":"AppIcon.png","idiom":"universal","platform":"ios","size":"1024x1024"}],"info":{"author":"xcode","version":1}}
"""
try contents.write(toFile:directory+"/Contents.json",atomically:true,encoding:.utf8)
