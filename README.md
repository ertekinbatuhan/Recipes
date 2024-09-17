# Recipes App

 The app is fully developed programmatically, without using Storyboard.

![Screenshot 2024-08-27 at 20 11 49](https://github.com/user-attachments/assets/a9b397c1-db0c-41ac-b86e-c6e12579dd61) ![Screenshot 2024-08-27 at 20 11 41](https://github.com/user-attachments/assets/a687695b-77a7-48b5-818e-1d92535416cb)

## Features

- **Programmatic Interface:** The entire user interface of the app is built using Swift code, without the use of Storyboard or XIB files.
- **MVVM Architecture:** The app follows the Model-View-ViewModel (MVVM) architecture, ensuring a clean separation of concerns, making the codebase easier to maintain and test.
- **Protocol Oriented Programming:** The app's architecture is based on protocols, making the code more modular, testable, and extendable.
- **Unit Tests:** Comprehensive unit tests have been written for the core functionalities and components of the app to ensure it works correctly and is resilient to errors.

## Technologies Used

- **Swift:** The programming language used for developing the application.
- **UIKit:** The framework used for user interface components and interactions.
- **XCTest:** The framework used for writing unit tests.
- **Kingfisher:** A versatile library for efficiently downloading, caching, and displaying images.


## MVVM Architecture Used

The Model-View-ViewModel (MVVM) architecture separates the code into three distinct layers:

- **Model:** Represents the data and the business logic of the application. It is responsible for managing the data, communicating with the network layer, and storing data persistently if needed.
- **View:** Represents the user interface of the application. It displays data and interacts with the user. The view is responsible for user input and displaying the information provided by the ViewModel.
- **ViewModel:** Acts as a bridge between the View and the Model. It provides data from the Model to the View and updates the Model based on user interactions from the View. The ViewModel ensures that the View remains unaware of the data layer (Model) and is only responsible for the presentation layer.

This architecture pattern enhances testability, maintainability, and scalability by ensuring a clean separation of concerns.


![Screenshot 2024-08-09 at 12 31 02](https://github.com/user-attachments/assets/6544dc18-5dbf-424b-b8cb-fcfe1a2bbe88)


