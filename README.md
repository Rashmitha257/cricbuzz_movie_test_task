# cricbuzz_movie_test_task
# Overview
The Movie List App is a Swift-based iOS application that allows users to get movie information and discover information about movies. It follows the MVVM (Model-View-ViewModel) architectural pattern to maintain a clean and structured codebase.

# Features
Movie List: Browse movie data.
Movie Details: View detailed information about each movie.
Search: Search for specific movies

# Architecture
The app is built using the MVVM architectural pattern, which stands for Model-View-ViewModel. This separation of concerns enhances code maintainability and testability. Here's a brief overview of each component:

Model: Represents the data and business logic of the application. In this app, models represent movie data, and we fetch this data from a remote API.

View: Displays the user interface and handles user interactions. In our app, views include the movie list, movie details, and search screens.

ViewModel: Acts as an intermediary between the Model and View. It prepares and transforms the data from the Model and provides it to the View for rendering. ViewModels also handle user interactions and communicate with the Model when necessary.

# Getting Started
Follow these steps to get the Movie List App up and running:

Clone the Repository:

bash
Copy code
git clone https://github.com/Rashmitha257/cricbuzz_movie_test_task.git
cd movies

Open the Project:
Open the Movies.xcworkspace file in Xcode.

Build and Run:
Choose your desired simulator or device, then click the "Run" button in Xcode
