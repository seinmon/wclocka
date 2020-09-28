# Contributing
I am glad that you are interested in contributing to the World Clock Alarm project. This project is maintained as a hobby. While you can report bugs or ask for features, I am under no obligation to implement them in a timely manner. The quickest way to get the features you want is to implement them yourself, but make sure you read this guide before creating issues and pull requests.

## Issue templates
You can create an issue to ask for a feature, improvement, bug fix, or ask a question. Avoid opening issues for typos or minimum improvements to documentations. Just create a pull request instead.

There are two issue templates for bug reports and feature/improvement requests. Although it is not mandatory to fill every section of the template, I recommend you to do so. Well written issues are understood easier and resolved quicker. In the following, I will briefly explain each issue template:

### Feature request
- **Why / Problem:** Explain the reason why the requested feature is necessary. You can include screenshots or include links to other examples and resources.
- **Acceptance Criteria:** Explain what needs to be done in order to close this issue. Avoid going into the implementation details. Just provide a simple description of the end results.
- **Additional Context:** If there is anything left that you cannot be included in the sections above, write here.

### Bug report
- **Expected Behavior:** Explain the correct behavior of the software.
- **Actual Behavior:** Describe how it is different from the expected behavior.
- **Steps to Reproduce:** Write step by step instructions to reproduce the problem.
- **Device Information:** Write the specifications of the device which had this bug. Make sure you also include the app version, since the issue might have been resolved in a later version. Here is an example of the device information:
  - *Device:* iPhone 8
  - *OS:* iOS 13.5.1
  - *App Version:* 0.1.12
- **Additional Context:** If there is anything left that cannot be included in the sections above, write here.

## Development guidelines
- Please follow this [Swift Style Guide](https://google.github.io/swift/) to avoid inconsistent coding style among contributors.
- Keep your pull requests as small as possible. It is also important to clearly explain the most significant changes in your pull request, and avoid getting too deep in the technical aspects of your code.
- Use imperative language in commit subject lines. Your subject line should be able to complete this sentence: "If applied, this commit will...". Read more about good commit messages [here](https://chris.beams.io/posts/git-commit/).
- Start your branch names with one of these prefixes:
  - documentations -> `doc_`
  - features and improvements -> `feat_`
  - bug fixes -> `bug_`
