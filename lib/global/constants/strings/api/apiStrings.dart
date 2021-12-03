//*Urls for Home related APIs.
class HomeUrls {
  String get homePage => '/home-page';
  String get currencyConversion => '/currency-conversion';
  String get wishAndCart => '/wish-and-cart';
  String get cartOffers => "/home/cart-offers";
  String get headerFooter => '/header-footer';
  String get feedbacks => '/home/feedback';
  String get stores => '/home/stores';
}

//*Urls for all Authentication related APIs.

//*Urls for Automobile related APIs.
class AutomobileUrls {
  String get homePage => '/automobile';
  String single(String slug) => '/automobile/detail/$slug';

  String get finder => '/automobile/finder';
  String get trending => '/automobile/trending';
  String get services => '/automobile/our-services';
  String get accessories => '/automobile/accessories';
  String get madeInNepal => '/automobile/made-in-nepal';
  String get votm => '/automobile/vehicle-of-the-month/2021/03';
  String get compareList => '/automobile/compare-list';
  String get compare => '/automobile/compare';
  String get fourWheeler => '/automobile/four-wheeler';
  String get fourWheelerFliter => '/automobile/four-wheeler/filter';
  String get twoWheeler => '/automobile/two-wheeler';
  String get twoWheelerFliter => '/automobile/two-wheeler/filter';
}

//*Urls for all Authentication related APIs.
class AuthUrls {
  String get login => '/login/user';
  String get loginOTP => '/login/otp';
  String get loginCheck => '/login/check';
  String get googleLogin => '/login/google';
  String get facebookLogin => '/login/facebook';
  String get appleLogin => '/login/apple';

  String get register => '/user-signup';
  String get registerCheck => '/register/check';
  String get validateToken => '/validate-token';

  String get logout => '/user-logout';
  String get forgotPassword => '/forgot-password';
  String get newPassword => '/new-password';
}

//*Urls for all referral Related APIS
class ReferralUrls {
  String get referral => '/referral';
  String get referralSubmit => '/referral/submit';
}

//*Urls for all Profile related APIs.

class ProfileUrls {
  String get profile => '/user-profile';
  String publicProfile(String username) => '/user/$username';
  String supplierProfile(String username) => '/store/$username';
  String get updateProfile => '/update-profile';
  String get updateProfileImage => '/update-profile-image';

  String get verifyEmail => '/verify-email';
  String get updateEmail => '/update-email';
  String get resendConfirmation => '/resend-confirmation';

  String get verifyPhone => '/verify-phone';
  String get updatePhone => '/update-phone';

  String get orderUploadImage => 'order-upload-image';
  String get orderDeleteImage => 'order-delete-image';
  String get supportTickets => 'support-tickets';

  String get resetPassword => '/new-password';
  String get changePassword => '/change-password';
  String get myApplication => '/profile/applications';
  String get myContest => '/profile/contests';
  String get myWishlist => '/user/wishlist';
  String myContestDetails(int id) => '/profile/contest/$id';
  String get redeemVoucher => "/redeem-voucher";
}

//*Urls for all static data related APIs.
class StaticDataUrls {
  String get aboutUs => '/about-us';
  String get contactUs => '/contact-us';
  String get contactForm => '/home/contact-us';
  String get privacyPolicy => '/home/privacy-policy';
  String get refundPolicy => '/home/refund-policy';
  String get faq => '/faq';
}

//*Urls for all Address related APIs.
class AddressUrls {
  String get address => '/shipping-addresses';
  String get updateAddress => '/update-shipping-address';
  String get deleteAddress => '/delete-shipping-address';
  String get addAddress => '/add-shipping-address';

  String get deliveryLocations => '/delivery-locations';
  String get locationByGPS => '/location-by-gps';
}

//*Urls for all Auction related APIs.
class AuctionUrls {
  String get sellOffers => '/profile/auction/selling/offers';
  String get productDetail => '/auction/product';
  String get auctionImage => '/profile/auction/add-images';
  String get auctionSell => '/auction/product';
  //Sell/Product Detail for Auction listing
  String get myAuction => '/profile/auction/my-auction';
  String get addToAuction => '/profile/auction/store';
  String get inProgressBids => '/profile/auction/buying/bids';
  String get deliveryLocations => '/delivery-locations';
  String get locationByGPS => '/location-by-gps';
}

//*Urls for all Blog related APIs.
class BlogUrls {
  String get list => '/blogs';
  String get details => '/blogs/';
  String get category => '/blogs/category';
  String get related => '/blogs/related';
}

//*Urls for all Blog related APIs.
class CareerUrls {
  String get careers => '/careers';
  String get careerDetails => '/careers/';
}

//*Urls for all Campaign related APIs.
class CampaignUrls {
  String get home => '/campaign/';
  String get products => '/campaign/products';
  String get stores => '/campaign/stores';
  String get offers => '/campaign/offers';
}

//*Urls for all Cart related APIs.
class CartUrls {
  String get cart => '/cart';
  String get remove => '/remove-from-cart';
  String get add => '/add-to-cart';
  String get cakeAccessory => '/cake-accessory';

  String get minPound => '/get-min-pound';
  String get calculatedPrice => '/calculate-product-price';
}

//*Urls for all Checkout related APIs.c
class CheckoutUrls {
  String get applyCoupon => 'apply-coupon';
  String get checkDeliveryAddress => '/check-delivery-location-eligibility';
  String get checkDeliveryTimeSlot => '/delivery-methods-time-slot';
  String get placeOrder => '/place-order';
}

//*Urls for all Orders related APIs.
class OrderUrls {
  String get orderListing => '/order-listing';
  String get singleOrder => '/order-detail';
  String get uploadRefImage => '/order-upload-image';
  String get deleteRefImage => '/order-delete-image';
}

//*Urls for all Connection related APIs.
class ConnectionUrls {
  String get send => '/connection/send';
  String get remove => '/connection/remove';
  String cancel(int id) => '/connection/cancel/$id';
  String accept(int id) => '/connection/accept/$id';
  String decline(int id) => '/connection/decline/$id';
  String hide(int id) => '/connection/hide/$id';
  String get list => '/connections';
}

//*Urls for all Contest related APIs.
class ContestUrls {
  String get contest => '/contests';
  String contestSingle(String slug) => '/contest/$slug';
  String contestantList(String slug) => '/contest/$slug/contestants';
  String contestantSingle(int id) => '/contest/contestant/$id';
  String get vote => '/contest/action/vote';
  String get banner => '/banner/action/click';
  String get bannerStore => '/banner/action/store';

  String nextContestant(int id) => '/contest/contestant/$id/next';
  String previousContestant(int id) => '/contest/contestant/$id/prev';
  String get participate => '/contest/action/participate';
  String get uploadFile => '/upload/file';
}

//*Urls for all Order-feedback related APIs.
class OrderFeedbackUrls {
  String getFeedback(int id) => '/order-feedback/$id';
  String get postFeedback => '/order/feedback';
  String get postComplain => '/complain';
}

//*Urls for all Order-feedback related APIs.
class FollowUrls {
  String get index => '/followers/index';
  String get add => '/followers/add';
  String get delete => '/followers/delete';
}

//*Urls for all Comments related APIs.
class CommentsUrls {
  String get parent => '/comments';
  String child(int id) => '/comments/$id';
  String get store => '/comment';
  String get delete => '/comment/delete';
  String get searchUser => 'comment/tag';
  String get report => '/report';
}

//*Urls for all Reaction related APIs.
class ReactionUrls {
  String get add => '/reactions/add';
  String get delete => '/reactions/delete';
}

//*Urls for all Review related APIs.
class ReviewUrls {
  String get add => '/review';
  String get getReviews => '/reviews';
}

class RouletteUrls {
  String getRoulette(String slug) => '/roulette/$slug';
  String playRoulette(int id) => '/roulette/play/$id';
}

class CakeFinderUrls {
  String get cakeFinder => '/suggested-cakes';
  String get cakeCategory => '/cake-categories';
}

//*Urls for all QnA related APIs.
class QnAUrls {
  String get question => '/question';
  String get answer => '/answer';
  String get qna => '/questions';
}

//*Urls for all Payment related APIs.
class PaymentUrls {
  String get allMethods => '/payment-methods';
  String get process => '/process-payment';
  String get couponCode => '/apply-coupon';
  String get khalti => '/khalti-generate-verification-code';
}

//*Urls for all Product related APIs.
class ProductUrls {
  String get collection => '/products';
  String collectionByCategory(String slug) => '/category/$slug';
  String collectionByOccasion(String slug) => '/occasion/$slug';
  String getQuickInfo(int id) => '/product/quick-info/$id';
  String single(String slug) => '/product/$slug';
  String get urgent => '/products/urgent';
  String get offers => '/products/offers';
  String get cardOffers => "/home/cart-offers";
  String get trending => '/products/trending';
  String sluggedProducts(String slug) => '/products/$slug';
  String get treasureDig => '/treasure/dig';

  String get recommended => '/products/recommended';
}

class CapmaignUrls {
  String getCampaign(String slug) => '/campaign/$slug';
  String get offers => '/campaign/offers';
  String get stores => '/campaign/stores';
  String get products => '/campaign/products';
}

class SearchUrls {
  String get search => '/search';
  String get history => '/search-history';
}

//*Urls for all Wishlist related APIs.
class WishlistUrls {
  String get wishlistDetail =>
      '/products/multiple'; //Fetches list of products from list of ids
  String get add => '/wishes/add';
  String get delete => '/wishes/delete';
  String get wishlist => '/wish-and-cart'; //wishes/index//Gets list of ids
}

class VacancyUrls {
  String get vacancy => "/careers";
  String get apply => "/career/apply";
  String get upload => "/career/upload";
  String getVacancyDetail(String slug) => "/career/$slug";
}

class LocalStorageKeys {
  static String get token => 'token';
  static String get username => 'username';
  static String get name => 'name';
  static String get email => 'email';
  static String get phoneNo => 'phoneNo';
  static String get verified => 'verified';
  static String get phoneVerified => 'phoneVerified';
  static String get code => 'countryCode';
  static String get onboardingStatus => "onboardingStatus";
  static String get isRefferedPop => "isRefferedPop";
  static String get isLogin => "isLogin";
}

class FoodUrls {
  String get home => "/food/home";
  String get featureNearby => "/food/featured";
  String foodMeal(String slug) => "/food/meal/$slug";
  String get matchPocket => "/food/pocket";
  String get pocketComparison => "/food/pocket-comparison";
  String foodMenu(String name) => "/food/restro/$name";
}
