# Flutter Chat App

This Flutter Chat App module is designed to provide a seamless and intuitive chat experience for users. It leverages Firebase Authentication, Firestore, and Storage to handle user authentication, real-time messaging, and image storage. The app allows users to register with their email and password or log in if they already have an account. Once logged in, users can enjoy a chat interface where messages are displayed in an organized manner.

## Features

- User Registration and Authentication:
  - Users can register using their email and password to create a new account.
  - Existing users can log in to access their account.
  - Firebase Authentication is used to handle user authentication and security.

- Real-time Messaging:
  - Users can send and receive messages in real-time.
  - Messages are displayed in a chat interface, with the user's messages appearing on the right and the other users' messages on the left.
  - Each message includes the sender's username, enhancing the organization and readability of the chat.

- User Profile and Image Management:
  - Users have a customizable profile picture.
  - By clicking on the profile picture, users can choose to take a photo using the camera or select an image from their gallery.
  - The selected image is stored in Firebase Storage, and the corresponding link is saved in Firestore.
  - The chosen profile picture persists even after the user logs out or closes the app.
  - Users can update their profile picture by simply clicking on it.

- Drawer Navigation and Logout:
  - The chat screen includes a drawer that provides easy access to additional functionalities.
  - The drawer displays the user's profile picture, username, and email.
  - Users can log out from the app using the logout button in the drawer.

## Installation and Usage

1. Clone or download the repository to your local machine.
2. Make sure you have Flutter installed and set up on your system.
3. Run `flutter pub get` to fetch the project dependencies.
4. Connect the app to your Firebase project by adding the necessary configuration files.
5. Run the app using `flutter run` command in the project directory.

## Dependencies

- `firebase_core` - Firebase Core SDK for Flutter.
- `firebase_auth` - Firebase Authentication SDK for Flutter.
- `firebase_storage` - Firebase Cloud Storage SDK for Flutter.
- `image_picker` - A Flutter plugin for selecting images from the device gallery or camera.

## Next Steps

The current version of the Flutter Chat App module includes the core functionality for user authentication, real-time messaging, and profile picture management. However, there are a few areas that can be further enhanced:

- Push Notifications: Implement push notifications to notify users about new messages or chat updates even when the app is in the background.
- Private Chats: Implement private messaging between two users to create more personalized and targeted conversations.
- UI/UX Improvements: Enhance the app's user interface and experience by adding more animations, themes, and customization options.
- Error Handling: Implement robust error handling and feedback mechanisms to provide a seamless and user-friendly experience.
