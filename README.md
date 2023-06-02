# GSNativeAlertExample

![Dark Mode](https://github.com/megaganjotsingh/GSNativeAlertExample/blob/main/GSNativeAlertExample/gif/sample.gif)

Easy to Use
  ---
  
  ### Define alert here

  ```swift
         let alert = GSAlert()
  ```

### You can simply set titles, messages and buttons
  
  ```swift
        alert.set(
            title: Place NSAttributedString Here,
            messages: [
                (Place UIImage Here, Place NSAttributedString Here),
                (Place UIImage Here, Place NSAttributedString Here)
            ],
            alertButtons: [
                (Place NSAttributedString Here, {
                    print("OKAY Taped")
                }),
                (Place NSAttributedString Here, Perform Some Action Or simply pass nil),
        ])
  ```
  
### Now present alert in a simple way
  
  ```swift
        present(alert, animated: true, completion: nil)
  ```
  
  Collaboration
---

I tried to build an easy to use API, but I'm sure there are ways of improving and adding more features, If you think that we can do the GSNativeAlertExample more powerful please contribute with this project.
