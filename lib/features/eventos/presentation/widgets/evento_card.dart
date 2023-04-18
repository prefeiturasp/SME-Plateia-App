import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sme_plateia/core/extensions/datetime_extension.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/gen/assets.gen.dart';

class EventoCard extends StatelessWidget {
  final EventoResumo eventoResumo;
  final void Function()? onTap;

  EventoCard(
    this.eventoResumo, {
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Ink(
        height: 88.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                _buildImagem(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTitulo(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildData(),
                            _buildHorario(),
                          ],
                        ),
                        _buildLocal(),
                      ],
                    ),
                  ),
                ),
                Assets.icons.arrowCard.svg(width: 12),
                SizedBox(
                  width: 16.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagem() {
    return FastCachedImage(
      url: eventoResumo.urlPoster,
      fit: BoxFit.cover,
      width: 122.w,
      height: 88.h,
      errorBuilder: (context, error, stackTrace) {
        return Assets.images.eventoGenerico.image(
          width: 122.w,
          height: 88.h,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildTitulo() {
    return Text(
      eventoResumo.nome,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Color(0xffC25F14),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildData() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_today_outlined,
          color: Color(0xffC25F14),
          size: 16,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          eventoResumo.dataHora.formatddMMyyy(),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildHorario() {
    return Row(
      children: [
        Icon(
          Icons.alarm_outlined,
          color: Color(0xffC25F14),
          size: 16,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          eventoResumo.dataHora.formatHHmm(),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildLocal() {
    return Text(
      eventoResumo.local,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        color: Color(
          0xff4F4F4F,
        ),
      ),
    );
  }
}
