import 'package:fitt/core/constants/app_colors.dart';
import 'package:fitt/core/constants/app_typography.dart';
import 'package:fitt/core/enum/app_route_enum.dart';
import 'package:fitt/core/utils/datetime_utils.dart';
import 'package:fitt/core/utils/extensions/app_router_extension.dart';
import 'package:fitt/core/utils/widget_alignments.dart';
import 'package:fitt/domain/entities/batch/batch.dart';
import 'package:fitt/domain/entities/club/partner_club.dart';
import 'package:fitt/presentation/components/buttons/app_elevated_button.dart';
import 'package:fitt/presentation/components/compact_map.dart';
import 'package:fitt/presentation/components/separator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentBatchSuccessPage extends StatelessWidget {
  const PaymentBatchSuccessPage({
    Key? key,
    required this.club,
    required this.batch,
  }) : super(key: key);

  final PartnerClub club;
  final Batch batch;

  @override
  Widget build(BuildContext context) {
    final duration = int.parse(batch.duration?.split(' ')[0] ?? '');
    final batchExpireAt =
        batch.duration == null || batch.duration.toString().isEmpty
            ? 'неограничено'
            : DateTimeUtils.dateFormatWithoutYear
                .format(DateTime.now().add(Duration(days: duration)));
    final batchStartAt =
        DateTimeUtils.dateFormatWithoutYear.format(DateTime.now());

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 150, 16, 32),
            child: Column(
              children: [
                Text(
                  'Оплата прошла успешно',
                  style: AppTypography.kH24B.apply(color: AppColors.kOxford),
                ),
                const SizedBox(height: 16),
                Text(
                  club.address!.shortAddress,
                  style:
                      AppTypography.kBody14.apply(color: AppColors.kOxford60),
                ),
                const Separator(
                  color: AppColors.kPrimaryBlue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: 40,
                ),
                Text(
                  'Пакет действует с $batchStartAt по $batchExpireAt\n',
                  style: AppTypography.kH14.apply(color: AppColors.kOxford),
                ),
                const SizedBox(height: 21),
                CompactMap(
                  clubCoordinates: club.address!.coordinates,
                ),
                const SizedBox(height: 180),
              ],
            ),
          ),
          BottomCenter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Text(
                    'Администратор клуба может попросить удостоверение личности. Не забудьте взять с собой паспорт.',
                    style:
                        AppTypography.kBody14.apply(color: AppColors.kOxford),
                    textAlign: TextAlign.center,
                  ),
                ),
                AppElevatedButton(
                  textButton: const Text('Отлично'),
                  onPressed: () => context.push(AppRoute.map.routeToPath),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}