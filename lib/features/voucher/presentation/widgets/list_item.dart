import 'package:flutter/widgets.dart';
import 'package:sme_plateia/core/utils/colors.dart';

class ListItemWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const ListItemWidget({required this.title, required this.icon, this.subtitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(icon, color: TemaUtil.laranja01),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) SizedBox(height: 8.0),
                if (subtitle != null)
                  Text(subtitle!,
                      style: TextStyle(
                        fontSize: 16,
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
