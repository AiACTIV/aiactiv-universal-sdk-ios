# AiactivUniversalSDK

[![Version](https://img.shields.io/cocoapods/v/AiactivUniversalSDK.svg?style=flat)](https://cocoapods.org/pods/AiactivUniversalSDK)
[![Platform](https://img.shields.io/cocoapods/p/AiactivUniversalSDK.svg?style=flat)](https://cocoapods.org/pods/AiactivUniversalSDK)

Ads and Analytics Framework

## Prerequisites

- Target iOS 11.0 or higher
- Target tvOS 12.0 or higher
- Swift version 5.0 or higher

## Installation

### CocoadPods (preferred)

To use this Pod in your Xcode project, follow these steps:

1. Open your Podfile
2. Add the following code to it:

```javascript
pod 'AiactivUniversalSDK'
```

3. Run `pod install` in your terminal.

### Swift Package

To use this Swift Package in your Xcode project, follow these steps:

1. Open your project in Xcode.
2. Go to File > Swift Packages > Add Package Dependency.
3. Enter the URL of this repository https://github.com/AiACTIV/aiactiv-universal-sdk-ios and click Next.
4. Choose the version rule you want to use (e.g. "Up to Next Major") and click Next.
5. Select the target you want to add the package to and click Finish.
6. Import the AiactivUniversalSDK module in your Swift files where you want to use the SDK.

```javascript
import AiactivUniversalSDK
```

7. You're now ready to use the SDK in your app!

### Init

You need to add the following code to your Info.plist file and replace FILL_YOUR_WRITE_KEY_HERE with your write key:

```xml
<key>AiactivSDKConfig</key>
<dict>
  <key>writeKey</key>
	<string>FILL_YOUR_WRITE_KEY_HERE</string>
</dict>
```

By default, we use the same write key for both ads and analytics. If you want to use a different write key for ad network, you can add another key-value pair like this:

```xml
<key>AiactivSDKConfig</key>
<dict>
  <key>writeKey</key>
  <string>FILL_YOUR_WRITE_KEY_HERE</string>

  <key>writeKeyForAdNetwork</key>
  <string>FILL_YOUR_WRITE_KEY_HERE</string>
</dict>
```

Import the AiactivUniversalSDK module in your UIApplicationDelegate

```javascript
import AiactivUniversalSDK
```

Configure a AiactivUniversalSDK shared instance in your app delegate's application(_:didFinishLaunchingWithOptions:) method

```javascript
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    Aiactiv.start()


    return true
}
```

## Usage

### AdNetwork

#### Banner Ad

Create AdView with size and type is banner

```javascript
let adView = AdView()
adView.adSize = .rectangle
adView.adType = .banner
adView.unitID = NSNumber(value: <<<Find your inventory ID in container>>>)

// Add AdView to your layout
adView.translatesAutoresizingMaskIntoConstraints = false
self.view.addSubview(adView)

NSLayoutConstraint.activate([
    adView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    adView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
])

// Perform loadAd with a request
adView.loadAd(AdRequest())
```

**Predefined sizes:**

|     AdSize      | Width x Height |
| :-------------: | :------------: |
|     banner      |     320x50     |
|   fullBanner    |     468x60     |
|   largeBanner   |    320x100     |
|    rectangle    |    250x250     |
| mediumRectangle |    300x250     |
|      video      |    480x360     |

Or custom any size in format `widthxheight`. Example: 640x480, 300x500...

#### Adaptive Banner Ad

Create AdView in banner format with adaptive size

```javascript
let adView = AdView()
adView.adSize = .rectangle
adView.adType = .banner
adView.unitID = NSNumber(value: <<<Find your inventory ID in container>>>)

// Add AdView to your layout
self.view.addSubview(adView)
```

Set Banner Ad width, SDK will calculate height automatically base on Ad ratio
In this case, we will make same width with its parent

```javascript
adView.adaptiveSize(self.view.frame.width);
```

Perform loadAd with a request

```javascript
adView.loadAd(AdRequest());
```

#### Video Ad

To display a video ad, you need to use the VideoAdLoader function to get the vast tag URL from Aiactiv platform and then use your own player to play it.

```javascript
// Create AdView with size and type is video
let videoAdLoader = VideoAdLoader(adUnitID: <<<Find your inventory ID in container>>>, adSize: .video)

// Set delegate to retrieve data later
videoAdLoader.delegate = self

// Perform loadAd with a request
videoAdLoader.loadAd(AdRequest())

```

Listen event video ad loaded and perform playing

```javascript
extension ViewController: VideoAdLoaderDelegate {
	func videoAdLoader(_ unitID: Int64, vastTagURL url: String) {
        print("Video Ad Content URL: \(url)")
    }

    func videoAdLoader(_ unitID: Int64, didFailLoad error: AiactivSDKError) {
        print("Video Ad did fail to load with error: \(error.errorDescription ?? "Unknown")")
    }
}
```

#### Native Ad

##### Display NativeAdView

The first step is to lay out the UIViews that will display native ad assets. You can do this in the Interface Builder as you would when creating any other xib file.

Once the views are in place and you've assigned the correct ad view class to the layout, link the ad view's asset outlets to the UIViews you've created. Here's how you might link the ad view's asset outlets to the UIViews created for an ad:

![](assets/NativeAdViewBinding.png)

Or you can bind your views to NativeAdView programmatically. Example:

```javascript
let nativeAdView = NativeAdView()
nativeAdView.translatesAutoresizingMaskIntoConstraints = false
nativeAdView.backgroundColor = .systemGray

self.view.addSubview(nativeAdView)

let mainImageView = UIImageView(frame: .zero)
mainImageView.backgroundColor = .gray
mainImageView.translatesAutoresizingMaskIntoConstraints = false
self.nativeAdView.mainImage = mainImageView

let iconImageView = UIImageView(frame: .zero)
iconImageView.backgroundColor = .gray
iconImageView.translatesAutoresizingMaskIntoConstraints = false
self.nativeAdView.iconImage = iconImageView

let titleLabel = UILabel()
titleLabel.text = "Native Ad Title"
titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
titleLabel.numberOfLines = 1
titleLabel.lineBreakMode = .byTruncatingTail
titleLabel.translatesAutoresizingMaskIntoConstraints = false
self.nativeAdView.title = titleLabel

let descriptionLabel = UILabel()
descriptionLabel.text = "Native Ad Description"
descriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
descriptionLabel.numberOfLines = 2
descriptionLabel.lineBreakMode = .byTruncatingTail
descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
self.nativeAdView.desc = descriptionLabel
```

Once the layout is complete and the outlets are linked, the last step is to add code to your app that performs load an ad via `contentView`.

```javascript
@IBOutlet weak var adView: NativeAdView!

...

adView.loadAd(adUnitID: <<<Find your inventory ID in container>>>, adRequest: AdRequest())
```

When NativeAdView loaded, the `mediaContent` will be returned in `NativeAdViewDelegate` contains media metadata (width, height...) to help you better in update layout dimension.

```javascript
nativeAdView.delegate = self

...

extension YourViewController: NativeAdViewDelegate {
    func onNativeAdViewEvent(_ view: NativeAdView, adEvent event: NativeAdView.NativeAdEvent) {
        var iconHeight: CGFloat = 0
        if (event.data.name == "AD_LOADED"), let mediaContent = event.mediaContent {
            if let icon = mediaContent.icon {
                iconHeight = icon.height
                NSLayoutConstraint.activate([
                    view.iconImage.widthAnchor.constraint(equalToConstant: icon.width),
                    view.iconImage.heightAnchor.constraint(equalToConstant: icon.height)
                ])
            }

            if let main = mediaContent.main {
                let fixedWidth = view.bounds.width
                let fixedHeight = (fixedWidth * main.height) / main.width
                NSLayoutConstraint.activate([
                    view.mainImage.heightAnchor.constraint(equalToConstant: fixedHeight),
                    view.heightAnchor.constraint(equalToConstant: fixedHeight + iconHeight + 16)
                ])
            }
        }
    }
}
```

##### Display NativeAdTemplateView

The Framework provides three types of template: Default, Medium & Article

Create UIView in your Interface Builder then set class to `NativeAdTemplateView`, pick a template via `templateName` property

![](assets/NativeAdTemplateView.png)

Connect to your template IBOutlet and perform load an Ad via `contentView`

```javascript
@IBOutlet weak var templateMedium: NativeAdTemplateView!

...

if let contentView = templateMedium.contentView {
    contentView.loadAd(adUnitID: <<<Find your inventory ID in container>>>, adRequest: AdRequest())
}

```

#### Interstitial Ad
To display a interstitial ad, you need to use the InterstitialView function to get the ad from Aiactiv platform and then presenting ad .

```javascript
let interstitial = InterstitialAdView(adUnitID: <<<Find your inventory ID in container>>>)
interstitial.loadAdView(fromRootViewController: self)
interstitial.delegate = self
```

#### Using AdRequest

```javascript
// Create AdView
...

// Perform loadAd with a request
let context: [String: String] = [
    "title": "Got Talents show",
    "keywords": "talents, show, tv-show",
    "screen": "HomeScreen"
]
let adRequest = AdRequest(context: context)
adView.loadAd(adRequest)
```

#### Listen Ad Events

##### For Banner Ad - AdViewDelegate

```javascript
extension ShowAdViewController: AdViewDelegate {
    func adView(_ adView: AdView, didFailLoad error: AdsNetworkSDKError) {
        print("Ad did fail to load with error: \(error.errorDescription ?? "Unknown")")
    }

    func adView(_ adView: AdView) {
        print("Ad Loaded")
    }

	// Override click on Ad behavior
	func adView(_ adView: AdView, didClickAd url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
```

##### For Video Ad - VideoAdLoaderDelegate

```javascript
extension ShowAdViewController: VideoAdLoaderDelegate {
    func videoAdLoader(_ unitID: Int64, vastTagURL url: String) {
        print("Video Ad Content URL: \(url)")
    }

    func videoAdLoader(_ unitID: Int64, didFailLoad error: AdsNetworkSDKError) {
        print("Video Ad did fail to load with error: \(error.errorDescription ?? "Unknown")")
    }
}
```

##### For Native Ad - NativeAdLoaderDelegate

```javascript
extension ShowAdViewController: NativeAdViewDelegate {
    func onNativeAdViewEvent(_ view: NativeAdView, adEvent event: NativeAdView.NativeAdEvent) {
        print("Event: \(event.data.name)")
    }
}
```

##### For Interstitial Ad - InterstitialAdViewDelegate

```javascript
extension ShowAdViewController: InterstitialAdViewDelegate {
    func interstitialAd(_ad: AiactivUniversalSDK.InterstitialAdView, didFailToPresentContentWithError error: String) {
        
    }

    func adDidDismissScreentContent(_ad: AiactivUniversalSDK.InterstitialAdView) {
        
    }
}
```

### Analytics

Analytics will be initialized automatically and collect data for you. You can also manually track events with the following methods:

#### Track Events

```javascript
Aiactiv.track(name: "Event name", properties: [String : Any]?)
```

You can custom properties anything you want

```javascript
struct UserLoggedInEventProperties: Codable {
    var username: String
    var mail: String
}

let userLoggedInEventProperties = UserLoggedInEventProperties(
    username: "tester",
    mail: "tester@mail.com"
)

Aiactiv.track(name: "User LoggedIn", properties: userLoggedInEventProperties)

```

#### Identify Events

```javascript
Aiactiv.identify(userId: "UserID")
```

In case of you need to append more information

```javascript
struct UserTraits: Codable {
    var name: String
    var birthday: String
    var phoneNumber: String
}

let traits = UserTraits(
    name: "Tester",
    birthday: "20/12/2022",
    phoneNumber: "+84909090909"
)

Aiactiv.identify(userId: "UserID", traits: traits)
```

#### Screen Events

```javascript
Aiactiv.screen(title: "LoginScreen")
```

Properties are extra pieces of information that describe the screen. They can be anything you want.

```javascript
struct ScreenProperties: Codable {
    var name: String
    var loginMethod: String
}

let properties = ScreenProperties(
    name: "Login",
    loginMethod: "Apple ID"
)

Aiactiv.screen(title: "LoginScreen", properties: properties)
```

## Author

AiACTIV TECH, tech@aiactiv.io

## License

AiactivUniversalSDK is available under the MIT license. See the LICENSE file for more info.
