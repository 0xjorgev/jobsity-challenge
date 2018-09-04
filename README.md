#  Jobsity Coding Challenge, readme:

### This project aims to create an app based on the TV MAZE API, this API provides endpoints for:

- TV Shows listing
- TV Shows search
- TV Shows season listing
- TV Shows episodes by season
- TV People search

### Project minimum requirements:

- Xcode 9.4.1 +
- MacOS Sierra 10.13.6 +
- iOS 11 +
- Swift 4 +

### Project Dependencies:

This project runs using 3rd party code libraries managed by Cocoapods, to install
it you must:

- sudo gem install Cocoapods

in the root folder of the project:

- pod install

Installed Pods:

- PureLayout, library to manage AutoLayout via code in a simpler and easier to maintain way
- moa, async image downloader manager for UIImageViews
- UIScrollView-InfiniteScroll, allows to create the infinite scroll to the Home Section
- RealmSwift, an object oriented local database (for Favorites functionality)

### Project Structure:

+ XCWorkspace
    + CodeChallenge XCProject
        + CodeChallenge
        - Extensions
        + Views
            + Headers
            + Cells
        + ViewControllers
            + Search
            + Episode Details
            + Show Details
            + Home
        + Utils
        + Models
        - Main.Storyboard
        - Assets.xcassets
        - LaunchScreen.Storyboard
        - Info.plist

    + Pods XCProject
    ...

### Structures / Architectures / Coding Style

- API calls functions are located on Service.swift file, this file contains
all the calls to services with completion blocks for async handling of services responses.
The JSON parsing is managed using Swift 4 Decodable protocol that allows such functionality
without 3rd party libraries

- Each ViewController shown in the UITabBar Controller is associated in the Main.Storyboard file
- Most of the ViewControllers follows this coding pattern:
    - Local variables and objects (Such as UIKit elements) declaration
    - CreateView method for local variables and Objects
    - SetupConstraints method, handles the AutoLayout constraints for local elements
    - 1:1 KVO   by implementing structs and didSet methods to react and pass data 
    - Most of the UI is done via code by composing UITableViewControllers with Custom Headers with separate files
- Colors class, is a class with all the colors references for the entire project



