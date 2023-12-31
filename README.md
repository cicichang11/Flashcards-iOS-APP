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
### Question tab
- The **Question** tab shows a single flashcard in large text with the **questions** being defaultly presented
  - **Double-Tap** the card to flip between question and answer
  - **Swipe Left** to advance to the next flashcard & **Swipe Right** to go back to the previous flashcard
    - This is when the user what to follow the order of the cards in the **Cards** tab
  - **Single-Tap** to view a card randomly, same as shaffling all the flashcards and picking a random one
  - Tab the **star icons** at the top right corner favorite/unfavorite flashcards
    - yellow star means the card is favored; white start means the card is unfavored
- Data persists when the app is closed and reopened

<img src="img/Question.png" alt="screenshot" width="200"/> <img src="img/Answer.png" alt="screenshot" width="200"/>
<img src="img/Unfavored.png" alt="screenshot" width="200"/> <img src="img/unfavored_answer.png" alt="screenshot" width="200"/>

### Cards tab
- The **Cards** tab shows all flashcards in a table view
  - Tap the **Edit** button at the top left corner to edit the order of the cards or delete cards
  - Tap the **Add (+)** button at the top right corner to open the **"Add A New Card"** screen
    - On the "Add A New Card" screen, user can input a question-answer pair to be added as a new flashcard
    - Tap *Save* to add the flashcar
    - Tap *Cancel* to exit the page
    - An alert prevents adding duplicate questions

<img src="img/Cards.png" alt="screenshot" width="200"/> <img src="img/Edit.png" alt="screenshot" width="200"/> <img src="img/Add.png" alt="screenshot" width="200"/>

### Favorites tab
- The **Favorites** tab displays favorited/starred flashcards in a table view
- The table is updated real-time and consistent with what is starred and what is not in the **Question** tab

<img src="img/Favorites.png" alt="screenshot" width="200"/>

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

