# Papcorns Analytics iOS SDK -> Swift 5

Add the following line to your Podfile

```
pod 'PapcornsAnalytics'
```

# Integrate the SDK into your app


```
import PapcornsAnalytics
```

Initialize PapcornsAnalytics in the `didFinishLaunching` or `didFinishLaunchingWithOptions` method of your AppDelegate file

```
 var appVersion = ""
 if let versionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
     appVersion = versionString
 }
 PapcornsAnalytics.configure(appId: "INSERT YOUR APP ID HERE", appVersion: appVersion)
```

Replace "INSERT YOUR APP ID HERE" string with id given to you

# Setting User Id

Before calling logEvent or logScreen you need to set  `PapcornsAnalytics.logEvent` with parameters [String:Any] whenever you need to trigger an event like in app purchases or signups etc.. , if there is no parameter then leave it with blank dictionary which is [:] .In event naming convension start with lowercased letter

```
PapcornsAnalytics.setUserId(userId : "")
```

## IMPORTANT !!!!!

If you are using Revenuecat and Firebase as a receipt validation then you need also set Revenuecat userId because we are also getting logs from Revenuecat webhook . 

So checking authentication everytime user goes into app might be a good idea with this function

```
func checkAuth(){
    let cUser = Auth.auth().currentUser
    if(cUser != nil){
        PapcornsAnalytics.setUserId(userId: cUser!.uid)
        Purchases.shared.identify(cUser!.uid, { (info, error) in
            if let e = error {
                print("Sign in error: \(e.localizedDescription)")
            }
        })
        self.continueToSomething()
    }else{
        Auth.auth().signInAnonymously { (result, err) in
            PapcornsAnalytics.setUserId(userId: (result?.user.uid)!)
            Purchases.shared.identify((result?.user.uid)!, { (info, error) in
                if let e = error {
                    print("Sign in error: \(e.localizedDescription)")
                }
            })
            self.continueToSomething()
        }
    }
}
```

# Tracking Screens

In  `viewDidAppear` function of your viewcontroller call  `PapcornsAnalytics.logScreen` with parameters [String:Any] ,  if there is no parameter then leave it with blank dictionary which is [:] 

Setting a screenName parameter has a naming convention which is to put you context name first and then put "Screen" on top of it . For example if i am in HomeViewController log screen with name "HomeScreen". In log screen event naming start with uppercase letter

```
  override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      PapcornsAnalytics.logScreen(screenName: "XScreen", screenParameters: [:])
  }
```

# Tracking Events

Call  `PapcornsAnalytics.logEvent` with parameters [String:Any] whenever you need to trigger an event like in app purchases or signups etc.. , if there is no parameter then leave it with blank dictionary which is [:] .In event naming convension start with lowercased letter

```
PapcornsAnalytics.logEvent(eventName: "effectTapped", eventParameters: 
    [ 
        "effectName" : "Harry Potter",
        "effectId" : "1sae1123asgasr"
    ]
)

OR

PapcornsAnalytics.logEvent(eventName: "weekly_trial_bought", eventParameters: [:])
```

