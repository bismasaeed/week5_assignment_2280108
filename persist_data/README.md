# persist_data

Unit Testing

Unit testing in Flutter is the process of testing individual functions, methods, or classes to ensure they work correctly. It helps verify that the logic of a specific unit (such as a function) produces the expected output. In this project, unit tests are written using the flutter_test package to check the correctness of adding, loading, and managing tasks in the to-do list application.

Mock Testing

Mock testing involves creating a simulated version of a dependency (e.g., SharedPreferences) to test the logic without actually depending on real implementations. In this project, SharedPreferences.setMockInitialValues() is used to mock stored data, allowing the app to be tested without requiring actual storage access. This helps verify that the app correctly loads and saves tasks without needing real storage interactions.

SharedPreferences

SharedPreferences is a key-value storage solution in Flutter used for persisting small amounts of data locally. In this project, SharedPreferences is used to store and retrieve to-do list tasks in JSON format. This ensures that the user's tasks are saved even after the app is closed and reopened. The saveTasks and loadTasks methods handle saving and retrieving data respectively.

By combining unit testing, mock testing, and SharedPreferences, this project ensures efficient and reliable task management with data persistence.