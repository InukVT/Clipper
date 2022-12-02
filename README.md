# Clipper
A tool to give cut and paste for screenshot preview in macOS

## What does it do
In iOS there is a copy tool screenshots in the markup tool, this is missing on mac however. This tool has been made to address this issue.

# How to build
This project has no external dependencies, so everything is neatly contained in the folder, just follow the step by step guide.
Run the following in the terminal:
1. `git@github.com:BastianInuk/Clipper.git`
2. `cd Clipper`
3. `open .`

The last command should open finde in the root folder of Clipper. 
4. Open the Xcode project (`Clipper.xcodeproj`)

Now that you're in Xcode, you can start tinker with the code, but before this, it's probably a good idea to run the project first. To just compile I recommend.
5. In middle bar where it says "Clipper" select copy image
6. Press the play button in the upper left corner
7. Select Safari (or any other app)

Now that you have the program compiled and running, you can take as many screenshots as you want, in the share extension you should be able to see "Copy Image" now.

# TODO
- Better error handling
- Constrain share types at the app so (so the extension doesn't appear on irrelevent context)
- App and Extension Icons
- Image history
- Should clippy also be yet another clipboard manager(?)
- Notorise (and put on Brew)
- Put on App Store
