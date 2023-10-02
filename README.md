# Flashcards-iOS-APP
The Flashcards app is an iOS mobile application that allows users to create, organize, study, and manage flashcards to aid in studying. The app has been upgraded to incorporate multiple views, data persistence, and additional UI features.

## Features
- Create and add flashcards with custom questions and answers
- Flip between question and answer with tap and swipe gestures
- Star/favorite flashcards to study favorites separately
- Re-order flashcards within the deck
- Delete unwanted flashcards
- Persist data between sessions using plist file
- Tab bar with Cards, Favorites, and Question tabs
- Adaptive and responsive UI using Auto Layout

## User Flow
- Use the **Add** button to open the New Card screen
  - Enter the question and answer
  - Tap Save to add the flashcar
  - An alert prevents adding duplicate questions
- The **Cards** tab shows all flashcards in a table view
  - Tap a flashcard cell to flip it and study
  - Swipe left to delete a card
  - Long press and drag to reorder cards
- The **Favorites** tab displays favorited flashcards
- The **Question** tab shows a single flashcard in large text
  - Double tap to flip between question and answer
  - Swipe to advance to the next flashcard
- Star icons favorite/unfavorite flashcards
- Data persists when the app is closed and reopened

## Technical Details
### The app is built with:
- Xcode and Swift
- Model-View-Controller design pattern
- UITabBarController for tabbed navigation
- UITableViewController for card tables
- Custom UIViewController subclasses
- Protocols and delegates for logic and data sources
- NSFileManager and plist for data persistence
- Auto Layout and size classes for adaptive UI

