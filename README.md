PSTCustomAlertController
==================

A `AlertControler` base on [PSTAlertController](https://github.com/steipete/PSTAlertController) and [TYAlertController](https://github.com/12207480/TYAlertController).
`PSTAlertController` bring a
API similar to `UIAlertController` AlertController, and backwards compatible to iOS 7. Will use the new shiny API when you run iOS 8. It use the iOS system UI elements. `TYAlertController` is also a API similar to `UIAlertController` AlertController, but totally use custom UI elements.I'd like bring them together. So I enhanced `PSTAlertController` with custom styles, which you can just chose different sytle to swith between the system or custom UI.    

use as system AlertControler:
```
  PSTAlertController *controller = [PSTAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"No WIFI connection. Use Cellular data to download?", nil) preferredStyle:PSTAlertControllerStyleAlert];
  [controller addAction:[PSTAlertAction actionWithTitle:@"OK" style:PSTAlertActionStyleDestructive handler:nil]];
  // Cancel action on a sheet should be the last action.
  [controller addCancelActionWithHandler:nil];
  [controller showInController:self animated:YES completion:nil];
```

use as system ActionSheet:
```
  PSTAlertController *controller = [PSTAlertController alertControllerWithTitle:NSLocalizedString(@"Choose connection:",nil) message:nil preferredStyle:PSTAlertControllerStyleActionSheet];
  [controller addAction:[PSTAlertAction actionWithTitle:@"Wifi" style:PSTAlertActionStyleDefault handler:nil]];
  [controller addAction:[PSTAlertAction actionWithTitle:@"3G/4G" style:PSTAlertActionStyleDefault handler:nil]];
  // Cancel action on a sheet should be the last action.
  [controller addCancelActionWithHandler:nil];
  [controller showInController:self animated:YES completion:nil];
```

use as custom AlertControler:
```
  PSTAlertController *controller = [PSTAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"No WIFI connection. Use Cellular data to download?", nil) preferredStyle:PSTAlertControllerStyleCustomAlert];
  [controller addAction:[PSTAlertAction actionWithTitle:@"OK" style:PSTAlertActionStyleDestructive handler:nil]];
  // Cancel action on a sheet should be the last action.
  [controller addCancelActionWithHandler:nil];
  [controller showInController:self animated:YES completion:nil];
```

use as custom ActionSheet:
```
  PSTAlertController *controller = [PSTAlertController actionSheetWithTitle:NSLocalizedString(@"Choose connection:",nil) message:nil preferredStyle:PSTAlertControllerStyleCustomActionSheet ];
  [controller addAction:[PSTAlertAction actionWithTitle:@"Wifi" style:PSTAlertActionStyleDefault handler:nil]];
  [controller addAction:[PSTAlertAction actionWithTitle:@"3G/4G" style:PSTAlertActionStyleDefault handler:nil]];
  // Cancel action on a sheet should be the last action.
  [controller addCancelActionWithHandler:nil];
  [controller showInController:self animated:YES completion:nil];
```

## Compatbility

Tested with iOS 7-9, Xcode 7 and ARC.

## License

MIT, see LICENSE file.
