import Foundation
let directory = "ios/App/App/Assets.xcassets/AppIcon.appiconset"
let source = "www/assets/fabricate-app-icon.png"
let manager = FileManager.default
try manager.createDirectory(atPath: directory, withIntermediateDirectories: true)
let image = try Data(contentsOf: URL(fileURLWithPath: source))
try image.write(to: URL(fileURLWithPath: directory + "/AppIcon.png"), options: .atomic)
let contents = """
{"images":[{"filename":"AppIcon.png","idiom":"universal","platform":"ios","size":"1024x1024"}],"info":{"author":"xcode","version":1}}
"""
try contents.write(toFile: directory + "/Contents.json", atomically: true, encoding: .utf8)
