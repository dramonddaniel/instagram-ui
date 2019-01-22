## Instagram UI

<p float="center">
  <img src="https://user-images.githubusercontent.com/19694636/44957769-ae43ae80-aecd-11e8-8c89-00bce6d3f3e2.gif" width="24%" />
  <img src="https://user-images.githubusercontent.com/19694636/44957448-b64e1f00-aeca-11e8-8de7-7e06745ad22b.PNG" width="24%" /> 
  <img src="https://user-images.githubusercontent.com/19694636/44957438-97e82380-aeca-11e8-8577-df6e3a163d4c.gif" width="24%" />
  <img src="https://user-images.githubusercontent.com/19694636/44957587-6b80d700-aecb-11e8-8f82-92df77319ed1.gif" width="24%" />
</p>

---

<i>How did you create this UI</i>
- This is honestly a very simple UI. The feed is made up on a single **UICollectionView** and each post is a **UICollectionViewCell**. The stories view on the top is a **UICollectionView** within the main **UICollectionView** header. 

<i>How did you manage to load the posts?</i>
- I display the posts by using the MVC pattern. I have created a **Post** object that holds everything, such as the post image URL, user and timestamp. I then pass each post object into their individual cells, where it is shown on the UI like so:

```swift

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
    
    cell.post = self.posts[indexPath.item]
    
    return cell
}

class PostCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            // UPDATE UI.
        }
    }
}
```

---

## Contributors 
- Daniel Dramond <dramonddaniel@gmail.com>

## License & Copyright

© Daniel Dramond
