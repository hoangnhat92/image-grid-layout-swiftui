This challenge was addressed by **UIKit**, but I wanted to resolve it using **SwiftUI** and **Swift concurrency**, utilizing all the latest technologies from Apple.

### The challenge can be described by the following requirements:

- Present a horizontal layout of images (similar to `UICollectionView` in UIKit) with a constant feed of images.
- Each cell represents an image, with a placeholder appearing until the image has loaded.
- The image URL is `https://loremflickr.com/200/200/`, which returns a random image with each request.
- Apply paging to the grid view.
- Ensure the application runs smoothly and is free from crashes.

### My approach:

I implemented this in **SwiftUI** with some customizations to `AsyncImageView`. This new class handles asynchronous images, including a separate image caching mechanism. The default `AsyncImage` from the Apple library lacks control in terms of caching, which is why I introduced custom caching. Note that the names are similar, so don't get confused between them.

Even though the main part of the challenge is sorted, there's still room to improve, especially with paging. Handling paging in SwiftUI is a bit tricky, but I'll come back to it once I figure out a better way to implement it
### Screenshot
<img width="505" alt="Screenshot 2024-10-08 at 14 16 43" src="https://github.com/user-attachments/assets/7e7b56f8-1e25-455c-a351-74620a082394">

