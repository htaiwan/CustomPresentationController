# CustomPresentationController

## Custom Animator

(1) Set the new class and make it a subclass of NSObject


(2) make it conform to the **UIViewControllerAnimatedTransitioning** protocol

```swift
func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval

func animateTransition(transitionContext: UIViewControllerContextTransitioning)
```
(3) presenting view controller conforms to the **UIViewControllerAnimatedTransitioning** protocol.

```swift
func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?

func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? 
```

[commit](https://github.com/htaiwan/CustomPresentationController/commit/8b50954d800b97dc43f1e18f82f3252297bc5afa)

## The transition context object

(1) The transition context object has two very handy methods that give you access to the transition players

* **viewForKey()**: This lets you access the views of the “old” and “new” view controllers via the arguments UITransitionContextFromViewKey or UITransitionContextToViewKey respectively.
* **viewControllerForKey()**: This lets you access the “old and “new” view controllers via the arguments UITransitionContextFromViewControllerKey or
UITransitionContextToViewControllerKey respectively

```swift
let containerView = transitionContext.containerView()!
let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!

```
[commit](https://github.com/htaiwan/CustomPresentationController/commit/22d0b1e58785b7083b91cd094ec40745f721af04)
