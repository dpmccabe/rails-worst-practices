4. Your descriptions should read like a sentence beginning with \"It\". If testing an actual instance method, use `#method_name` in your descriptions.
5. Use factories when you need to build or create an actual object.
6. This `expect` statement doesn't quite match the description. Ensure your description and assertion are the same.
10. Again, factories.
11. If you're going to use the new `expect` syntax, use it consistently.
12. Most tests should be isolated enough that you only need to make one assertion per test. If the tests are examining the same object, use `subject` for added conciseness.
17. This should, again, use a Factory. In any case, calling bang methods in poorly-written tests might raise exceptions that obscure the actual reason for a failed test.
18. This assertion is not testing what is indicated in the description.
21. Don't comment out tests. Alias `xit` to ignored tests in your RSpec config to quickly toggle a test to an ignored state.
26. Contexts should be descriptive and generally refer to a state or condition. They are not a catch-all organizational tool.
27. There is rarely a good reason to use `before(:all)`. Favor `let` and `let!` for simple instantiation of objects instead of instance variables.
29. There is no need to persist this object. Use mocks/stubs when the object's properties are irrelevant in the testing context.
32. This is another opportunity to use `let`. If a part of your test suite requires a complex setup procedure, those tests probably aren't sufficiently isolated. At the very least, move complex setup code into an included module.
36. Database transactions are slow. Don't persist more objects than you need to. With proper use of factories and mocks, this often means that you don't need to persist anything!
38. When creating objects for shared use among tests, make sure all tests in that context actually need those objects, since these objects are repeatedly destroyed and recreated.
44. Examine only one behavior per test.
49. Use `describe` instead of `context` to group tests if referring to an actual method or functionality.
54. This is another example of a description in need of rewriting.
55. Are you testing the functionality of the instance method or the code in the `before(:each)` block? Keep your tests simple and isolated.
59. Use a `describe '#has_orders'` block to contain tests relating to a single instance method.
60. If there is a built-in matcher available, like `be_true`, use it.