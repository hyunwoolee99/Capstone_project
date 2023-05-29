import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateConverter {
  static String convertToKorean(String englishDate) {
    // 로케일 데이터 초기화
    initializeDateFormatting('ko', null);

    // 영문 날짜를 DateTime 객체로 파싱
    DateTime date = DateFormat('MMMM dd, yyyy').parse(englishDate);

    // 한글 날짜 포맷을 설정
    final koreanDateFormat = DateFormat('yyyy년 M월 d일', 'ko');

    // 한글로 날짜 변환
    String koreanDate = koreanDateFormat.format(date);

    return koreanDate;
  }
}
