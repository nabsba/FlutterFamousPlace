# Flutter Database Application

## Purpose
This app demonstrates how to integrate various Flutter database operations and backend services to create a basic mobile and desktop application. The backend, powered by Node.js, serves data to both mobile and desktop platforms. The app uses several technologies to handle data persistence, authentication, and image storage.

## Technologies Used
- **Flutter**: For mobile and desktop application development.
- **Node.js**: Backend server for serving data.
- **Firebase**: To retrieve images for the app.
- **JWT**: For user authentication with a database.
- **SecureStorage**: To persist authentication tokens securely.
- **SQLite**: For offline storage of places.
- **GraphQL**: For querying and manipulating data from the backend.


## Features
- **Retrieve and Display Places**: Fetch and show a list of places in the app.
- **Retrieve Single Place**: Use search functionality to find and display detailed information about a selected place.
- **Preselection**: Preselect a place from the list and display detailed information based on the selection.
- **Filtering**: Include filtering options to sort places by certain criteria.
- **Favorite Toggle**: Allow users to mark places as favorites and toggle between favorite and non-favorite status.
- **Translations**: Language FR and EN.

## Features Ignored
- **Booking**: The application does not support booking functionality.
- **Filtering by Location**: Features like nearby places filtering, which could be done using location services, are not included.
- **Local Storage**: For caching images and ensuring availability in offline mode.

## Technologies Ignored
- **Testing**: Testing has not been implemented in this version of the app.

## Setup Instructions


1. **Needs**:
- **Backend**: Install & Run git@github.com:nabsba/BackendFamousPlaces.git
1. **Clone the repository**:
   ```bash
   git clone git@github.com:nabsba/FlutterFamousPlace.git


#### END