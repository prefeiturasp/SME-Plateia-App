# Flutter Clean Architecture Project Template: Basic Template

***A Very Opinionated Flutter Project Template***

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Powered by the [Very Good CLI][very_good_cli_link] 🤖

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```


_\*Template works on iOS, Android, Web, Linux, and Windows._


---

## Makefile Command 💻

This project is equipped with Makefile command to shorten command writing, to see available command please refer to [Makefile][makefile_link].
Please change the Environment Variable such as: `${FIREBASE_EMAIL}`, etc., in the file to your need.

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# run build_runner once
$ make build
# watch file change
$ make watch
# generate dev apk
$ make apk-dev
# generate staging apk
$ make apk-stg
# generate production apk
$ make apk-prod
# generate dev ipa
$ make ipa-dev
# generate staging ipa
$ make ipa-stg
# generate production ipa
$ make ipa-prod
# fix code
$ make fix
# check fix
$ make check-fix
```

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
# Run test with coverage
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---
