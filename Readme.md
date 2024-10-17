### Steps to Run the App
1. Navigate to `FetchRecipes` and open FetchRecipes.xcodeproj
2. Select your device or a simulator to run on
3. Press `Run` in Xcode.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I prioritized more of the logic of downloading and caching the images over UI. With more time I would like to expand the UI to be more feature rich.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
4 hours
### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
1. I used the general `openURL` over adding a modifier to display the videos and websites in app.
2. I didn't use protocols for this simple demo, but normally would utilize protocols
### Weakest Part of the Project: What do you think is the weakest part of your project?
1. Test cases. I made a few changes like making the cache internal so that it could be easily checked in the test cases. Another approach would be to create a wrapper that is only built in `#TESTING` environment.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
No external dependencies or code

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
Ways I would improve my UI would be adding categories based on the Cuisine, and also adding a search bar to filter out the recipes.
