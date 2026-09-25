import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ZiaratAshuraApp());
}

/// -------------------- رنگ‌ها --------------------
class AppColors {
  final Color background;
  final Color cardBg;
  final Color gold;
  final Color oliveGreen;
  final Color arabicText;
  final Color translationText;
  final Color divider;

  const AppColors({
    required this.background,
    required this.cardBg,
    required this.gold,
    required this.oliveGreen,
    required this.arabicText,
    required this.translationText,
    required this.divider,
  });

  static const day = AppColors(
    background: Color(0xFFF6EFDC),
    cardBg: Colors.white,
    gold: Color(0xFFC9A24B),
    oliveGreen: Color(0xFF4B5D3A),
    arabicText: Color(0xFF2A2110),
    translationText: Color(0xFF7A7368),
    divider: Color(0xFFDDD0AE),
  );

  static const night = AppColors(
    background: Color(0xFF121212),
    cardBg: Color(0xFF1D1D1D),
    gold: Color(0xFFCBA646),
    oliveGreen: Color(0xFF6E8759),
    arabicText: Colors.white,
    translationText: Color(0xFFAFAFAF),
    divider: Color(0xFF3A3A3A),
  );
}

/// -------------------- مدل داده‌ی هر بخش از زیارت --------------------
class ZiaratSection {
  final String arabic;
  final String farsi;
  final String explanation;
  const ZiaratSection(this.arabic, this.farsi, this.explanation);
}

const List<ZiaratSection> kZiaratSections = [
  ZiaratSection(
    'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِیمِ.\nاَلسَّلامُ عَلَیْکَ یا اَبا عَبْدِ اللَّهِ، اَلسَّلامُ عَلَیْکَ یَابْنَ رَسُولِ اللَّهِ، اَلسَّلامُ عَلَیْکَ یَابْنَ اَمیرِالْمُؤْمِنینَ وَابْنَ سَیِّدِ الْوَصِیّینَ، اَلسَّلامُ عَلَیْکَ یَابْنَ فاطِمَةَ سَیِّدَةِ نِساءِ الْعالَمینَ، اَلسَّلامُ عَلَیْکَ یا ثارَ اللَّهِ وَابْنَ ثارِهِ وَالْوِتْرَ الْمَوْتُورَ، اَلسَّلامُ عَلَیْکَ وَعَلَی الْاَرْواحِ الَّتی حَلَّتْ بِفِنائِکَ، عَلَیْکُمْ مِنّی جَمیعاً سَلامُ اللَّهِ اَبَداً ما بَقیتُ وَبَقِیَ اللَّیْلُ وَالنَّهارُ. یا اَبا عَبْدِ اللَّهِ! لَقَدْ عَظُمَتِ الرَّزِیَّةُ، وَجَلَّتْ وَعَظُمَتِ الْمُصیبَةُ بِکَ عَلَیْنا وَعَلی جَمیعِ اَهْلِ الْاِسْلامِ، وَجَلَّتْ وَعَظُمَتْ مُصیبَتُکَ فِی السَّماواتِ عَلی جَمیعِ اَهْلِ السَّماواتِ.',
    'به نام خداوند بخشنده‌ی مهربان. سلام بر تو ای اباعبدالله، سلام بر تو ای فرزند رسول خدا، سلام بر تو ای فرزند امیرمؤمنان و فرزند سرور اوصیا، سلام بر تو ای فرزند فاطمه، سرور زنان جهانیان، سلام بر تو ای کسی که خون‌خواهی‌ات با خداست و ای فرزندِ آن‌که خون‌خواهی‌اش با خداست، و ای تنهای مظلومی که هنوز خون‌بهایش گرفته نشده! سلام بر تو و بر ارواح پاکی که در آستان تو فرود آمدند؛ از سوی من بر همه‌ی شما تا ابد، تا زمانی که هستم و شب و روز برقرار است، سلام خدا باد. ای اباعبدالله! به‌راستی عزای تو بزرگ و گران شد، و مصیبت تو بر ما و بر همه‌ی اهل اسلام سخت و سنگین گشت، و مصیبت تو در آسمان‌ها نیز بر همه‌ی اهل آسمان‌ها سخت و بزرگ آمد.',
    'این بخش با یاد‌آوری نسبت امام حسین (ع) با پیامبر، امیرالمؤمنین و حضرت فاطمه (س) آغاز می‌شود و جایگاه والای ایشان را نشان می‌دهد. عبارت «ثارَ اللَّه» به این معناست که خون‌خواهی امام حسین (ع) بر عهده‌ی خود خداست، و «الوتر الموتور» یعنی کسی که به‌تنهایی مظلومانه به شهادت رسید و هنوز قصاصش گرفته نشده است. سپس زائر بزرگیِ مصیبت عاشورا را نه فقط برای مسلمانان، بلکه در گستره‌ی همه‌ی آسمان‌ها توصیف می‌کند.',
  ),
  ZiaratSection(
    'فَلَعَنَ اللَّهُ اُمَّةً اَسَّسَتْ اَساسَ الظُّلْمِ وَالْجَوْرِ عَلَیْکُمْ اَهْلَ الْبَیْتِ، وَلَعَنَ اللَّهُ اُمَّةً دَفَعَتْکُمْ عَنْ مَقامِکُمْ وَاَزالَتْکُمْ عَنْ مَراتِبِکُمُ الَّتی رَتَّبَکُمُ اللَّهُ فیها، وَلَعَنَ اللَّهُ اُمَّةً قَتَلَتْکُمْ، وَلَعَنَ اللَّهُ الْمُمَهِّدینَ لَهُمْ بِالتَّمْکینِ مِنْ قِتالِکُمْ. بَرِئْتُ اِلَی اللَّهِ وَاِلَیْکُمْ مِنْهُمْ وَمِنْ اَشْیاعِهِمْ وَاَتْباعِهِمْ وَاَوْلِیائِهِمْ. یا اَبا عَبْدِ اللَّهِ! اِنّی سِلْمٌ لِمَنْ سالَمَکُمْ، وَحَرْبٌ لِمَنْ حارَبَکُمْ اِلی یَوْمِ الْقِیامَةِ. وَلَعَنَ اللَّهُ آلَ زِیادٍ وَآلَ مَرْوانَ، وَلَعَنَ اللَّهُ بَنی اُمَیَّةَ قاطِبَةً، وَلَعَنَ اللَّهُ ابْنَ مَرْجانَةَ، وَلَعَنَ اللَّهُ عُمَرَ بْنَ سَعْدٍ، وَلَعَنَ اللَّهُ شِمْراً، وَلَعَنَ اللَّهُ اُمَّةً اَسْرَجَتْ وَاَلْجَمَتْ وَتَنَقَّبَتْ لِقِتالِکَ.',
    'پس لعنت خدا بر امتی که بنیاد ظلم و ستم بر شما اهل‌بیت را نهادند، و لعنت خدا بر امتی که شما را از جایگاهتان راندند و از مرتبه‌هایی که خدا برایتان مقرر داشته بود دور ساختند، و لعنت خدا بر امتی که شما را کشتند، و لعنت خدا بر کسانی که با فراهم‌کردن زمینه، راه جنگ با شما را هموار کردند. من از آنان و از پیروان و دنباله‌روها و دوستدارانشان، به‌سوی خدا و به‌سوی شما بیزاری می‌جویم. ای اباعبدالله! همانا من تا روز قیامت با هرکه با شما در صلح است، در صلحم، و با هرکه با شما در جنگ است، در جنگم. و لعنت خدا بر خاندان زیاد و خاندان مروان، و لعنت خدا بر تمامی بنی‌امیه، و لعنت خدا بر پسر مرجانه، و لعنت خدا بر عمر بن سعد، و لعنت خدا بر شمر، و لعنت خدا بر گروهی که برای جنگ با تو زین کردند و لگام زدند و نقاب بر چهره کشیدند.',
    'این فراز، برائت (بیزاری) از عامل و زمینه‌سازان ظلم به اهل‌بیت (ع) را اعلام می‌کند. لعنت‌ها به‌ترتیب متوجه چهار گروهند: کسانی که پایه‌ی ظلم را گذاشتند، کسانی که اهل‌بیت را از جایگاه شایسته‌شان کنار زدند، کسانی که مستقیماً در کشتن امام حسین (ع) نقش داشتند، و کسانی که با فراهم‌کردن زمینه، راه جنگ با ایشان را هموار کردند. زائر با گفتن «سِلمٌ لمن سالمکم و حربٌ لمن حاربکم» موضع همیشگی خود را نسبت به دوستان و دشمنان اهل‌بیت اعلام می‌کند.',
  ),
  ZiaratSection(
    'بِاَبی اَنْتَ وَاُمّی! لَقَدْ عَظُمَ مُصابی بِکَ، فَاَسْأَلُ اللَّهَ الَّذی اَکْرَمَ مَقامَکَ وَاَکْرَمَنی بِکَ اَنْ یَرْزُقَنی طَلَبَ ثارِکَ مَعَ اِمامٍ مَنْصُورٍ مِنْ اَهْلِ بَیْتِ مُحَمَّدٍ صَلَّی اللَّهُ عَلَیْهِ وَآلِهِ. اَللّهُمَّ اجْعَلْنی عِنْدَکَ وَجیهاً بِالْحُسَیْنِ عَلَیْهِ السَّلامُ فِی الدُّنْیا وَالْآخِرَةِ. یا اَبا عَبْدِ اللَّهِ! اِنّی اَتَقَرَّبُ اِلَی اللَّهِ وَاِلی رَسُولِهِ وَاِلی اَمیرِالْمُؤْمِنینَ وَاِلی فاطِمَةَ وَاِلَی الْحَسَنِ وَاِلَیْکَ بِمُوالاتِکَ، وَبِالْبَراءَةِ مِمَّنْ قاتَلَکَ وَنَصَبَ لَکَ الْحَرْبَ، وَبِالْبَراءَةِ مِمَّنْ اَسَّسَ اَساسَ الظُّلْمِ وَالْجَوْرِ عَلَیْکُمْ، وَاَبْرَأُ اِلَی اللَّهِ وَاِلی رَسُولِهِ مِمَّنْ اَسَّسَ اَساسَ ذلِکَ وَبَنی عَلَیْهِ بُنْیانَهُ وَجَری فی ظُلْمِهِ وَجَوْرِهِ عَلَیْکُمْ وَعَلی اَشْیاعِکُمْ. بَرِئْتُ اِلَی اللَّهِ وَاِلَیْکُمْ مِنْهُمْ، وَاَتَقَرَّبُ اِلَی اللَّهِ ثُمَّ اِلَیْکُمْ بِمُوالاتِکُمْ وَمُوالاةِ وَلِیِّکُمْ.',
    'پدر و مادرم فدایت باد! به‌راستی مصیبتِ من به‌خاطر تو بزرگ است. پس از خدایی که مقام تو را گرامی داشت و مرا به‌واسطه‌ی تو گرامی داشت، درخواست می‌کنم که خون‌خواهی تو را همراه با امامی یاری‌شده از اهل‌بیت محمد صلی الله علیه و آله روزی‌ام گرداند. خدایا! مرا نزد خود به‌واسطه‌ی حسین علیه‌السلام در دنیا و آخرت آبرومند گردان. ای اباعبدالله! همانا من به‌سوی خدا و رسولش و امیرالمؤمنین و فاطمه و حسن و به‌سوی تو، با پیروی از تو تقرب می‌جویم، و از کسی که با تو جنگید و پرچم جنگ بر ضد تو برافراشت بیزاری می‌جویم، و از کسی که بنیاد ظلم و ستم بر شما را نهاد بیزاری می‌جویم، و به‌سوی خدا و رسولش، از کسی که بنیاد آن ستم را نهاد و بنایش را بر آن ساخت و در ستم و جورش بر شما و پیروانتان روان شد، بیزاری می‌جویم. من از آنان به‌سوی خدا و به‌سوی شما بیزاری می‌جویم، و به‌سوی خدا و سپس به‌سوی شما، با دوستی و پیروی از شما و دوستی و ولایتِ ولیّ شما، تقرب می‌جویم.',
    'در این فراز، زائر آرزوی همراهی با «امام منصور» (اشاره به قیام امام زمان عج برای خون‌خواهی سیدالشهدا) را مطرح می‌کند؛ همان مضمونی که در دعای عهد نیز دیدیم. سپس مفهوم «تقرب به خدا از طریق موالات اهل‌بیت» تبیین می‌شود: نزدیکی به خدا در این مکتب، از مسیر دوستی با پیامبر و امامان (ع) می‌گذرد، نه جدای از آن.',
  ),
  ZiaratSection(
    'وَبِالْبَراءَةِ مِنْ اَعْدائِکُمْ وَالنَّاصِبینَ لَکُمُ الْحَرْبَ، وَبِالْبَراءَةِ مِنْ اَشْیاعِهِمْ وَاَتْباعِهِمْ. اِنّی سِلْمٌ لِمَنْ سالَمَکُمْ، وَحَرْبٌ لِمَنْ حارَبَکُمْ، وَوَلِیٌّ لِمَنْ والاکُمْ، وَعَدُوٌّ لِمَنْ عاداکُمْ. فَاَسْأَلُ اللَّهَ الَّذی اَکْرَمَنی بِمَعْرِفَتِکُمْ وَمَعْرِفَةِ اَوْلِیائِکُمْ، وَرَزَقَنِی الْبَراءَةَ مِنْ اَعْدائِکُمْ، اَنْ یَجْعَلَنی مَعَکُمْ فِی الدُّنْیا وَالْآخِرَةِ، وَاَنْ یُثَبِّتَ لی عِنْدَکُمْ قَدَمَ صِدْقٍ فِی الدُّنْیا وَالْآخِرَةِ، وَاَسْأَلُهُ اَنْ یُبَلِّغَنِی الْمَقامَ الْمَحْمُودَ لَکُمْ عِنْدَ اللَّهِ، وَاَنْ یَرْزُقَنی طَلَبَ ثاری مَعَ اِمامٍ هُدیً ظاهِرٍ ناطِقٍ بِالْحَقِّ مِنْکُمْ.',
    'و از دشمنانتان و آنان که عَلَم جنگ با شما را برافراشتند، و از پیروان و دنباله‌روهایشان بیزاری می‌جویم. همانا من با هرکه با شما در صلح است در صلحم، و با هرکه با شما در جنگ است در جنگم، و دوستدارِ هرکه شما را دوست دارد، و دشمنِ هرکه با شما دشمنی کند هستم. پس از خدایی که مرا به شناخت شما و شناخت دوستانتان گرامی داشت، و بیزاری از دشمنانتان را روزی‌ام کرد، درخواست می‌کنم که مرا در دنیا و آخرت همراه شما قرار دهد، و گام راستینم را نزد شما در دنیا و آخرت استوار گرداند، و از او می‌خواهم که مرا به مقام ستوده‌ای که نزد خدا برای شماست برساند، و خون‌خواهی‌ام را همراه با پیشوایی هدایت‌گر، آشکار و گویای به‌حق از خاندان شما، روزی‌ام گرداند.',
    'اینجا مفهوم «موالات و برائت» (دوستی با دوستان اهل‌بیت و بیزاری از دشمنانشان) به‌صورت کامل و متقابل بیان می‌شود؛ این دو، دو رکن اصلی هویت دینی زائر در این زیارت‌اند. هم‌چنین دوباره بر انتظار برای «امام هدایتگر و گویای به‌حق» یعنی امام عصر (عج) تأکید می‌شود.',
  ),
  ZiaratSection(
    'وَاَسْأَلُ اللَّهَ بِحَقِّکُمْ وَبِالشَّأْنِ الَّذی لَکُمْ عِنْدَهُ اَنْ یُعْطِیَنی بِمُصابی بِکُمْ اَفْضَلَ ما یُعْطی مُصاباً بِمُصیبَتِهِ، مُصیبَةً ما اَعْظَمَها وَاَعْظَمَ رَزِیَّتَها فِی الْاِسْلامِ وَفی جَمیعِ السَّماواتِ وَالْاَرْضِ. اَللّهُمَّ اجْعَلْنی فی مَقامی هذا مِمَّنْ تَنالُهُ مِنْکَ صَلَواتٌ وَرَحْمَةٌ وَمَغْفِرَةٌ. اَللّهُمَّ اجْعَلْ مَحْیایَ مَحْیا مُحَمَّدٍ وَآلِ مُحَمَّدٍ، وَمَماتی مَماتَ مُحَمَّدٍ وَآلِ مُحَمَّدٍ.',
    'و به حق شما و شأن و منزلتی که نزد خدا دارید، از او می‌خواهم که به‌خاطر مصیبتم درباره‌ی شما، برترین چیزی را که به مصیبت‌دیده‌ای بابت مصیبتش می‌دهد، به من عطا کند؛ مصیبتی که چه بزرگ است و چه سنگین است عزایش در اسلام و در همه‌ی آسمان‌ها و زمین. خدایا! مرا در این جایگاه از کسانی قرار ده که درود و رحمت و آمرزش تو به آنان می‌رسد. خدایا! زندگی‌ام را زندگی محمد و آل محمد، و مرگم را مرگ محمد و آل محمد قرار ده.',
    'دعای «اجعل محیای محیا محمد و آل محمد» یکی از پرتکرارترین و شناخته‌شده‌ترین فرازهای این زیارت است: زائر آرزو می‌کند سبک زندگی و حتی مرگش هم‌سو و هم‌راستا با راه پیامبر و اهل‌بیت (ع) باشد، نه صرفاً یک آرزوی کلی برای نیکی.',
  ),
  ZiaratSection(
    'اَللّهُمَّ اِنَّ هذا یَوْمٌ تَبَرَّکَتْ بِهِ بَنُو اُمَیَّةَ، وَابْنُ آکِلَةِ الْاَکْبادِ، اللَّعینُ ابْنُ اللَّعینِ عَلی لِسانِکَ وَلِسانِ نَبِیِّکَ صَلَّی اللَّهُ عَلَیْهِ وَآلِهِ فی کُلِّ مَوْطِنٍ وَمَوْقِفٍ وَقَفَ فیهِ نَبِیُّکَ صَلَّی اللَّهُ عَلَیْهِ وَآلِهِ. اَللّهُمَّ الْعَنْ اَبا سُفْیانَ وَمُعاوِیَةَ وَیَزیدَ بْنَ مُعاوِیَةَ، عَلَیْهِمْ مِنْکَ اللَّعْنَةُ اَبَدَ الْآبِدینَ. وَهذا یَوْمٌ فَرِحَتْ بِهِ آلُ زِیادٍ وَآلُ مَرْوانَ بِقَتْلِهِمُ الْحُسَیْنَ صَلَواتُ اللَّهِ عَلَیْهِ. اَللّهُمَّ فَضاعِفْ عَلَیْهِمُ اللَّعْنَ مِنْکَ وَالْعَذابَ الْاَلیمَ.',
    'خدایا! امروز روزی است که بنی‌امیه، و آن فرزندِ جگرخوار -آن نفرین‌شده، فرزند نفرین‌شده بر زبان تو و زبان پیامبرت صلی الله علیه و آله، در هر جایی که پیامبرت در آن ایستاد- بدان تبرک جستند. خدایا! ابوسفیان و معاویه و یزید بن معاویه را لعنت کن؛ لعنت تو تا ابد بر آنان باد. و امروز روزی است که خاندان زیاد و خاندان مروان به‌خاطر کشتنِ حسین که درود خدا بر او باد، شادمان شدند. خدایا! پس لعنت و عذاب دردناک خود را بر آنان دوچندان کن.',
    '«اِبْنُ آکِلَةِ الْاَکْبادِ» یعنی «پسرِ آن زنِ جگرخوار» و لقبی برای معاویه است -نه اینکه خودِ او را جگرخوار خوانده باشند- چرا که مادرش هند بود که در جنگ اُحد به بدن حمزه سیدالشهدا (عموی پیامبر) مثله کرد؛ این عبارت ریشه‌ی دشمنی خاندان اموی با اهل‌بیت (ع) را نسل‌به‌نسل نشان می‌دهد. زائر در این بخش به‌طور مشخص ابوسفیان، معاویه و یزید را نام می‌برد تا مسئولیت تاریخی این جنایت به‌صراحت مشخص شود.',
  ),
  ZiaratSection(
    'اَللّهُمَّ اِنّی اَتَقَرَّبُ اِلَیْکَ فی هذَا الْیَوْمِ، وَفی مَوْقِفی هذا وَاَیّامِ حَیاتی، بِالْبَراءَةِ مِنْهُمْ وَاللَّعْنَةِ عَلَیْهِمْ، وَبِالْمُوالاةِ لِنَبِیِّکَ وَآلِ نَبِیِّکَ عَلَیْهِ وَعَلَیْهِمُ السَّلامُ. اَللّهُمَّ الْعَنْ اَوَّلَ ظالِمٍ ظَلَمَ حَقَّ مُحَمَّدٍ وَآلِ مُحَمَّدٍ، وَآخِرَ تابِعٍ لَهُ عَلی ذلِکَ. اَللّهُمَّ الْعَنِ الْعِصابَةَ الَّتی جاهَدَتِ الْحُسَیْنَ، وَشایَعَتْ وَبایَعَتْ وَتابَعَتْ عَلی قَتْلِهِ. اَللّهُمَّ الْعَنْهُمْ جَمیعاً.',
    'خدایا! من در این روز و در این جایگاه و در همه‌ی روزهای زندگی‌ام، با بیزاری از آنان و لعنت‌کردن ایشان، و با دوستی و پیروی از پیامبرت و آل پیامبرت که درود بر او و بر ایشان باد، به تو تقرب می‌جویم. خدایا! نخستین ستمگری را که به حق محمد و آل محمد ستم کرد، و آخرین پیرو او در این ستم را، لعنت کن. خدایا! گروهی را که با حسین جنگیدند و او را همراهی و بیعت و پیروی کردند تا او را بکشند، لعنت کن. خدایا! همه‌ی آنان را لعنت کن.',
    'همین فراز، فرمول معروفِ «صد بار لعن» است که در بخش شمارنده‌ی برنامه استفاده می‌شود. توجه کنید که لعنت متوجه سه سطح است: کسی که بنیان ظلم را گذاشت (در برخی تفاسیر، اشاره به غصب خلافت)، آخرین پیرو او، و گروهی که مستقیماً در کشتن امام حسین (ع) شرکت کردند.',
  ),
  ZiaratSection(
    'اَلسَّلامُ عَلَیْکَ یا اَبا عَبْدِ اللَّهِ، وَعَلَی الْاَرْواحِ الَّتی حَلَّتْ بِفِنائِکَ، عَلَیْکَ مِنّی سَلامُ اللَّهِ اَبَداً ما بَقیتُ وَبَقِیَ اللَّیْلُ وَالنَّهارُ، وَلا جَعَلَهُ اللَّهُ آخِرَ الْعَهْدِ مِنّی لِزِیارَتِکُمْ. اَلسَّلامُ عَلَی الْحُسَیْنِ، وَعَلی عَلِیِّ بْنِ الْحُسَیْنِ، وَعَلی اَوْلادِ الْحُسَیْنِ، وَعَلی اَصْحابِ الْحُسَیْنِ.',
    'سلام بر تو ای اباعبدالله، و بر ارواحی که در آستان تو فرود آمدند؛ از سوی من بر تو تا ابد، تا زمانی که هستم و شب و روز برقرار است، سلام خدا باد، و خدا این زیارت را آخرین پیمانِ من با شما قرار ندهد. سلام بر حسین، و بر علی بن الحسین، و بر فرزندان حسین، و بر یاران حسین.',
    'این فراز، فرمول معروفِ «صد بار سلام» است که بعد از صد بار لعن گفته می‌شود؛ بخش شمارنده‌ی برنامه از همین متن استفاده می‌کند. با این سلام، زائر پیوند خود را نه‌فقط با امام حسین (ع)، بلکه با فرزندان و یاران باوفای او نیز تجدید می‌کند و آرزو می‌کند این زیارت، آخرین دیدار او با ایشان نباشد.',
  ),
  ZiaratSection(
    'اَللّهُمَّ خُصَّ اَنْتَ اَوَّلَ ظالِمٍ بِاللَّعْنِ مِنّی، وَابْدَأْ بِهِ اَوَّلاً، ثُمَّ الثَّانِیَ، ثُمَّ الثَّالِثَ، ثُمَّ الرَّابِعَ. اَللّهُمَّ الْعَنْ یَزیدَ خامِساً، وَالْعَنْ عُبَیْدَ اللَّهِ بْنَ زِیادٍ، وَابْنَ مَرْجانَةَ، وَعُمَرَ بْنَ سَعْدٍ، وَشِمْراً، وَآلَ اَبی سُفْیانَ، وَآلَ زِیادٍ، وَآلَ مَرْوانَ، اِلی یَوْمِ الْقِیامَةِ.',
    'خدایا! نخستین ستمگر را به‌ویژه به لعنتِ من مخصوص گردان، و لعنت را از او آغاز کن، سپس دومی، سپس سومی، سپس چهارمی. خدایا! یزید را پنجمین آنان لعنت کن، و عبیدالله بن زیاد را، و پسر مرجانه را، و عمر بن سعد را، و شمر را، و خاندان ابوسفیان و خاندان زیاد و خاندان مروان را تا روز قیامت لعنت کن.',
    'در این‌جا چهار نفر نخست (که در برخی تفاسیر به خلفای پیش از امیرالمؤمنین علی (ع) تعبیر شده‌اند) به‌صورت ضمنی و با شماره لعنت می‌شوند، و سپس یزید به‌عنوان پنجمین، و در ادامه عاملان مستقیم واقعه‌ی کربلا (ابن‌زیاد، عمر بن سعد، شمر) به‌صراحت نام برده می‌شوند.',
  ),
  ZiaratSection(
    'اَللّهُمَّ لَکَ الْحَمْدُ حَمْدَ الشّاکِرینَ لَکَ عَلی مُصابِهِمْ، اَلْحَمْدُ لِلَّهِ عَلی عَظیمِ رَزِیَّتی. اَللّهُمَّ ارْزُقْنی شَفاعَةَ الْحُسَیْنِ یَوْمَ الْوُرُودِ، وَثَبِّتْ لی قَدَمَ صِدْقٍ عِنْدَکَ مَعَ الْحُسَیْنِ وَاَصْحابِ الْحُسَیْنِ الَّذینَ بَذَلُوا مُهَجَهُمْ دُونَ الْحُسَیْنِ عَلَیْهِ السَّلامُ.',
    'خدایا! سپاسِ تو را می‌گویم، سپاسِ سپاسگزارانِ تو بر مصیبتشان؛ سپاس خدای را بر مصیبت بزرگم. خدایا! شفاعت حسین را در روز ورود [به قیامت] روزی‌ام گردان، و گام راستینم را نزد خود، همراه با حسین و یارانِ حسین که جان‌های خود را در راه او نثار کردند، استوار بدار.',
    'زائر از خدا می‌خواهد شفاعت حسین(ع) را در روز ورود و گام صدقش را نزد خدا همراه حسین و یاران حسین استوار کند.',
  ),
];

const String kLaanPhrase =
    'اَللّهُمَّ الْعَنْ اَوَّلَ ظالِمٍ ظَلَمَ حَقَّ مُحَمَّدٍ وَآلِ مُحَمَّدٍ، وَآخِرَ تابِعٍ لَهُ عَلی ذلِکَ. اَللّهُمَّ الْعَنِ الْعِصابَةَ الَّتی جاهَدَتِ الْحُسَیْنَ وَشایَعَتْ وَبایَعَتْ وَتابَعَتْ عَلی قَتْلِهِ. اَللّهُمَّ الْعَنْهُمْ جَمیعاً.';

const String kSalamPhrase =
    'اَلسَّلامُ عَلَیْکَ یا اَبا عَبْدِ اللَّهِ، وَعَلَی الْاَرْواحِ الَّتی حَلَّتْ بِفِنائِکَ، عَلَیْکَ مِنّی سَلامُ اللَّهِ اَبَداً ما بَقیتُ وَبَقِیَ اللَّیْلُ وَالنَّهارُ، وَلا جَعَلَهُ اللَّهُ آخِرَ الْعَهْدِ مِنّی لِزِیارَتِکُمْ، اَلسَّلامُ عَلَی الْحُسَیْنِ وَعَلی عَلِیِّ بْنِ الْحُسَیْنِ وَعَلی اَوْلادِ الْحُسَیْنِ وَعَلی اَصْحابِ الْحُسَیْنِ.';

/// -------------------- مداحان --------------------
class Reciter {
  final String id;
  final String name;
  final String file;
  const Reciter(this.id, this.name, this.file);
}

const List<Reciter> kReciters = [
  Reciter('samavati', 'سماواتی', 'samavati.mp3'),
  Reciter('alifani', 'علی فانی', 'alifani.mp3'),
  Reciter('mirdamad', 'میرداماد', 'mirdamad.mp3'),
  Reciter('hadadian', 'حدادیان', 'hadadian.mp3'),
  Reciter('farahmand', 'فرهمند', 'farahmand.mp3'),
];

const int kDefaultReciterIndex = 4; // فرهمند

/// -------------------- درباره‌ی زیارت عاشورا --------------------
class AboutTopic {
  final String title;
  final String body;
  const AboutTopic(this.title, this.body);
}

const List<AboutTopic> kAboutTopics = [
  AboutTopic(
    'معرفی زیارت عاشورا',
    'زیارت عاشورا یکی از مشهورترین و پرفضیلت‌ترین زیارت‌های امام حسین علیه‌السلام است که با سلام و بزرگداشت آن حضرت و یارانش آغاز می‌شود، مصیبت بزرگ عاشورا را یادآوری می‌کند، از عاملان و زمینه‌سازان این جنایت اعلام بیزاری می‌کند، و پیوند و وفاداری زائر را با اهل‌بیت (ع) و آرمان خون‌خواهی امام حسین (ع) تجدید می‌نماید. این زیارت را می‌توان هم از نزدیک (کنار ضریح مطهر در کربلا) و هم از راه دور، در هر نقطه از جهان خواند.',
  ),
  AboutTopic(
    'جایگاه زیارت در منابع شیعه',
    'متن این زیارت را شیخ طوسی، از بزرگان قرن پنجم هجری، در کتاب «مصباح المتهجد» با سند از امام محمد باقر علیه‌السلام نقل کرده است. علامه مجلسی نیز آن را در «بحارالانوار» آورده، و بعدها در کتاب‌های دعای رایج مانند «مفاتیح‌الجنان» شیخ عباس قمی جای گرفته و به یکی از شناخته‌شده‌ترین اذکار شیعیان در سراسر جهان تبدیل شده است.',
  ),
  AboutTopic(
    'زمان و شیوه‌ی خواندن',
    'زیارت عاشورا در روایات با تأکید بر خواندن هر روز و به‌ویژه در بامدادان یاد شده است، هرچند خواندن آن در هر زمان و هر روزی از سال ثواب دارد و در ایام محرم و روز عاشورا اهمیتی مضاعف می‌یابد. شیوه‌ی رایج این‌گونه است: زائر متن اصلی زیارت را می‌خواند، سپس صد بار فراز «اللهم العن اول ظالم...» را برای لعن، و صد بار فراز «السلام علیک یا اباعبدالله...» را برای سلام تکرار می‌کند، و در پایان بخش‌های نهایی زیارت را می‌خواند. کسانی که فرصت صد بار تکرار را ندارند، می‌توانند به یک‌بار (به قصد رجا) بسنده کنند.',
  ),
  AboutTopic(
    'فضیلت زیارت عاشورا',
    'در روایات آمده که این زیارت، دعایی است که فرشتگان آن را زمزمه می‌کنند و خواندن آن با نیت خالص، ثواب زیارت حضوری امام حسین علیه‌السلام را برای زائر به ارمغان می‌آورد، هرچند دور از کربلا باشد. هم‌چنین از امام صادق علیه‌السلام روایت شده که هر که با خواندن این زیارت، جدش حسین علیه‌السلام را زیارت کند، خداوند هر حاجت دنیوی و اخروی او را برآورده می‌سازد.',
  ),
  AboutTopic(
    'روایات مرتبط',
    'علقمة بن محمد حضرمی، راوی اصلی این زیارت، نقل می‌کند که امام باقر علیه‌السلام پس از آموزش این زیارت به او فرمود: اگر هر روز می‌توانی امام حسین علیه‌السلام را با این زیارت زیارت کنی، چنین کن. هم‌چنین در روایتی از امام صادق علیه‌السلام آمده که مداومت بر خواندن آن، نشانه‌ی معرفت و بصیرت زائر نسبت به جایگاه امام حسین علیه‌السلام است.',
  ),
  AboutTopic(
    'شرح فرازهای مهم',
    'برای شرح دقیق‌تر هر فراز، کافی است در صفحه‌ی «متن زیارت» روی هر بخش ضربه بزنید تا توضیح مختصر همان فراز نمایش داده شود. به‌طور خلاصه: فرازهای آغازین جایگاه امام حسین (ع) را معرفی می‌کنند، فرازهای میانی برائت و موالات را بیان می‌کنند، فراز «اجعل محیای محیا محمد و آل محمد» آرزوی هم‌سویی کامل با راه اهل‌بیت است، و فرازهای پایانی به لعن عاملان کربلا و درخواست شفاعت اختصاص دارند.',
  ),
  AboutTopic(
    'توضیح معنای لعن و سلام',
    '«لعن» در این زیارت به‌معنای دور کردن از رحمت الهی است و متوجه کسانی می‌شود که آگاهانه در ظلم به اهل‌بیت (ع) و به‌ویژه در جنایت کربلا نقش داشتند؛ این لعن، اعلام برائت از راه و رفتار ظالمانه‌ی آنان است، نه یک نفرین شخصی و کینه‌توزانه. در مقابل، «سلام» تجدید پیمان محبت و وفاداری با امام حسین علیه‌السلام، فرزندان و یاران باوفای اوست. این دو فراز مکمل یکدیگرند: بیزاری از ظلم، و پیوند با حق.',
  ),
  AboutTopic(
    'منابع و مراجع',
    'متن عربی و مضمون توضیحات این بخش بر پایه‌ی نسخه‌ی رایج زیارت عاشورا در کتاب «مصباح المتهجد» شیخ طوسی و کتاب دعای «مفاتیح‌الجنان» شیخ عباس قمی تنظیم شده است. برای مطالعه‌ی بیشتر می‌توانید به همین دو منبع و نیز شرح‌های معتبر بر مفاتیح‌الجنان مراجعه کنید.',
  ),
];

/// -------------------- وضعیت کلی برنامه --------------------
class AppState extends ChangeNotifier {
  bool nightMode = false;
  double arabicScale = 1.0;
  double translationScale = 1.0;
  bool showTranslation = true;
  int reciterIndex = kDefaultReciterIndex;
  bool vibration = true;
  int lastSectionIndex = 0;
  Set<int> favoriteSections = {};
  int laanCount = 0;
  int salamCount = 0;
  bool loaded = false;

  AppColors get colors => nightMode ? AppColors.night : AppColors.day;
  Reciter get reciter => kReciters[reciterIndex];

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    nightMode = prefs.getBool('nightMode') ?? false;
    arabicScale = prefs.getDouble('arabicScale') ?? 1.0;
    translationScale = prefs.getDouble('translationScale') ?? 1.0;
    showTranslation = prefs.getBool('showTranslation') ?? true;
    reciterIndex = prefs.getInt('reciterIndex') ?? kDefaultReciterIndex;
    vibration = prefs.getBool('vibration') ?? true;
    lastSectionIndex = prefs.getInt('lastSectionIndex') ?? 0;
    favoriteSections = (prefs.getStringList('favoriteSections') ?? [])
        .map((e) => int.tryParse(e) ?? -1)
        .where((e) => e >= 0)
        .toSet();
    laanCount = prefs.getInt('laanCount') ?? 0;
    salamCount = prefs.getInt('salamCount') ?? 0;
    loaded = true;
    notifyListeners();
  }

  Future<void> _saveKey(Future<void> Function(SharedPreferences) fn) async {
    final prefs = await SharedPreferences.getInstance();
    await fn(prefs);
  }

  void setNightMode(bool v) {
    nightMode = v;
    notifyListeners();
    _saveKey((p) => p.setBool('nightMode', v));
  }

  void setArabicScale(double v) {
    arabicScale = v.clamp(0.7, 1.8);
    notifyListeners();
    _saveKey((p) => p.setDouble('arabicScale', arabicScale));
  }

  void setTranslationScale(double v) {
    translationScale = v.clamp(0.7, 1.8);
    notifyListeners();
    _saveKey((p) => p.setDouble('translationScale', translationScale));
  }

  void setShowTranslation(bool v) {
    showTranslation = v;
    notifyListeners();
    _saveKey((p) => p.setBool('showTranslation', v));
  }

  void setReciterIndex(int v) {
    reciterIndex = v;
    notifyListeners();
    _saveKey((p) => p.setInt('reciterIndex', v));
  }

  void setVibration(bool v) {
    vibration = v;
    notifyListeners();
    _saveKey((p) => p.setBool('vibration', v));
  }

  void setLastSectionIndex(int v) {
    lastSectionIndex = v;
    _saveKey((p) => p.setInt('lastSectionIndex', v));
  }

  void toggleFavorite(int index) {
    if (favoriteSections.contains(index)) {
      favoriteSections.remove(index);
    } else {
      favoriteSections.add(index);
    }
    notifyListeners();
    _saveKey((p) => p.setStringList(
        'favoriteSections', favoriteSections.map((e) => e.toString()).toList()));
  }

  void incrementLaan() {
    if (laanCount < 100) laanCount++;
    notifyListeners();
    _saveKey((p) => p.setInt('laanCount', laanCount));
  }

  void incrementSalam() {
    if (salamCount < 100) salamCount++;
    notifyListeners();
    _saveKey((p) => p.setInt('salamCount', salamCount));
  }

  void resetCounters() {
    laanCount = 0;
    salamCount = 0;
    notifyListeners();
    _saveKey((p) async {
      await p.setInt('laanCount', 0);
      await p.setInt('salamCount', 0);
    });
  }

  void vibrate() {
    if (vibration) HapticFeedback.selectionClick();
  }
}

final appState = AppState();

/// -------------------- میکسین واکنش‌گر به appState --------------------
/// هر صفحه‌ای که در build() مستقیماً appState.* را می‌خواند (نه فقط از طریق
/// ListenableBuilder سراسری) باید این میکسین را داشته باشد، وگرنه تغییراتی
/// مثل اندازه‌ی متن یا حالت شب که از یک sheet دیگر اعمال می‌شوند، تا وقتی
/// خودِ همین صفحه به دلیل دیگری setState نشود، روی صفحه اعمال نمی‌شوند.
mixin AppStateListenerMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    appState.addListener(_onAppStateChanged);
  }

  @override
  void dispose() {
    appState.removeListener(_onAppStateChanged);
    super.dispose();
  }

  void _onAppStateChanged() {
    if (mounted) setState(() {});
  }
}

/// -------------------- اپ --------------------
class ZiaratAshuraApp extends StatefulWidget {
  const ZiaratAshuraApp({super.key});
  @override
  State<ZiaratAshuraApp> createState() => _ZiaratAshuraAppState();
}

class _ZiaratAshuraAppState extends State<ZiaratAshuraApp> {
  @override
  void initState() {
    super.initState();
    appState.load();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        return MaterialApp(
          title: 'زیارت عاشورا',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          builder: (context, child) => Directionality(
            textDirection: TextDirection.rtl,
            child: child ?? const SizedBox.shrink(),
          ),
          home: const _SplashGate(),
        );
      },
    );
  }
}

/// -------------------- اسپلش تمام‌صفحه --------------------
class _SplashGate extends StatefulWidget {
  const _SplashGate();
  @override
  State<_SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<_SplashGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
    Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 350),
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0B),
      body: SizedBox.expand(
        child: Image.asset(
          'assets/splash.png',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF0B0B0B)),
        ),
      ),
    );
  }
}

/// -------------------- صفحه اصلی --------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = appState.colors;
    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Stack(
          children: [
            // نقش ظریف تزئینی پس‌زمینه
            Positioned.fill(
              child: IgnorePointer(
                child: Opacity(
                  opacity: appState.nightMode ? 0.05 : 0.07,
                  child: CustomPaint(painter: _DomePatternPainter(color: c.oliveGreen)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Icon(Icons.mosque, color: c.gold, size: 46),
                  const SizedBox(height: 10),
                  Text(
                    'زیارت عاشورا',
                    style: TextStyle(color: c.gold, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'السلام علیک یا اباعبدالله',
                    style: TextStyle(
                      fontFamily: 'QuranFont',
                      color: c.arabicText.withOpacity(0.75),
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TextScreen()),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: c.gold,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: c.gold.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 6)),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'شروع زیارت',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      _quickCard(context, c, Icons.menu_book_rounded, 'متن زیارت', const TextScreen()),
                      const SizedBox(width: 12),
                      _quickCard(context, c, Icons.headphones_rounded, 'صوت', const AudioScreen()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _quickCard(context, c, Icons.menu_book, 'درباره‌ی زیارت', const AboutScreen()),
                      const SizedBox(width: 12),
                      _quickCardEmoji(context, c, '📿', 'شمارنده لعن و سلام', const CounterScreen()),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickCard(BuildContext context, AppColors c, IconData icon, String label, Widget page) {
    return _quickCardWidget(context, c, Icon(icon, color: c.oliveGreen, size: 26), label, page);
  }

  Widget _quickCardEmoji(BuildContext context, AppColors c, String emoji, String label, Widget page) {
    return _quickCardWidget(context, c, Text(emoji, style: const TextStyle(fontSize: 26)), label, page);
  }

  Widget _quickCardWidget(BuildContext context, AppColors c, Widget iconWidget, String label, Widget page) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: c.oliveGreen.withOpacity(0.35)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
          ),
          child: Column(
            children: [
              iconWidget,
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: c.arabicText, fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}


/// نقش ظریف گنبد و مناره برای پس‌زمینه‌ی صفحه اصلی
class _DomePatternPainter extends CustomPainter {
  final Color color;
  const _DomePatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final cx = size.width / 2;
    final baseY = size.height * 0.62;
    final domeRadius = size.width * 0.22;

    // گنبد
    final domeRect = Rect.fromCircle(center: Offset(cx, baseY), radius: domeRadius);
    canvas.drawArc(domeRect, 3.14159, 3.14159, false, paint);
    canvas.drawLine(Offset(cx - domeRadius, baseY), Offset(cx + domeRadius, baseY), paint);

    // نوک گنبد
    canvas.drawLine(Offset(cx, baseY - domeRadius), Offset(cx, baseY - domeRadius - 24), paint);
    canvas.drawCircle(Offset(cx, baseY - domeRadius - 30), 5, paint);

    // دو مناره
    for (final dx in [-1.0, 1.0]) {
      final minaretX = cx + dx * domeRadius * 1.7;
      canvas.drawLine(Offset(minaretX, baseY), Offset(minaretX, baseY - domeRadius * 1.6), paint);
      canvas.drawLine(
        Offset(minaretX, baseY - domeRadius * 1.6),
        Offset(minaretX, baseY - domeRadius * 1.9),
        paint,
      );
    }

    // خط پایه
    canvas.drawLine(Offset(0, baseY), Offset(size.width, baseY), paint);
  }

  @override
  bool shouldRepaint(covariant _DomePatternPainter oldDelegate) => oldDelegate.color != color;
}

/// -------------------- صفحه متن زیارت --------------------
class TextScreen extends StatefulWidget {
  const TextScreen({super.key});
  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> with AppStateListenerMixin {
  final AudioPlayer _miniPlayer = AudioPlayer();
  bool _isPlaying = false;
  final List<GlobalKey> _sectionKeys = List.generate(kZiaratSections.length, (_) => GlobalKey());

  @override
  void dispose() {
    _miniPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    appState.vibrate();
    if (_isPlaying) {
      await _miniPlayer.pause();
      setState(() => _isPlaying = false);
    } else {
      await _miniPlayer.play(AssetSource('audio/${appState.reciter.file}'));
      setState(() => _isPlaying = true);
    }
  }

  void _showExplanation(int index) {
    appState.vibrate();
    final c = appState.colors;
    showModalBottomSheet(
      context: context,
      backgroundColor: c.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (context) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, color: c.gold, size: 22),
                const SizedBox(height: 8),
                Text('توضیح این فراز', style: TextStyle(color: c.gold, fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 12),
                Text(
                  kZiaratSections[index].explanation,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: c.arabicText, fontSize: 13.5, height: 1.9),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = appState.colors;
    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(c),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
                itemCount: kZiaratSections.length,
                itemBuilder: (context, index) {
                  final section = kZiaratSections[index];
                  final isFav = appState.favoriteSections.contains(index);
                  return GestureDetector(
                    key: _sectionKeys[index],
                    onTap: () => _showExplanation(index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: c.cardBg,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  section.arabic,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'QuranFont',
                                    color: c.arabicText,
                                    fontSize: 20 * appState.arabicScale,
                                    height: 2.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => appState.toggleFavorite(index),
                              child: Icon(
                                isFav ? Icons.star : Icons.star_border,
                                color: isFav ? c.gold : c.arabicText.withOpacity(0.25),
                                size: 20,
                              ),
                            ),
                          ),
                          if (appState.showTranslation) ...[
                            _buildOrnamentDivider(c),
                            Text(
                              section.farsi,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: c.translationText,
                                fontSize: 12.5 * appState.translationScale,
                                height: 1.9,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            _buildBottomBar(c),
          ],
        ),
      ),
    );
  }

  Widget _buildOrnamentDivider(AppColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: c.divider)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('\u262B', style: TextStyle(fontSize: 18, color: c.gold)),
          ),
          Expanded(child: Container(height: 1, color: c.divider)),
        ],
      ),
    );
  }

  Widget _buildTopBar(AppColors c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: c.gold.withOpacity(0.35)))),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_forward, color: c.gold, size: 22),
          ),
          const Spacer(),
          Icon(Icons.menu_book_rounded, color: c.gold, size: 20),
          const SizedBox(width: 8),
          Text('زیارت عاشورا', style: TextStyle(color: c.gold, fontSize: 17, fontWeight: FontWeight.bold)),
          const Spacer(),
          const SizedBox(width: 22),
        ],
      ),
    );
  }

  Widget _buildBottomBar(AppColors c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 14)],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navIcon(c, Icons.settings, 'تنظیمات', () => showSettingsSheet(context)),
            _navIcon(
              c,
              appState.favoriteSections.isEmpty ? Icons.star_border : Icons.star,
              'موردعلاقه',
              () => _showFavoritesSheet(c),
            ),
            GestureDetector(
              onTap: _togglePlay,
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(shape: BoxShape.circle, color: c.gold),
                child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 28),
              ),
            ),
            _navIcon(c, Icons.tag, 'شمارنده', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CounterScreen()));
            }, emoji: '📿'),
            _navIcon(c, Icons.mic, 'مداح', () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AudioScreen()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(AppColors c, IconData icon, String tooltip, VoidCallback onTap, {String? emoji}) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: c.gold.withOpacity(0.5))),
          child: emoji != null
              ? Center(child: Text(emoji, style: const TextStyle(fontSize: 18)))
              : Icon(icon, color: c.gold, size: 19),
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _sectionKeys[index].currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 450), curve: Curves.easeInOut, alignment: 0.08);
      }
    });
  }

  void _showFavoritesSheet(AppColors c) {
    appState.vibrate();
    showModalBottomSheet(
      context: context,
      backgroundColor: c.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final favs = appState.favoriteSections.toList()..sort();
            return SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: c.gold, size: 18),
                        const SizedBox(width: 6),
                        Text('فرازهای مورد علاقه', style: TextStyle(color: c.gold, fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (favs.isNotEmpty)
                      Text(
                        'برای رفتن به متنِ فراز، رویش بزنید؛ با زدنِ ستاره از این فهرست حذف می‌شود.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: c.translationText, fontSize: 11.5),
                      ),
                    const SizedBox(height: 10),
                    if (favs.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text('هنوز فرازی را ستاره نزده‌اید.', style: TextStyle(color: c.translationText)),
                      ),
                    ...favs.map((i) {
                      final preview = kZiaratSections[i].arabic.replaceFirst('\n', ' ');
                      final short = preview.length > 40 ? '${preview.substring(0, 40)}...' : preview;
                      return ListTile(
                        title: Text(short, textAlign: TextAlign.right, style: TextStyle(fontFamily: 'QuranFont', color: c.arabicText)),
                        trailing: GestureDetector(
                          onTap: () {
                            appState.vibrate();
                            appState.toggleFavorite(i);
                            setSheetState(() {});
                          },
                          child: Icon(Icons.star, color: c.gold),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _scrollToSection(i);
                        },
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
      },
    );
  }
}

/// -------------------- تنظیمات (قابل‌فراخوانی از هر صفحه) --------------------
void showSettingsSheet(BuildContext context) {
  appState.vibrate();
  final c = appState.colors;
  showModalBottomSheet(
    context: context,
    backgroundColor: c.cardBg,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setSheetState) {
          return SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('تنظیمات', style: TextStyle(color: c.gold, fontWeight: FontWeight.bold, fontSize: 16)),
                    const Divider(height: 20),
                    SwitchListTile(
                      title: Text('حالت شب', style: TextStyle(color: c.arabicText)),
                      value: appState.nightMode,
                      activeColor: c.gold,
                      onChanged: (v) {
                        appState.setNightMode(v);
                        setSheetState(() {});
                      },
                    ),
                    SwitchListTile(
                      title: Text('نمایش ترجمه', style: TextStyle(color: c.arabicText)),
                      value: appState.showTranslation,
                      activeColor: c.gold,
                      onChanged: (v) {
                        appState.setShowTranslation(v);
                        setSheetState(() {});
                      },
                    ),
                    SwitchListTile(
                      title: Text('لرزش شمارنده', style: TextStyle(color: c.arabicText)),
                      value: appState.vibration,
                      activeColor: c.gold,
                      onChanged: (v) {
                        appState.setVibration(v);
                        setSheetState(() {});
                      },
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('اندازه‌ی متن عربی', style: TextStyle(color: c.arabicText, fontSize: 13)),
                    ),
                    Slider(
                      value: appState.arabicScale,
                      min: 0.7,
                      max: 1.8,
                      activeColor: c.gold,
                      onChanged: (v) {
                        appState.setArabicScale(v);
                        setSheetState(() {});
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('اندازه‌ی ترجمه', style: TextStyle(color: c.arabicText, fontSize: 13)),
                    ),
                    Slider(
                      value: appState.translationScale,
                      min: 0.7,
                      max: 1.8,
                      activeColor: c.gold,
                      onChanged: (v) {
                        appState.setTranslationScale(v);
                        setSheetState(() {});
                      },
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('مداح پیش‌فرض', style: TextStyle(color: c.arabicText, fontSize: 13)),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: List.generate(kReciters.length, (i) {
                        final selected = i == appState.reciterIndex;
                        return GestureDetector(
                          onTap: () {
                            appState.setReciterIndex(i);
                            setSheetState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: selected ? c.gold.withOpacity(0.15) : Colors.transparent,
                              border: Border.all(color: selected ? c.gold : c.divider),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              kReciters[i].name,
                              style: TextStyle(color: selected ? c.gold : c.arabicText, fontSize: 12.5),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// -------------------- صفحه صوت --------------------
class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});
  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> with AppStateListenerMixin {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });
    _player.onDurationChanged.listen((d) {
      if (mounted) setState(() => _duration = d);
    });
    _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _selectReciter(int index) async {
    appState.vibrate();
    await _player.stop();
    appState.setReciterIndex(index);
    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
      _duration = Duration.zero;
    });
  }

  Future<void> _togglePlay() async {
    appState.vibrate();
    if (_isPlaying) {
      await _player.pause();
    } else {
      if (_position == Duration.zero) {
        await _player.play(AssetSource('audio/${appState.reciter.file}'));
      } else {
        await _player.resume();
      }
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  Future<void> _seekBy(int seconds) async {
    appState.vibrate();
    final target = _position + Duration(seconds: seconds);
    await _player.seek(target < Duration.zero ? Duration.zero : target);
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final c = appState.colors;
    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: c.gold.withOpacity(0.35)))),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_forward, color: c.gold)),
                  const Spacer(),
                  Text('صوت زیارت', style: TextStyle(color: c.gold, fontSize: 17, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const SizedBox(width: 22),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text('انتخاب مداح', style: TextStyle(color: c.arabicText, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: kReciters.length,
                itemBuilder: (context, i) {
                  final selected = i == appState.reciterIndex;
                  return GestureDetector(
                    onTap: () => _selectReciter(i),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: selected ? c.gold.withOpacity(0.12) : c.cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: selected ? c.gold : c.divider),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.mic, color: selected ? c.gold : c.oliveGreen),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              kReciters[i].name,
                              style: TextStyle(
                                color: selected ? c.gold : c.arabicText,
                                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (selected) Icon(Icons.check_circle, color: c.gold),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              decoration: BoxDecoration(
                color: c.cardBg,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 14)],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Text(appState.reciter.name, style: TextStyle(color: c.gold, fontWeight: FontWeight.bold)),
                    Slider(
                      value: _position.inSeconds.toDouble().clamp(0, _duration.inSeconds.toDouble() == 0 ? 1 : _duration.inSeconds.toDouble()),
                      max: _duration.inSeconds.toDouble() == 0 ? 1 : _duration.inSeconds.toDouble(),
                      activeColor: c.gold,
                      onChanged: (v) => _player.seek(Duration(seconds: v.toInt())),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_fmt(_position), style: TextStyle(color: c.translationText, fontSize: 12)),
                          Text(_fmt(_duration), style: TextStyle(color: c.translationText, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: () => _seekBy(-10), icon: Icon(Icons.replay_10, color: c.oliveGreen, size: 28)),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _togglePlay,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: c.gold),
                            child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 32),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(onPressed: () => _seekBy(10), icon: Icon(Icons.forward_10, color: c.oliveGreen, size: 28)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------------------- صفحه شمارنده --------------------
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with SingleTickerProviderStateMixin, AppStateListenerMixin {
  bool _isLaanPhase = true;
  late AnimationController _bump;

  @override
  void initState() {
    super.initState();
    _bump = AnimationController(vsync: this, duration: const Duration(milliseconds: 120), upperBound: 0.08);
    _isLaanPhase = appState.laanCount < 100;
  }

  @override
  void dispose() {
    _bump.dispose();
    super.dispose();
  }

  void _tap() {
    appState.vibrate();
    _bump.forward().then((_) => _bump.reverse());
    setState(() {
      if (_isLaanPhase) {
        appState.incrementLaan();
        if (appState.laanCount >= 100) _isLaanPhase = false;
      } else {
        appState.incrementSalam();
      }
    });
  }

  void _reset() {
    appState.vibrate();
    setState(() {
      appState.resetCounters();
      _isLaanPhase = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = appState.colors;
    final phrase = _isLaanPhase ? kLaanPhrase : kSalamPhrase;
    final count = _isLaanPhase ? appState.laanCount : appState.salamCount;
    final label = _isLaanPhase ? 'لعن' : 'سلام';

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: c.gold.withOpacity(0.35)))),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_forward, color: c.gold)),
                  const Spacer(),
                  Text('شمارنده‌ی زیارت', style: TextStyle(color: c.gold, fontSize: 17, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  GestureDetector(onTap: _reset, child: Icon(Icons.refresh, color: c.gold)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _phaseChip(c, 'لعن', appState.laanCount, _isLaanPhase),
                        const SizedBox(width: 14),
                        _phaseChip(c, 'سلام', appState.salamCount, !_isLaanPhase),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: c.cardBg,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
                      ),
                      child: Text(
                        phrase,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'QuranFont', color: c.arabicText, fontSize: 17, height: 2.0),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: _tap,
                      child: AnimatedBuilder(
                        animation: _bump,
                        builder: (context, child) => Transform.scale(scale: 1 - _bump.value, child: child),
                        child: Container(
                          width: 190,
                          height: 190,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: c.gold,
                            boxShadow: [BoxShadow(color: c.gold.withOpacity(0.4), blurRadius: 20)],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(label, style: const TextStyle(color: Colors.white, fontSize: 18)),
                              const SizedBox(height: 4),
                              Text('$count / 100', style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (appState.laanCount >= 100 && appState.salamCount >= 100)
                      Text('هر دو شمارش کامل شد 🌹', style: TextStyle(color: c.oliveGreen, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _phaseChip(AppColors c, String label, int count, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? c.gold.withOpacity(0.15) : Colors.transparent,
        border: Border.all(color: active ? c.gold : c.divider),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('$label: $count/100', style: TextStyle(color: active ? c.gold : c.translationText, fontSize: 13)),
    );
  }
}

/// -------------------- صفحه درباره زیارت --------------------
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = appState.colors;
    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: c.gold.withOpacity(0.35)))),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_forward, color: c.gold)),
                  const Spacer(),
                  Text('درباره‌ی زیارت عاشورا', style: TextStyle(color: c.gold, fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const SizedBox(width: 22),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: kAboutTopics.length,
                itemBuilder: (context, i) {
                  final topic = kAboutTopics[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: c.cardBg,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.brightness_1, size: 8, color: c.gold),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(topic.title, style: TextStyle(color: c.gold, fontWeight: FontWeight.bold, fontSize: 14.5)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(topic.body, textAlign: TextAlign.justify, style: TextStyle(color: c.arabicText, fontSize: 13, height: 1.9)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
