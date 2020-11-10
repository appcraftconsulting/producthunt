![Swift](https://github.com/appcraftstudio/producthunt/workflows/Swift/badge.svg)

# Product Hunt badge for iOS. 

### [Product Hunt](https://www.producthunt.com) surfaces the best new products, every day. It's a place for product-loving enthusiasts to share and geek out about the latest mobile apps, websites, hardware projects, and tech creations.

>[...] Product Hunt has become a must-read site in Silicon Valley.
<img src="https://github.com/appcraftstudio/producthunt/raw/master/Images/theverge.png" width="119">

>[...] Product Hunt is an online community that caters to the tech product fanatics.
<img src="https://github.com/appcraftstudio/producthunt/raw/master/Images/venturebeat.png" width="167">

>[Product Hunt] ballooned in popularity since its humble beginnings and has since become a destination site where folks could submit and vote on their favorite tech products.
<img src="https://github.com/appcraftstudio/producthunt/raw/master/Images/techcrunch.png" width="161">

>[...] Product Hunt has evolved from a small email list into a must-read for those in the tech and startup space to discover the next great product.
<img src="https://github.com/appcraftstudio/producthunt/raw/master/Images/businessinsider.png" width="75">

<p align="center">
<br>
<img src="https://github.com/appcraftstudio/producthunt/raw/master/Images/screenshot-button.PNG" width="320">
<img src="https://github.com/appcraftstudio/producthunt/raw/master/Images/screenshot-post-page.PNG" width="320">
</p>

## Features

- [X] Dark mode support
- [X] Data persistence
- [X] Auto refresh every 5 minutes

## Requirements

- Swift 5.0
- Xcode 11.x

## Implement Product Hunt - UIKit

1. Import the ProductHunt framework in your `UIApplicationDelegate`:
```swift
import ProductHunt
```
2. Configure the `PHManager` shared instance in your app's `application:didFinishLaunchingWithOptions:` method with:
- The post that will be linked to the `PHButton` (either defined by slug or id)
- Your Product Hunt developer token (https://www.producthunt.com/v2/oauth/applications)

```swift
PHManager.shared.configure(forPost: .slug("timizer"), token: "<YOUR_PRODUCT_HUNT_TOKEN>")
```
3. In the view controller, override the `viewDidLoad` method to set the presenting view controller of the `PHManager` object.
```swift
PHManager.shared.presentingViewController = self
```
4. Add a `PHButton` to your storyboard, XIB file, or instantiate it programmatically. To add the button to your storyboard or XIB file, add a View and set its custom class to `PHButton`.

<p align="center">
<br>
<img src="https://github.com/appcraftstudio/producthunt/raw/master/Images/snapshot-product-hunt-button.png" width="260">
</p>

## Implement Product Hunt - SwiftUI

1. Import the ProductHunt framework in your view struct:
```swift
import ProductHunt
```

2. Add the `ProductHuntButton` to your view with:
- The post that will be linked to the button (either defined by slug or id)
- Your Product Hunt developer token (https://www.producthunt.com/v2/oauth/applications)

```swift
ProductHuntButton(post: .slug("<YOUR_SLUG>"), token: "<YOUR_PRODUCT_HUNT_TOKEN>")
  .frame(width: 260.0, height: 60.0, alignment: .center)
  .padding(10.0)
```

<p align="center">
<br>
<img src="https://github.com/appcraftstudio/producthunt/raw/master/Images/snapshot-product-hunt-button-swiftui.png" width="260">
</p>

## Installation

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

You want to add pod `'ProductHunt', '~> 1.0'` similar to the following to your Podfile:
```rb
target 'MyApp' do
  pod 'ProductHunt', '~> 1.0'
end
```
Then run a `pod install` inside your terminal, or from CocoaPods.app.

### [Swift Package Manager](https://swift.org/package-manager/)

1. Using Xcode 11 or above go to *File* > *Swift Packages* > *Add Package Dependency*
2. Paste the project URL: https://github.com/appcraftstudio/producthunt.git
3. Click on next and select the project target


## Contributors ✨

| Name                | GitHub                                       | Twitter                                                |
| :------------------ | :------------------------------------------- | :---------------------------------------------------- |
| **François Boulais** | [**frboulais**](https://github.com/frboulais) | [**@frboulais**](https://twitter.com/frboulais) |
| **Julien Lacroix** | [**JulienLacr0ix**](https://github.com/JulienLacr0ix) | [**@JulienLacr0ix**](https://twitter.com/JulienLacr0ix) |


---

<a href="https://www.producthunt.com/posts/product-hunt-badge-for-ios-2?utm_source=badge-featured&utm_medium=badge&utm_souce=badge-product-hunt-badge-for-ios-2" target="_blank"><img src="https://api.producthunt.com/widgets/embed-image/v1/featured.svg?post_id=263397&theme=dark" alt="Product Hunt badge for iOS - Swift framework to add Product Hunt badge in your iOS apps! | Product Hunt Embed" style="width: 250px; height: 54px;" width="250" height="54" /></a>

<a href="https://www.buymeacoffee.com/appcraftstudio" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

Copyright © 2020 App Craft Studio. All rights reserved.
