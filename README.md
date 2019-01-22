## Instagram UI

<p float="center">
  <img src="https://user-images.githubusercontent.com/19694636/51562322-77246880-1e81-11e9-9c8a-b768a42b4785.gif" width="49%" />
  <img src="https://user-images.githubusercontent.com/19694636/51562346-8a373880-1e81-11e9-8f71-ad0af4379d35.gif" width="49%" /> 
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
