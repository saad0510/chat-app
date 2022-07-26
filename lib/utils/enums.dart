// ignore: constant_identifier_names
enum MsgType { Text, Pdf, Link }

extension HelperFunc on MsgType {
  String toStr() => toString().split(".").last;

  MsgType fromStr(String x) {
    if (x == "Text") return MsgType.Text;
    if (x == "Pdf") return MsgType.Pdf;
    if (x == "Link") return MsgType.Link;
    throw FormatException("MsgType.fromStr($x): invalid string");
  }
}
