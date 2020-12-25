<p align="center">
  <a href="" rel="noopener">
 <img width=300px  src="src/main-preview.gif" alt="Project logo"></a>
</p>

<h3 align="center">🌬CMFloatingTextField🌬</h3>

<div align="center">

![License](https://img.shields.io/github/license/CM-Material/CMFloatingTextField?style=for-the-badge)
![Release](https://img.shields.io/github/v/release/CM-Material/CMFloatingTextField?style=for-the-badge)


</div>

---

## 📹 Preview

<p align="center">
    <img src="src/appVideo.gif" width="40%" />
</p>

## 🏁 Getting Started

### Requirements
* Xcode 11+
* SwiftUI
* iOS 14+
* macOS 10.15+

### Installaion
#### Swift Package Manager(SPM)
    File ➜ Swift Packages ➜ Add Package Dependancy..

```Swift
.package(url: "https://github.com/CM-Material/CMLottiePlayer", from: "1.0.0")
```

## 🎈Usage
```Swift
CMFloatingTextField(_ content: Binding<String>, placeholder: String)
CMFloatingSecureField(_ content: Binding<String>, placeholder: String)
// Secure Field for password
```
* `content` : user input
* `placeholder` : placeholder text before add text

#### 🛠Custom Modifiers
```Swift
CMFloatingTextField(_ content: Binding<String>, placeholder: String)
    .accentColor(_ color: Color)
    .contentType(_ contentType: ContentType)
    .icon(systemName icon : String)
    .showClearButton(_ show: Bool)
    .styled(_ style: CMFloatingTextFieldStyle)

// All of the parameter is optional
```
* `.accentColor()` : Width of button
* `.contentType()` : `.none` `.email` `.number` `.phone` `.name` support different keyboard type
* `.icon()` : icon name of `SF Symbols` 
* `.showClearButton()` : to show clear button or not
* `.styled()`(In Progess) : `CMFloatingTextFieldStyle.normal`, `CMFloatingTextFieldStyle.sqaure`
## Example
#### 👶 Simple
```Swift
import SwiftUI
import CMFloatingTextField

struct ContentView: View {
    @State var input: String = ""
    
    var body: some View {
        CMFloatingTextField($input, placeholder: "Please type")
            .padding()
    }
}
```
### Result
<p float="left">
    <img src="src/Example-simple-1.png" width="25%">
    <img src="src/Example-simple-2.png" width="25%">
    <img src="src/Example-simple-3.png" width="25%">
</p>

### ➕ Add Icon
```Swift
import SwiftUI
import CMFloatingTextField

struct ContentView: View {
    @State var input: String = ""
    
    var body: some View {
        CMFloatingTextField($input, placeholder: "Please type")
            .icon(systemName: "flame.fill")
            .padding()
    }
}
```
### Result
<p float="left">
    <img src="src/Example-icon-1.png" width="25%">
    <img src="src/Example-icon-2.png" width="25%">
    <img src="src/Example-icon-3.png" width="25%">
</p>

### Advanced
```Swift
import SwiftUI
import CMFloatingTextField

struct ContentView: View {
    @State var input: String = ""
    
    var body: some View {
        CMFloatingTextField($input, placeholder: "Nick Name")
            .icon(systemName: "flame.fill")
            .contentType(.name)
            .accentColor(Color.orange)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding()
    }
}
```
You can also use `TextField` modifiers like `.autocapitalization()` `.autocapitalization()`

### Result
<p float="left">
    <img src="src/Example-advanced-1.png" width="25%">
    <img src="src/Example-advanced-2.png" width="25%">
    <img src="src/Example-advanced-3.png" width="25%">
</p>

## ✅ TODO
- [ ] Square Style
- [ ] Add Restrict Options
- [ ] Validation Check

## 📜 License

CMLoadingButton is available under the MIT license. See the `LICENSE` file for more info.

## ✍️ Author

- [🇰🇷@Changemin](https://github.com/kylelobo)
