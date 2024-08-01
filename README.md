# IOSSwift Project

## Swift sdk version

Swift 5.0 • channel stable

This repository contains a ios swift project. Below are the details of the project structure and setup instructions.

### Folder Structure

Here is the folder structure we have been using in this project

```
IOSSwift/
|- CustomControls
    |- TableViewCell
|- Managers
    |- DropDownManage
    |- ImagePickerManager
    |- Reachability
    |- SearchManager
|- Model
|- Utilities
    |- AppControlClasses
    |- Constants
    |- Extensions
|- ViewControllers
|- Webservices

```

Now, lets dive into each folder and understand the purpose

```
1- CustomControls - This folder includes our custom components like tableview cell, collection view cell or any other custom view which you build to reuse it throught the project

2- Managers - This folder is basically used for add custom class created for easy use of any inbuild class or library. For example you can see ImagePickerManager class which is used when user need to integrate image picker for media selection. This manager is used to integrate feature in few lines of code allover the project

3- Model - This folder is used to store Model classes used to handle and store data from API response

4- Utilities - This folder contains contains common use of uitilites like Date extensions, Font extensions etc.
 
5- ViewControllers - This folder contains all the screen files which are designed in storyboard. 

6- Webservices - This folder contains REST API related files which is used to call the api, Parse the API response and manage the API parameters.

```
## Additional screen designing added to storyboard using UIView extensions

<img width="390" alt="Screenshot 2024-08-01 at 11 17 12 AM" src="https://github.com/user-attachments/assets/92c3f72b-1061-4a99-abdc-76341405e41c">

## Setting Up the Project

### Prerequisites

Ensure you have Xcode installed on your system. 
Ensure you have installes CocoaPods on your systems. Refer this link for installation guide https://cocoapods.org/

### Cloning the Repository

Clone this repository using the following command:

```sh
git clone https://github.com/CrestDev01/IOSSwift.git
```

### Installing Dependencies

Navigate to the project directory and install the necessary pods using the following command:

```sh
pod install
```
### API response structure dependencies

This project is structured for API response show belo
{
"status": [Int]
"data" : [Array of json object] / [json object]
"message" : [String]
}

This structure is handled using RestApiResponse.swift file. Feel free to modify as per your API requirement in your own project 

## Contribution

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Authors

- **CrestDev01** - [Find Me](https://github.com/CrestDev01)

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc.


