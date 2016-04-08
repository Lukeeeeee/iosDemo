using System;

using UIKit;
using Foundation;

namespace AnimatedConstraints
{
	public partial class ViewController : UIViewController
	{
		public ViewController ()
		{
			
		}

		public ViewController (IntPtr handle) : base (handle)
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			bool isBlue = true;
			bool isRed = true;
			// Perform any additional setup after loading the view, typically from a nib.

			UIButton redButton = new UIButton ();
			redButton.BackgroundColor = UIColor.Red;
			redButton.TranslatesAutoresizingMaskIntoConstraints = false;

			Add (redButton);

			UIButton greenButton = new UIButton ();
			greenButton.BackgroundColor = UIColor.Green;
			greenButton.TranslatesAutoresizingMaskIntoConstraints = false;
			Add (greenButton);

			View.AddConstraint (NSLayoutConstraint.Create (redButton, NSLayoutAttribute.Width, NSLayoutRelation.Equal, greenButton, NSLayoutAttribute.Width, 1, 0));
			View.AddConstraint (NSLayoutConstraint.Create (redButton, NSLayoutAttribute.Bottom, NSLayoutRelation.Equal, View, NSLayoutAttribute.Bottom, 1, -10));
			View.AddConstraint (NSLayoutConstraint.Create (redButton, NSLayoutAttribute.Top, NSLayoutRelation.Equal, View, NSLayoutAttribute.Top, 1, 10));
			View.AddConstraint (NSLayoutConstraint.Create (redButton, NSLayoutAttribute.Right, NSLayoutRelation.Equal, greenButton, NSLayoutAttribute.Left, 1, -10));
			View.AddConstraint (NSLayoutConstraint.Create (greenButton, NSLayoutAttribute.Bottom, NSLayoutRelation.Equal, View, NSLayoutAttribute.Bottom, 1, -10));
			View.AddConstraint (NSLayoutConstraint.Create (greenButton, NSLayoutAttribute.Top, NSLayoutRelation.Equal, View, NSLayoutAttribute.Top, 1, 10));

			var redLeftConstraint = NSLayoutConstraint.Create (redButton, NSLayoutAttribute.Left, NSLayoutRelation.Equal, View, NSLayoutAttribute.Left, 1, 10);
			redLeftConstraint.Priority = 750;
			View.AddConstraint (redLeftConstraint);

			var marginConstraint = NSLayoutConstraint.Create (redButton,NSLayoutAttribute.Right,NSLayoutRelation.Equal,View,NSLayoutAttribute.Right,1,-10);
			marginConstraint.Priority = 750;
			View.AddConstraint (marginConstraint);

			var constraint = NSLayoutConstraint.Create (greenButton, NSLayoutAttribute.Right, NSLayoutRelation.Equal, View, NSLayoutAttribute.Right, 1, -10);
			constraint.Priority = 750;
			View.AddConstraint (constraint);

			var blueLeftConstraint =NSLayoutConstraint.Create(greenButton,NSLayoutAttribute.Left,NSLayoutRelation.Equal,View,NSLayoutAttribute.Left,1,10);
			blueLeftConstraint.Priority = 750;
			View.AddConstraint (blueLeftConstraint);

			redButton.TouchDown += (o, s) => {
				if(isBlue)
				{
					constraint.Priority=749;
					blueLeftConstraint.Priority=749;
					isBlue=false;
					isRed=true;
					UIView.Animate(1,this.View.LayoutIfNeeded);
				}
				else
				{
					constraint.Priority=750;
					blueLeftConstraint.Priority=750;
					isBlue=true;
					isRed=false;
					UIView.Animate(1,this.View.LayoutIfNeeded);
				}
			};

			greenButton.TouchDown+=(o,s)=>{
				if(!isRed)
				{
					redLeftConstraint.Priority=749;
					marginConstraint.Priority=749;
					isBlue=false;
					isRed=true;
					UIView.Animate(1,this.View.LayoutIfNeeded);
				}
				else
				{
					redLeftConstraint.Priority=750;
					marginConstraint.Priority=750;
					isBlue=true;
					isRed=false;
					UIView.Animate(1,this.View.LayoutIfNeeded);
				}
			};
		}

		public override void DidReceiveMemoryWarning ()
		{
			base.DidReceiveMemoryWarning ();
			// Release any cached data, images, etc that aren't in use.
		}
	}
}

