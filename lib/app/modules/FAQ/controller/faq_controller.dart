import 'package:construction_technect/app/core/utils/imports.dart';

class FAQController extends GetxController{


  RxList<Map<String, String>> faqList = [
    {
      'question': 'What is Construction Technect?',
      'answer': 'Construction Technect is a platform designed to connect contractors, suppliers, and clients in the construction industry. It helps users manage projects, find services, and communicate efficiently.'
    },
    {
      'question': 'How to create an account?',
      'answer': 'To create an account, open the app and click on the Sign Up button. Enter your details including name, email, and phone number, then verify your account using the OTP sent to your registered phone number.'
    },
    {
      'question': 'How to reset password?',
      'answer': 'If you forget your password, go to the Login screen and click on "Forgot Password". Enter your registered email or phone number, and follow the instructions sent via email or SMS to reset your password.'
    },
    {
      'question': 'How to post a project?',
      'answer': 'After logging in, navigate to the "Post Project" section. Fill in the project details including title, description, budget, timeline, and required skills. Then submit the project to make it visible to relevant contractors or service providers.'
    },
    {
      'question': 'How to contact support?',
      'answer': 'You can contact support through the "Help & Support" section in the app. You can either send a message through the chat, email support@constructiontechnect.com, or call the provided support number for assistance.'
    },
    {
      'question': 'Is there a free trial?',
      'answer': 'Yes, Construction Technect offers a 7-day free trial for new users. During this period, you can explore all features including posting projects, accessing supplier information, and messaging contractors.'
    },
    {
      'question': 'Can I edit my profile?',
      'answer': 'Yes, you can edit your profile anytime. Go to the Profile tab, click "Edit Profile", and update your details such as name, profile picture, contact information, and company details.'
    },
    {
      'question': 'How to delete my account?',
      'answer': 'To delete your account, navigate to Settings > Account > Delete Account. Confirm your choice. Note that deleting your account will remove all your data, projects, and communications permanently.'
    },
    {
      'question': 'What payment methods are supported?',
      'answer': 'We support multiple payment methods including UPI, Credit/Debit cards, Net Banking, and Wallets. You can add your preferred payment method in the Payment Settings section of the app.'
    },
    {
      'question': 'Is my data secure?',
      'answer': 'Yes, we prioritize user data security. All sensitive data is encrypted and stored securely. The platform uses industry-standard security protocols, secure servers, and regular audits to ensure your information is protected.'
    },
  ].obs;


  RxList selectedIndex = [].obs;
}