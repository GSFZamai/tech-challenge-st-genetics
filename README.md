# Good Hamburger

Project in flutter that implementes the requirements to Good Burger App

## Table of Content

- [Table of Content](#1-table-of-content)
- [Start project](#start-project)
  - [Debug](#debug)
  - [Release](#release)
- [Screens](#screens)
  - [Products List Screen](#products-list-screen)
  - [Order Details Screen](#order-details-screen)
  - [Past Orders Screen](#past-orders-screen)
- [Technologies](#technologies)
- [CI/CD](#cicd)
- [Automated Tests](#automated-tests)

## Start project

### Debug

To run the project in debug mode, on the root folder follow the steps below:

1. Install dependencies with `flutter pub get`;
2. Run the project with `flutter run --debug`;

### Release

There is also a `release` version published on `firebase` built with GitHub Actions as described on [CICD section](#cicd);

## Screens

### Products List Screen

- List all products with filters by category
  - On Tap the card, the product should be added to the order;
  - On LongPress the product should be removed
  - The order status can be tracked on the FloatButton located at the bottom of the screen (only visible when the order have at least one item);
  - Button on top right corner to navigate to [Past Order Screen](#past-orders-screen);

### Order Details Screen

- Details from the current order that includes the list of products with the following information:
    - Product Name;
    - Product Price;
    - SubTotal (Sum of product's prices);
    - Discount in Percentage;
    - Discount in currency;
    - Total value (Total price - total discount)
- InputField to get the user's name;
- Place order button to place the order (Only enabled when the name is filled)

### Past Orders Screen

  - List of the past placed orders

## Technologies

- Flutter 3.38.4 (Stable);
- Dart: 3.10.3;
- `path_provider` for persistence on `json` file

## CI/CD

The project has 2 `workflows`:

- [Tests](./.github/workflows/tests.yml) which runs on every push to the remote repository and trigger the automated tests jobs;
- [Build and Deploy](./.github/workflows/build_and_deploy.yml) which runs only when the tests are completed. This workflow builds a `.apk` on `release` mode and deploy to `Firebase App Distribution`

The release version can be accessed here:
https://appdistribution.firebase.dev/i/56a7092d3732ada3

## Automated Tests

The tests verifies if the classes initializations occurs as expect, test the models methods and if the discounts area applied correctly:

- [ProductCategoryEnum](./test/models/enums/product_category_enum_test.dart)
- [ProductModel](./test/models/product_model_test.dart)
- [ProductOrder](./test/models/product_order_test.dart)
- [Product](./test/models/product_test.dart)

To run the tests follow the steps:

1. Install dependencies with `flutter pub get`;
2. Run tests with `flutter test`
