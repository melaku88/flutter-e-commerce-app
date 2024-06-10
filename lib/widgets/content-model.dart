class OnboardingContent{
  String image;
  String title;
  String description;
  OnboardingContent({required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [

  OnboardingContent(
    image: 'images/screen1.png', 
    title: 'Select Your Best\n   And Order Us', 
    description: 'Pick your product from our shop menu\n More than infinite times'
  ),
    
  OnboardingContent(
    image: 'images/screen2.png', 
    title: 'Easy and Online\n     Payment', 
    description: 'You can pay cash on delivery and\nor Card payment is available'
  ),
    
  OnboardingContent(
    image: 'images/screen3.png', 
    title: 'Quick Delivery at\n   Your Doorstep', 
    description: 'Deliver your products at your\nDoorstep'
  ),

];