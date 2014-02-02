3. Configuration variables, API keys, and passwords belong in ".gitignore"d configuration files.
5. Associated records generally need `dependent: :destroy` or other behavior defined in the event of a user's deletion or destruction.
9. A single ActiveRecord callback is forgivable, but once you have multiple callbacks chained together, you should refactor your user creation process into its own class.
11. These attributes need further validation of length, formatting, and character restrictions.
14. The interpolated date calculation is interpreted only once (when your app loads), not when `User.recently_created` is called. Wrap your chained scope parameters in a lambda.
17. `self.attribute` is unnecessary except when assigning. Also, use `.join()` for string concatenation.
21. This is purely presentational and belongs in a view helper. Also, use some other string delimiter if your string includes a bunch of double quotes.
25. Here, `referral_code =` should be `self.referral_code =` since you want to assign a value to it. This code does not ensure uniqueness of the referral code as specified in the validations, either.
28. Methods not relating to the User model as a domain model probably don't belong here.
29. If you're using key-value storage like Redis for scheduled jobs, pass IDs of elements as your parameters, not entire elements.
32. Instance methods that return true or false should end in `?` per convention.
37. This violates the Law of Demeter, in addition to being a completely silly method.
41. First, use `=` for assignment and `==` for equality comparison. Second, `or` is a control flow operator and you want `||`, the logical operator. Finally, use an authorization library like CanCan instead of hard-coding these emails.
44. This method does not relate to the User domain model, so it doesn't belong in the User class.
45. Assignment of the local variable `result` is unnecessary if only used for the subsequent `if` statement.
47. Favor a "tell, don't ask" architecture when thinking about control flow.
48. If a model's method is interacting with instances of several other models, it should be refactored into its own class for ease of testing with mocks/stubs.
49. Your model shouldn't know or care about sending emails, which is yet another reason to extract this entire method.
50. Using the explicit `return` is unnecessary unless you are trying to alter the method's control flow.
57. ActiveRecord provides methods for destroying and deleting records. Use them. Destructive methods should, by convention, end in bang (`!`).
59. Dynamic `.find_by_` methods are deprecated. Use `.find(&hellip;)` or `.where(&hellip;).first` instead.
61. Never rescue from Ruby's base `Exception` class. Rescue from `StandardError` or some more specific exception you're anticipating.
62. You captured an exception but aren't re-raising any exception. What should this method return in the case of success? Failure?
73. Just an aside, but you probably want an index on this column.
76. Another aside: If this attribute is always set before creation, shouldn't it be `not null` as well?