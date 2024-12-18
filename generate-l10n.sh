#!/bin/bash

flutter gen-l10n \
  --arb-dir ./lib/l10n/app \
  --template-arb-file app_en.arb \
  --output-localization-file app_localizations.dart \
  --output-class AppLocalizations \
  || { echo "Error generating app l10n"; exit 1; }

flutter gen-l10n \
  --arb-dir ./lib/l10n/errors \
  --template-arb-file errors_en.arb \
  --output-localization-file errors_localizations.dart \
  --output-class ErrorsLocalizations \
  || { echo "Error generating error messages l10n"; exit 1; }

  flutter gen-l10n \
  --arb-dir ./lib/l10n/success \
  --template-arb-file success_en.arb \
  --output-localization-file success_localizations.dart \
  --output-class SuccessLocalizations \
  || { echo "Error generating success messages l10n"; exit 1; }

  # run script sh ./generate-l10n.sh