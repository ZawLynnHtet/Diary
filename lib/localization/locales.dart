import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("my", LocaleData.MY),
];

mixin LocaleData {
  static const String title = 'title';
  static const String newcase = 'newcase';
  static const String updatecase = 'updatecase';
  static const String casedetails = 'casedetails';
  static const String home = 'home';
  static const String changePassword = 'changePassword';
  static const String forgotPassword = 'forgotPassword';
  static const String confirmResetPassword = 'confirmResetPassword';
  static const String logout = 'logout';
  static const String confirmLogout = 'confirmLogout';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String previousdate = 'previousdate';
  static const String caseNo = 'caseNo';
  static const String client = 'client';
  static const String action = 'action';
  static const String todo = 'todo';
  static const String nextdate = 'nextdate';
  static const String save = 'save';
  static const String requiredPrevious = 'requiredPrevious';
  static const String requiredClient = 'requiredClient';
  static const String requiredAction = 'requiredAction';
  static const String requiredToDo = 'requiredToDo';
  static const String requiredCaseNo = 'requiredCaseNo';
  static const String requiredAppointment = 'requiredAppointment';
  static const String ongoingcaseList = 'ongoingcaseList';
  static const String edit = 'edit';
  static const String delete = 'delete';
  static const String confirmDelete = 'confirmDelete';
  static const String update = 'update';
  static const String cancel = 'cancel';
  static const String note = 'note';
  static const String books = 'books';
  static const String forInquiry = 'forInquiry';
  static const String empty = 'Empty';
  static const String addSections = 'addSections';
  static const String bookName = 'bookName';
  static const String bookTitle = 'bookTitle';
  static const String secTitle = 'secTitle';
  static const String changePsw = 'changePsw';
  static const String oldPsw = 'oldPsw';
  static const String newPsw = 'newPsw';
  static const String search = 'search';
  static const String attachment = 'attachment';
  static const String type = 'type';
  static const String chapters = 'chapters';
  static const String section = 'section';
  static const String features = 'features';
  static const String des1 = 'des1';
  static const String des2 = 'des2';
  static const String diaryshow = 'diaryshow';
  static const String errormsg = 'errormsg';
  static const String emptymsg = 'emptymsg';



  static const Map<String, dynamic> EN = {
    title: 'Law Diary',
    newcase: 'New Case',
    updatecase: 'Update Case',
    casedetails: "Case Details",
    home: 'Home',
    changePassword: 'Change Password',
    forgotPassword: 'Forgot Password',
    confirmResetPassword: "Are you sure to reset your password?",
    logout: 'Log Out',
    confirmLogout: 'Are you sure to Log Out?',
    yes: 'Yes',
    no: 'No',
    previousdate: 'Previous Date',
    caseNo: 'Case No',
    client: 'Client',
    action: 'Action',
    todo: 'To Do',
    nextdate: 'Next Date',
    save: 'Save',
    requiredPrevious: 'Enter Previous Date',
    requiredClient: 'Enter Client Name',
    requiredAction: 'Enter Action',
    requiredToDo: 'Enter To Do',
    requiredCaseNo: 'Enter Case No',
    requiredAppointment: 'Enter Appointment Date',
    ongoingcaseList: 'On Going Case List',
    edit:'Edit',
    delete: 'Delete',
    confirmDelete: 'Are you sure to Delete?',
    update: 'Update',
    cancel: 'Cancel',
    note: 'Notes',
    books: 'Law Books',
    forInquiry: 'For Inquiry',
    empty: 'Empty',
    addSections: 'Add Sections',
    bookName: 'Enter Book Name',
    bookTitle: 'Title',
    secTitle: 'Foundations and Philosophy',
    changePsw: 'Change Your Password',
    oldPsw: 'Enter Old Password',
    newPsw: 'Enter New Password',
    search: 'Search',
    attachment: 'Attachments',
    type: 'Type Something.....',
    chapters: 'Chapters',
    section: 'Section',
    features: 'Features',
    des1: 'View and manage daily diary entries.',
    des2: 'Access your law-related books.',
    diaryshow: 'You have successfully added the book',
    errormsg: 'Error Message',
    emptymsg: 'No data, please create new',
  };

  static const Map<String, dynamic> MY = {
    title: 'နေ့စဉ်မှတ်တမ်း',
    newcase: 'အမှုအသစ်အပ်ပါ',
    updatecase: 'အမှုကိုပြန်ပြင်ပါ',
    casedetails: "အမှုအသေးစိတ်",
    home: 'ပင်မစာမျက်နှာ',
    changePassword: 'လျှို့ဝှက်နံပါတ်ပြောင်းရန်',
    forgotPassword: 'လျှို့ဝှက်နံပါတ်မေ့နေပါသလား',
    confirmResetPassword: "လျှို့ဝှက်နံပါတ်ပြန်ရိုက်ရန် သေချာပါသလား",
    logout: 'ထွက်ရန်',
    confirmLogout: 'ထွက်ရန် သေချာပါသလား',
    yes: 'ဟုတ်ပါတယ်',
    no: 'မဟုတ်ပါ',
    previousdate: 'အရင်ရုံးချိန်းရက်',
    caseNo: 'အမှုနံပါတ်',
    client: 'အမှုသည်',
    todo: 'ဆောင်ရွက်ချက်',
    action: 'ဆောင်ရွက်ရန်',
    nextdate: 'နောက်ရုံးချိန်းရက်',
    save: 'သိမ်းရန်',
    requiredPrevious: 'ယခင်ရုံးချိန်းရက်ထည့်ပါ',
    requiredClient: 'အမှုသည်နာမည်ထည့်ပါ',
    requiredAction: 'ဆောင်ရွက်ရန်ထည့်ပါ',
    requiredToDo: 'ဆောင်ရွက်ချက်ထည့်ပါ',
    requiredCaseNo: 'အမှုနံပါတ်ထည့်ပါ',
    requiredAppointment: 'ရုံးချိန်းရက်ထည့်ပါ',
    ongoingcaseList: 'ဆောင်ရွက်ဆဲအမှုစာရင်',
    edit: 'ပြုပြင်ရန်',
    delete: 'ဖျက်ရန်',
    confirmDelete: 'ဖျက်ရန်သေချာပါသလား',
    update: 'ပြင်ဆင်မည်',
    cancel: 'မလုပ်တော့ပါ',
    note: 'မှတ်ချက်',
    books: 'ဥပဒေစာအုပ်များ',
    forInquiry: 'စုံစမ်းရန်',
    empty: 'မရှိပါ',
    addSections: 'အပိုင်းများးထည့်ပါ',
    bookName: 'စာအုပ်အမည်ထည့်ပါ',
    bookTitle: 'ခေါင်းစဉ်',
    secTitle: 'အခြေခံနှင့် ဖလောဆိုးဖီ',
    changePsw: 'သင်၏ စကားဝှက်ကို ပြောင်းပါ',
    oldPsw: 'စကားဝှက်ဟောင်းထည့်ပါ',
    newPsw: 'စကားဝှက်အသစ်ထည့်ပါ',
    search: 'ရှာဖွေပါ',
    attachment: 'တွဲဖိုင်များ',
    type: 'တစ်ခုခုရိုက်ပါ.....',
    chapters: 'အခန်းတွဲများ',
    section: 'အပိုင်း',
    features: 'လုပ်ဆောင်နိုင်သောအရာများ',
    des1: 'နေ့စဉ်မှတ်တမ်းများကို ကြည့်ရှုရန်',
    des2: 'ဥပဒေ စာအုပ်များကို အသုံးပြုနိုင်ရန်',
    diaryshow: 'ကိုယ်တိုင်စာအုပ်အောင်မြင်စွာထည့်ထားပါပြီ',
    errormsg: 'တစ်စုံတစ်ခုမှားနေသည်',
    emptymsg: 'ဒေတာများမရှိပါ ကျေးဇူးပြုပြီး အသစ်ဖန်တီးပါ',
    // des1: 'နေ့စဉ်မှတ်တမ်းများကို ကြည့်ရှုပြီး စီမံခန့်ခွဲရန်',
  };
}
