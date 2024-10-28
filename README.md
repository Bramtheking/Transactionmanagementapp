<<<<<<< HEAD
<<<<<<< HEAD
=======
# Transactionmanagementapp
This is an android application which helps the kopokopo company manage their transactions
=======
>>>>>>> e6365a5 (Newest commit)
# myapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
<<<<<<< HEAD
=======
# Transaction Management Mobile - L2

Below, you'll find the instructions for getting started with your task. Please read them carefully to avoid unexpected issues. Best of luck!

## Time estimate

Between 2 and 3 hours, plus the time to set up the codebase.

## Mandatory steps before you get started

1. Set up your codebase according to [either of the outlined options](https://help.alvalabs.io/en/articles/9028914-how-to-set-up-the-codebase-for-your-coding-test) for your coding test. Please be sure to select Flutter as the project boilerplate.
2. Learn [how to get help](https://help.alvalabs.io/en/articles/9028899-how-to-ask-for-help-with-coding-tests) if you run into an issue with your coding test.

## The task

<!--TASK_INSTRUCTIONS_START-->
Your task is to **build a mobile app** that **integrates with the Transaction Management API**.

Please agree with your hiring team regarding the tech stack choice.

Feel free to tweak the UI, but please ensure that the following is in place:

1. The form for submitting transactions.
2. The transaction list with the data attributes presented on the mock (the account balance should only be shown for the transactions submitted from the current device).

### Mockup
Here's how your app could look.

<img src="https://user-images.githubusercontent.com/1162212/118036633-17fa0300-b36d-11eb-8b86-41e58b786528.png" height="800" />

### REST API

<details>
<summary>Request examples</summary>

##### Get historical transactions

```
GET https://infra.devskills.app/api/transaction-management/transactions
```

##### Create a new transaction

```
POST https://infra.devskills.app/api/transaction-management/transactions
Content-Type: application/json

{
  "account_id": "0afd02d3-6c59-46e7-b7bc-893c5e0b7ac2",
  "amount": 7
}
```

##### Get a transaction by id

```
GET https://infra.devskills.app/api/transaction-management/transactions/7c94635a-40a3-4c87-888a-42c3ce5b9750
```

##### Get an account by id

```
GET https://infra.devskills.app/api/transaction-management/accounts/0afd02d3-6c59-46e7-b7bc-893c5e0b7ac2
```

</details>

### Solution expectations (Read carefully)

1. Your solution MUST be implemented in Flutter - No exceptions!
2. Implement client-side validation of the form data.
3. Implement error handling for the cases when the API cannot be reached or returns a server error.
4. Unit test one component of choice. There is no need to test the whole app, as we only want to understand what you take into consideration when writing unit tests.
5. Avoid duplication and extract re-usable components where it makes sense. We want to see your approach to creating a codebase that is easy to maintain.
6. Add instructions that describe how to run your app locally.
7. Make a screen recording of your working app and add the recorded screencast to the repo ([see how](https://help.alvalabs.io/en/articles/9046916-screen-recording-instructions-for-mobile-coding-tests)).
8. Upload a compiled version of the app (debug mode) to the repo. For iOS this needs to be a `.app` file that is build for the simulator and for Android it needs to be an `apk` debug file. For projects created in Flutter or React Native you can choose which platform is most convenient for you. (NB: for this exercise, you MUST use Flutter). [Click here](https://help.alvalabs.io/en/articles/9046962-building-mobile-coding-test-application) for more detailed instructions.
9. It should take you approximatley 3 hours to implmeent your solution but it is ok if you take longer. However, please note that how long you take implemnenting your solution will be part of the evaluation criteria.
<!--TASK_INSTRUCTIONS_END-->

## When you are done

1. [Create a new Pull Request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) from the branch where you've committed your solution to the default branch of this repository. **Please do not merge the created Pull Request**.
2. Go to your application in [Alva Labs](https://app.alvalabs.io) and submit your test.

---

Authored by [Alva Labs](https://www.alvalabs.io/).
>>>>>>> origin/bramwels-app
=======
>>>>>>> 9942474 (Initial commit)
>>>>>>> e6365a5 (Newest commit)
