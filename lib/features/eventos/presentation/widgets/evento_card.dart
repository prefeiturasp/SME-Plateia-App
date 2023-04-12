import 'package:flutter/material.dart';

class EventoCard extends StatelessWidget {
  const EventoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          debugPrint("navegando para o evento");
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              _buildImagem(),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitulo(),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildData(),
                        _buildHorario(),
                      ],
                    ),
                    SizedBox(height: 4),
                    _buildLocal(),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Placeholder _buildImagem() {
    return Placeholder(
      fallbackWidth: 122,
      fallbackHeight: 88,
    );
  }

  Text _buildTitulo() {
    return Text(
      'Clássicos do cinema',
      style: TextStyle(
        color: Color(0xffC25F14),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Row _buildData() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_today_outlined,
          color: Color(0xffC25F14),
          size: 16,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '09/03/2023',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Row _buildHorario() {
    return Row(
      children: [
        Icon(
          Icons.alarm_outlined,
          color: Color(0xffC25F14),
          size: 16,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '11:30',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  _buildLocal() {
    return Text(
      'Teatro J Safra',
      style: TextStyle(
        fontSize: 14,
        color: Color(
          0xff4F4F4F,
        ),
      ),
    );
  }
}
