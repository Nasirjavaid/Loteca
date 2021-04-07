import 'package:locteca/model/coinRecord.dart';
import 'package:locteca/service/coinRecordService.dart';

class CoinRecordRepository {
  Future<CoinRecord> getCoinRecord() async {
//custom delay
    // await Future.delayed(Duration(seconds: 1));

    CoinRecord coinRecord = CoinRecord();
    CoinRecordService coinRecordService = CoinRecordService();

    coinRecord = await coinRecordService.getCoinRecord();

    return coinRecord;
  }
}
